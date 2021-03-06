//===-- sync_synchronize - Implement memory barrier * ----------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "../assembly.h"

//
// When compiling a use of the gcc built-in __sync_synchronize() in thumb1 mode
// the compiler may emit a call to __sync_synchronize.  
// On Darwin the implementation jumps to an OS supplied function named 
// OSMemoryBarrier
//

	.text
	.syntax unified

#if __APPLE__

DEFINE_COMPILERRT_PRIVATE_FUNCTION(__sync_synchronize)
	stmfd	sp!, {r7, lr}
	add		r7, sp, #0
	bl		_OSMemoryBarrier
	ldmfd	sp!, {r7, pc}

	// tell linker it can break up file at label boundaries
	.subsections_via_symbols
		
#endif
