//===- LowerLoopCarryProcessesPass.cpp - Loop-carry process desequencing --===//
//
// SPDX-FileCopyrightText: Copyright (c) 2024 NVIDIA CORPORATION & AFFILIATES.
// SPDX-License-Identifier: Apache-2.0
//
// Lowers llhd.process ops that implement a loop-carry FSM to seq.firreg +
// comb logic. Handles the pattern that CIRCT emits when lowering Verilog
// `always @*` blocks with intermediate yielded state — specifically the
// case where llhd-lower-processes / llhd-deseq both bail because the body
// has a back-edge from internal blocks to the wait's parent block
// ("control from entry and wait does not converge" / "observes 0 values").
//
// Pattern:
//   %r:N = llhd.process -> Ts... {
//     cf.br ^L(init...)
//   ^L(carry...: Ts...):
//     llhd.wait yield (carry... : Ts...), (observed...), ^body
//   ^body:
//     ... acyclic CFG, cond-branches only depend on observed/derived ...
//   ^leafK:
//     cf.br ^L(new...)
//   }
//   llhd.drv %sig, %r#i after %t if %r#cond : Ti
//   %p = llhd.prb %sig : Ti
//
// Transformation:
//   For each result index i:
//     %next_i = (mux tree over cond_br conditions, leaves = new[i])
//     %r_i    = seq.firreg %next_i clock %clk
//                   [reset (sync|async) %rst, init_i]
//                   { name = "loop_carry_i" } : Ti
//   Each llhd.drv writing %r#i into a sig and llhd.prb reading the same sig
//   become a direct connect of %r_i.
//
//===----------------------------------------------------------------------===//

#include "LowerLoopCarryProcessesPass.h"

#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Support/LLVM.h"
#include "llvm/ADT/SmallVector.h"
#include "llvm/Support/Debug.h"

#include "circt/Dialect/Comb/CombOps.h"
#include "circt/Dialect/HW/HWDialect.h"
#include "circt/Dialect/HW/HWOps.h"
#include "circt/Dialect/LLHD/LLHDDialect.h"
#include "circt/Dialect/LLHD/LLHDOps.h"
#include "circt/Dialect/Seq/SeqDialect.h"
#include "circt/Dialect/Seq/SeqOps.h"
#include "circt/Dialect/Seq/SeqTypes.h"

#define DEBUG_TYPE "lower-loop-carry-processes"

using namespace mlir;
using namespace circt;

namespace {

/// Walk the acyclic body region of a loop-carry process and compute the
/// next-state expression for the i-th loop-carry argument. Returns null
/// Value() if the structure isn't supported.
static Value computeNextState(Block *block, Block *loopHeader,
                              unsigned argIndex, OpBuilder &builder) {
  Operation *term = block->getTerminator();
  if (auto br = dyn_cast<cf::BranchOp>(term)) {
    if (br.getDest() == loopHeader) {
      if (argIndex >= br.getDestOperands().size())
        return {};
      return br.getDestOperands()[argIndex];
    }
    // Pass-through to a single-pred successor with no block args.
    Block *succ = br.getDest();
    if (std::distance(succ->pred_begin(), succ->pred_end()) != 1)
      return {};
    if (!succ->getArguments().empty())
      return {};
    return computeNextState(succ, loopHeader, argIndex, builder);
  }
  if (auto condBr = dyn_cast<cf::CondBranchOp>(term)) {
    if (!condBr.getTrueOperands().empty() || !condBr.getFalseOperands().empty())
      return {};
    Value thenVal =
        computeNextState(condBr.getTrueDest(), loopHeader, argIndex, builder);
    Value elseVal =
        computeNextState(condBr.getFalseDest(), loopHeader, argIndex, builder);
    if (!thenVal || !elseVal)
      return {};
    if (thenVal == elseVal)
      return thenVal;
    return builder.create<comb::MuxOp>(term->getLoc(), thenVal.getType(),
                                       condBr.getCondition(), thenVal, elseVal,
                                       /*twoState=*/false);
  }
  return {};
}

/// Find an existing seq.to_clock op in the surrounding module. Used as the
/// inferred clock for the synthesised firreg. Assumes a single-clock design.
static Value findExistingClock(hw::HWModuleOp module) {
  Value clock;
  module.walk([&](seq::ToClockOp op) {
    if (!clock)
      clock = op.getResult();
  });
  return clock;
}

/// Find a reset signal: reuse one already feeding a firreg in the module.
static Value findExistingReset(hw::HWModuleOp module) {
  Value reset;
  module.walk([&](seq::FirRegOp op) {
    if (!reset && op.getReset())
      reset = op.getReset();
  });
  return reset;
}

/// Hoist an op (and any uses-only-within-block computation it depends on)
/// to just before the insertion point. Lightweight version: walk operands
/// and move ops that aren't yet ahead of the insertion point.
static void hoistOpBefore(Operation *op, Operation *insertionPoint) {
  // If already before, skip.
  if (op->getBlock() == insertionPoint->getBlock() &&
      op->isBeforeInBlock(insertionPoint))
    return;
  op->moveBefore(insertionPoint);
  // Recurse on operands defined inside the same process body.
  for (Value operand : op->getOperands()) {
    Operation *defOp = operand.getDefiningOp();
    if (!defOp)
      continue;
    hoistOpBefore(defOp, op);
  }
}

/// Attempt to lower a single ProcessOp. Returns true on success.
static bool tryLowerProcess(llhd::ProcessOp processOp, hw::HWModuleOp module) {
  Region &body = processOp.getBody();
  if (body.empty())
    return false;

  // Locate the unique wait op.
  llhd::WaitOp waitOp;
  for (Block &block : body) {
    if (auto w = dyn_cast<llhd::WaitOp>(block.getTerminator())) {
      if (waitOp) {
        LLVM_DEBUG(llvm::dbgs() << "Skip process: multiple waits\n");
        return false;
      }
      waitOp = w;
    }
  }
  if (!waitOp) {
    LLVM_DEBUG(llvm::dbgs() << "Skip process: no wait\n");
    return false;
  }
  if (waitOp.getDelay()) {
    LLVM_DEBUG(llvm::dbgs() << "Skip process: wait has delay\n");
    return false;
  }

  Block *loopHeader = waitOp->getBlock();
  Block *waitDest = waitOp.getDest();

  // The entry block must be distinct from the loop header and end with
  // cf.br ^loopHeader(init...).
  Block &entry = body.front();
  if (&entry == loopHeader) {
    LLVM_DEBUG(llvm::dbgs() << "Skip process: wait in entry\n");
    return false;
  }
  auto entryBr = dyn_cast<cf::BranchOp>(entry.getTerminator());
  if (!entryBr || entryBr.getDest() != loopHeader) {
    LLVM_DEBUG(llvm::dbgs() << "Skip process: entry does not cf.br to loopHeader\n");
    return false;
  }
  SmallVector<Value> initOps(entryBr.getDestOperands().begin(),
                             entryBr.getDestOperands().end());
  if (initOps.size() != loopHeader->getNumArguments() ||
      loopHeader->getNumArguments() != waitOp.getYieldOperands().size() ||
      waitOp.getYieldOperands().size() != processOp.getNumResults()) {
    LLVM_DEBUG(llvm::dbgs() << "Skip process: arity mismatch\n");
    return false;
  }

  // Yields must equal the header's block args (pure loop-carry).
  for (auto [i, arg] : llvm::enumerate(loopHeader->getArguments())) {
    if (waitOp.getYieldOperands()[i] != arg) {
      LLVM_DEBUG(llvm::dbgs() << "Skip process: yield is not loop-carry arg\n");
      return false;
    }
  }

  // Only support integer results (so we can build a firreg).
  for (Type t : processOp.getResultTypes()) {
    if (!isa<IntegerType>(t)) {
      LLVM_DEBUG(llvm::dbgs() << "Skip process: non-integer result\n");
      return false;
    }
  }

  // Find clock + reset in the surrounding module.
  Value clock = findExistingClock(module);
  if (!clock) {
    LLVM_DEBUG(llvm::dbgs() << "Skip process: no seq.to_clock in module\n");
    return false;
  }
  Value reset = findExistingReset(module);

  // Build the next-state expressions in a builder positioned BEFORE the process,
  // since the firregs need to live there.
  OpBuilder builder(processOp);
  Location loc = processOp.getLoc();

  // Hoist every op used in the body's acyclic region to a position BEFORE
  // the process. We do this by walking ops reachable from waitDest, skipping
  // terminators that are cf.br / cf.cond_br to leaf/back-edges.
  SmallVector<Operation *> toHoist;
  for (Block &block : body) {
    if (&block == &entry || &block == loopHeader)
      continue;
    for (Operation &op : block.without_terminator()) {
      toHoist.push_back(&op);
    }
  }
  for (Operation *op : toHoist) {
    op->moveBefore(processOp);
  }

  // Compute next-state expressions; these may create comb.mux ops inserted
  // right before the process.
  SmallVector<Value> nextStates;
  for (unsigned i = 0; i < processOp.getNumResults(); i++) {
    builder.setInsertionPoint(processOp);
    Value v = computeNextState(waitDest, loopHeader, i, builder);
    if (!v) {
      LLVM_DEBUG(llvm::dbgs() << "Skip process: can't synthesize next-state\n");
      return false;
    }
    nextStates.push_back(v);
  }

  // Build seq.firreg ops, one per result.
  SmallVector<Value> newResults;
  builder.setInsertionPoint(processOp);
  for (unsigned i = 0; i < processOp.getNumResults(); i++) {
    StringAttr name = builder.getStringAttr("loop_carry_" + std::to_string(i));
    Value initVal = initOps[i];
    Value nextVal = nextStates[i];
    seq::FirRegOp firreg;
    if (reset) {
      firreg = builder.create<seq::FirRegOp>(loc, nextVal, clock, name, reset,
                                              initVal, hw::InnerSymAttr{},
                                              /*isAsync=*/true);
    } else {
      firreg = builder.create<seq::FirRegOp>(loc, nextVal, clock, name);
    }
    newResults.push_back(firreg.getResult());
  }

  // Replace process results and erase.
  for (auto [i, oldResult] : llvm::enumerate(processOp.getResults())) {
    oldResult.replaceAllUsesWith(newResults[i]);
  }
  processOp.erase();
  return true;
}

/// Pass entry point.
struct LowerLoopCarryProcessesPass
    : public PassWrapper<LowerLoopCarryProcessesPass,
                         OperationPass<hw::HWModuleOp>> {
  MLIR_DEFINE_EXPLICIT_INTERNAL_INLINE_TYPE_ID(LowerLoopCarryProcessesPass)

  StringRef getArgument() const final { return "lower-loop-carry-processes"; }
  StringRef getDescription() const final {
    return "Lower llhd.process loop-carry FSMs to seq.firreg + comb mux. "
           "Handles patterns that CIRCT's llhd-lower-processes and "
           "llhd-deseq passes bail on.";
  }

  void getDependentDialects(DialectRegistry &registry) const override {
    registry.insert<llhd::LLHDDialect, seq::SeqDialect, hw::HWDialect,
                    comb::CombDialect, cf::ControlFlowDialect>();
  }

  void runOnOperation() override {
    hw::HWModuleOp module = getOperation();

    // Phase 1: lower each loop-carry process.
    SmallVector<llhd::ProcessOp> processes;
    module.walk([&](llhd::ProcessOp p) { processes.push_back(p); });
    for (auto p : processes) {
      (void)tryLowerProcess(p, module);
    }

    // Phase 2: collapse llhd.sig / llhd.drv / llhd.prb chains created by
    // the legacy lowering. After phase 1, drv values now point at firreg
    // outputs; the sig becomes a pure feed-through and can be elided.
    SmallVector<llhd::SignalOp> sigs;
    module.walk([&](llhd::SignalOp s) { sigs.push_back(s); });
    for (auto sig : sigs) {
      llhd::DriveOp drv;
      SmallVector<llhd::ProbeOp> prbs;
      bool ok = true;
      for (Operation *user : sig.getResult().getUsers()) {
        if (auto d = dyn_cast<llhd::DriveOp>(user)) {
          if (drv) { ok = false; break; }
          drv = d;
        } else if (auto p = dyn_cast<llhd::ProbeOp>(user)) {
          prbs.push_back(p);
        } else {
          ok = false;
          break;
        }
      }
      if (!ok || !drv)
        continue;
      for (auto p : prbs) {
        p.getResult().replaceAllUsesWith(drv.getValue());
        p.erase();
      }
      drv.erase();
      sig.erase();
    }

    // Phase 3: erase llhd.constant_time ops that became dead.
    SmallVector<llhd::ConstantTimeOp> times;
    module.walk([&](llhd::ConstantTimeOp t) {
      if (t.getResult().use_empty())
        times.push_back(t);
    });
    for (auto t : times)
      t.erase();
  }
};

} // namespace

void registerLowerLoopCarryProcessesPass() {
  PassRegistration<LowerLoopCarryProcessesPass>();
}
