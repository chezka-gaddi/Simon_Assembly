@@@ Raspberry Pi devices
@@@ -----------------------------------------------------------
@@@ This file provides a function "IO_init" that will
@@@ map some devices into the user program's memory
@@@ space.  Pointers to the devices are stored in
@@@ global variables, and the user program can then
@@@ use those pointers to access the device registers.
@@@ -----------------------------------------------------------
	.data
    .align  2
@@@ -----------------------------------------------------------
@@@ The following global variables will hold the addresses of
@@@ the devices that can be accessed directly after IO_init
@@@ has been called.
	.global	gpiobase
gpiobase:	.word	0
	.global	clkbase
clkbase	:	.word	0

@@@ These are the addresses for the I/O devices (after
@@@ the firmware boot code has remapped them).

@@@ ONE OF THE FOLLOWING TWO LINES SHOULD BE COMMENTED OUT, DEPENDING
@@@ ON WHETHER YOU HAVE AN ORIGINAL RASPBERRY PI,
@@@ OR A RASPBERRY PI 2
 	.equ	PERI_BASE,  0x20000000 @ start of all devices (RasPi)
	@@ Base Physical Address of the GPIO registers
	.equ	GPIO_BASE, (PERI_BASE + 0x200000)
	//.equ	GPIO_BASE, (0x7E200000)
	@@ Base Physical Address of the Clock/timer registers
	.equ	CLK_BASE,  (PERI_BASE + 0x101000)


	.text
    .align  2
@@@ -----------------------------------------------------------
@@@ IO_init() maps devices into memory space and stores their
@@@ addresses in global variables.
@@@ -----------------------------------------------------------	
	.global	IO_init
IO_init:
	stmfd	sp!, {r4, lr}

    ldr     r0, =GPIO_BASE
    ldr     r1, =gpiobase
    str     r0, [r1]

    ldr     r0, =CLK_BASE
    ldr     r1, =clkbase
    str     r0, [r1]
	
init_exit:	
	ldmfd	sp!, {r4, pc}	    @ return
