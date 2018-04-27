// FILE: start.S

//.include "modes.S"
// Definitions of mode field and interrupt bits in CPSR
	.equ	I_BIT, 0x80	    // when I=1 IRQ is disabled
	.equ	F_BIT, 0x40	    // when F=1 FIQ is disabled
	.equ	USR_MODE, 0x10	// shares sp,lr,CPSR with sys mode
	.equ	FIQ_MODE, 0x11	// fiq mode all interrupts masked
	.equ	IRQ_MODE, 0x12	// irq mode all interrupts masked
	.equ	SVC_MODE, 0x13
	.equ	ABT_MODE, 0x17
	.equ	UND_MODE, 0x1B
	.equ	SYS_MODE, 0x1F	// shares sp,lr,CPSR with usr mode

// Stack locations
	.equ	stack_top, 0x10000000	// Raspberry pi only

	.equ    fiq_stack_top, stack_top
	.equ 	irq_stack_top, stack_top - 0x1000
	.equ	abt_stack_top, stack_top - 0x2000
	.equ 	und_stack_top, stack_top - 0x3000
	.equ	mon_stack_top, stack_top - 0x4000
	.equ    svc_stack_top, stack_top - 0x5000
	.equ    sys_stack_top, stack_top - 0x6000

// -----------------------------------------------------------
// The startup code should be loaded by the boot loader.
// The entry point is _start which performs initialization of
// the hardware, then calls a C function.
	.section    .text.boot	// .start?? pg. 453
    .global _start
	.func   _start
	
_start:
   	// On reset, we should be in SVC mode.
	// Switch to FIQ mode with interrupts disabled
	msr     CPSR_c, #FIQ_MODE|I_BIT|F_BIT
	ldr 	sp, =fiq_stack_top  // set the FIQ stack pointer
	
	// Switch to IRQ mode with interrupts disabled
	msr	    CPSR_c, #IRQ_MODE|I_BIT|F_BIT
	ldr	    sp, =irq_stack_top 	// set the IRQ stack pointer
	
	// Switch to ABT mode with interrupts disabled
	msr	    CPSR_c, #ABT_MODE|I_BIT|F_BIT
	ldr 	sp, =abt_stack_top 	// set the ABT stack pointer
	
	// Switch to UND mode with interrupts disabled
	msr	    CPSR_c,#UND_MODE|I_BIT|F_BIT
	ldr	    sp, =und_stack_top 	// set the UND stack pointer
	
	// Switch to SYS mode with interrupts disabled
	msr 	CPSR_c, #SYS_MODE|I_BIT|F_BIT
	ldr 	sp, =sys_stack_top 	// set SYS/USR stack pointer

	// Switch to SVC mode with interrupts disabled
	msr	    CPSR_c, #SVC_MODE|I_BIT|F_BIT
	ldr	    sp, =svc_stack_top 	// set SVC stack pointer
	
	// Clear the .bss segment to all zeros
	// The __bss_start__ and __bss_end__ symbols are
	// defined by the linker.
	ldr	    r1, =__bss_start__ 	// load pointer to bss and
	ldr	    r2, =__bss_end__	// to byte following bss
	mov	    r3, #0			    // start filling
	
bssloop:
	cmp 	r1, r2
	bge	    bssdone
	str	    r3, [r1, #4]
	b 	    bssloop			    // loop until done

bssdone:
	// Set up the vector table
	bl	    setup_vector_table
    // The exception handlers are defined in interrupts.S

    // Initialize the Interrupt Controller
    bl      IC_init

    // Set up the hardware timer to generate interrupts
    // at a fixed frequency
    bl      enable_timer

    // switch to user mode with IRQ and FIQ enabled
    msr     CPSR_c, #USR_MODE   // switch to USR mode

    // Enter the C/C++ code at main
	bl	    main
	
    // If main ever returns, cause an exception
	swi	    0xFFFFFF
	.size	_start, . - _start
	.endfunc
