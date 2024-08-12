cmake_minimum_required(VERSION 3.28)
project(eq-sat-opt LANGUAGES CXX C)
set(CMAKE_CXX_STANDARD 17)

set(LLVM_DIR ~/dev/lib/llvm/build/lib/cmake/llvm)
find_package(LLVM REQUIRED CONFIG)
if ("${LLVM_VERSION_MAJOR}" VERSION_LESS 18)
    message(FATAL_ERROR "Found LLVM ${LLVM_VERSION_MAJOR}, but need LLVM 18 or above")
endif ()

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM_DEFINITIONS: ${LLVM_DEFINITIONS}")
message(STATUS "LLVM_INCLUDE_DIRS: ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM_BUILD_LIBRARY_DIR: ${LLVM_BUILD_LIBRARY_DIR}")

set(MLIR_DIR ~/dev/lib/llvm/build/lib/cmake/mlir)
find_package(MLIR REQUIRED CONFIG)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})
message(STATUS "Found MLIR ${MLIR_PACKAGE_VERSION}")
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "MLIR_INCLUDE_DIRS: ${MLIR_INCLUDE_DIRS}")
message(STATUS "MLIR_CMAKE_DIR: ${MLIR_CMAKE_DIR}")

include(TableGen)
include(AddLLVM)
include(HandleLLVMOptions)

# Find AddMLIR cmake at ~/dev/lib/llvm/mlir/cmake/modules
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
include(AddMLIR)

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})

link_directories(${LLVM_BUILD_LIBRARY_DIR})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})

get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)
set(OPT_LIBS ${dialect_libs} ${conversion_libs} MLIROptLib MLIRSupport LLVMSupport LLVMCore)

add_llvm_executable(eq-sat-opt src/eq-sat-opt.cpp src/EqSatPass.cpp src/Egglog.cpp)
llvm_update_compile_flags(eq-sat-opt)
target_link_libraries(eq-sat-opt PRIVATE ${OPT_LIBS})

add_llvm_executable(eggify src/eggify.cpp)
llvm_update_compile_flags(eggify)
target_link_libraries(eggify PRIVATE ${OPT_LIBS})

# add_llvm_executable(linalg scripts/linalg.cpp)
# llvm_update_compile_flags(linalg)
# target_link_libraries(linalg PRIVATE ${OPT_LIBS})

# add_llvm_executable(attr scripts/attr.cpp)
# llvm_update_compile_flags(attr)
# target_link_libraries(attr PRIVATE ${OPT_LIBS})

add_llvm_executable(tester scripts/tester.cpp)
llvm_update_compile_flags(tester)
target_link_libraries(tester PRIVATE ${OPT_LIBS})
