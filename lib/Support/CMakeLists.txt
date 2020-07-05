#===------------------------------------------------------------------------===#
#
#                     The KLEE Symbolic Virtual Machine
#
# This file is distributed under the University of Illinois Open Source
# License. See LICENSE.TXT for details.
#
#===------------------------------------------------------------------------===#
klee_add_component(kleeSupport
  CompressionStream.cpp
  ErrorHandling.cpp
  FileHandling.cpp
  MemoryUsage.cpp
  PrintVersion.cpp
  RNG.cpp
  Time.cpp
  Timer.cpp
  TreeStream.cpp
  ModifyLLVM.cpp
)
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)
target_link_libraries(kleeSupport PRIVATE ${ZLIB_LIBRARIES} Threads::Threads)

set(LLVM_COMPONENTS
  support
)
klee_get_llvm_libs(LLVM_LIBS ${LLVM_COMPONENTS})
target_link_libraries(kleeSupport PUBLIC ${LLVM_LIBS})
