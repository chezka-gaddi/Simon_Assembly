@@ record.S allows user to create sequence, stores sequence in an array and 
@@ plays back song created

@@@ Raspberry Pi version
	.equ	SHORT_DELAY,	50
	
    @@  These are the offsets for the GPIO registers that we will use
	.equ	GPFSEL0,   0x0000
	.equ	GPFSEL1,   0x0004
	.equ	GPFSEL2,   0x0008
	.equ	GPFSEL3,   0x000C
	.equ	GPFSEL4,   0x0010
	.equ	GPFSEL5,   0x0014
	.equ	GPSET0,    0x001C
	.equ	GPSET1,    0x0020
	.equ	GPCLR0,    0x0028	
	.equ	GPCLR1,    0x002c	
	.equ	GPLEV0,    0x0034

	.equ	GPPUD,     0x0094
	.equ	GPPUDCLK0, 0x0098
 	.equ	GPPUDCLK1, 0x009C 
    
    .text
    .global record
record:
    stmfd   sp!, {r4-r6, lr}

    mov     r0, #19
    bl      audio


    @ allocate array
    mov     r5, #5          @ r5: array size
    sub     sp, sp, r5, lsl #2
    mov     r4, sp          @ r4: address of array
    
    mov     r6, #0          @ r6: iterator
rec_loop:
    bl      console
    str     r0, [r4, r6, lsl #2]	
    mov     r1, r0
    mov     r2, #0
    bl      blink

    add     r6, r6, #1
    cmp     r6, r5
    blt     rec_loop
    
    mov     r0, #20
    bl      audio
    
    
    mov     r0, r4
    mov     r1, r5
    bl      playback

    mov     r0, #6
    bl      audio

    add     sp, sp, r5, lsl #2
    ldmfd   sp!, {r4-r6, pc}
