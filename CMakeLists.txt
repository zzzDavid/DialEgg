cmake_minimum_required(VERSION 3.28)
project(egg-opt LANGUAGES CXX C)

set(CMAKE_CXX_STANDARD 20)

find_package(LLVM REQUIRED CONFIG)
if ("${LLVM_VERSION_MAJOR}" VERSION_LESS 18)
    message(FATAL_ERROR "Found LLVM ${LLVM_VERSION_MAJOR}, but need LLVM 18 or above")
endif ()

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS "LLVM_DEFINITIONS: ${LLVM_DEFINITIONS}")
message(STATUS "LLVM_INCLUDE_DIRS: ${LLVM_INCLUDE_DIRS}")
message(STATUS "LLVM_BUILD_LIBRARY_DIR: ${LLVM_BUILD_LIBRARY_DIR}")

find_package(MLIR REQUIRED CONFIG)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})
message(STATUS "Found MLIR ${MLIR_PACKAGE_VERSION}")
message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "MLIR_INCLUDE_DIRS: ${MLIR_INCLUDE_DIRS}")
message(STATUS "MLIR_CMAKE_DIR: ${MLIR_CMAKE_DIR}")

include(TableGen)
include(AddLLVM)
include(HandleLLVMOptions)

# Find AddMLIR cmake at llvm-project/mlir/cmake/modules
list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
include(AddMLIR)

# Comment out StableHLO for now due to compatibility issues
# set(STABLEHLO_BUILD_EMBEDDED ON)
# add_subdirectory(${STABLEHLO_DIR} ${CMAKE_CURRENT_BINARY_DIR}/stablehlo EXCLUDE_FROM_ALL)
# include_directories(${STABLEHLO_DIR})

set(DIALEGG_SOURCE_DIR ${PROJECT_SOURCE_DIR})
set(DIALEGG_BINARY_DIR ${PROJECT_BINARY_DIR})

include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})

link_directories(${LLVM_BUILD_LIBRARY_DIR})
separate_arguments(LLVM_DEFINITIONS_LIST NATIVE_COMMAND ${LLVM_DEFINITIONS})
add_definitions(${LLVM_DEFINITIONS_LIST})
add_definitions(${LLVM_DEFINITIONS})

get_property(dialect_libs GLOBAL PROPERTY MLIR_DIALECT_LIBS)
get_property(conversion_libs GLOBAL PROPERTY MLIR_CONVERSION_LIBS)
set(OPT_LIBS ${dialect_libs} ${conversion_libs} MLIROptLib)

add_llvm_executable(egg-opt src/egg-opt.cpp src/EqualitySaturationPass.cpp src/Egglog.cpp)
llvm_update_compile_flags(egg-opt)
target_link_libraries(egg-opt PRIVATE ${OPT_LIBS})

add_subdirectory(test)
