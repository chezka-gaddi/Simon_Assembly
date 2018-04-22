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
    .global gamemode
gamemode:
    stmfd   sp!, {r4-r5, lr}
    
    ldr     r4, =gpiobase
    ldr     r4, [r4]

    mov     r0, #17
    bl      audio
    
    mov     r0, #8
    bl      audio

    mov     r1, #(1<<20)
    mov     r2, #0
    str     r1, [r4, #GPCLR0]
    str     r2, [r4, #GPSET0]
    mov     r0, #9
    bl      audio
    mov     r1, #0
    mov     r2, #(1<<20)
    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]
    
    mov     r1, #(1<<22)
    mov     r2, #0
    str     r1, [r4, #GPCLR0]
    str     r2, [r4, #GPSET0]
    mov     r0, #10
    bl      audio
    mov     r1, #0
    mov     r2, #(1<<22)
    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]
    
    mov     r1, #(1<<13)
    mov     r2, #0
    str     r1, [r4, #GPCLR0]
    str     r2, [r4, #GPSET0]
    mov     r0, #11
    bl      audio
    mov     r1, #0
    mov     r2, #(1<<13)
    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]

    mov     r1, #(1<<6)
    mov     r2, #0
    str     r1, [r4, #GPCLR0]
    str     r2, [r4, #GPSET0]
    mov     r0, #12
    bl      audio
    mov     r1, #0
    mov     r2, #(1<<6)
    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]
    

    bl      console
    mov     r5, r0
    bl      blink

    mov     r0, #1
    bl      sleep

    cmp     r5, #1
    bleq    original
    
    cmp     r5, #3
    bleq    learn

    cmp     r5, #4
    bleq    record

    
    ldmfd   sp!, {r4-r5, pc}


    
    .global console
console:
    stmfd   sp!, {r4, lr}
    ldr     r4, =gpiobase
    ldr     r4, [r4]

loop:
    @@ Read the state of the buttons
	@@ Read GPIO Level Register 0 (GPLEV0)
	ldr 	r3, [r4, #GPLEV0]
    
    mov     r0, #0      @ will be used to dertermine which switch was set
	mov	    r1, #0		@ will be used to set outputs
	mov	    r2, #0		@ will be used to clear outputs

    tst	    r3, #(1<<19)	    @ check state of pin 19
    moveq   r0, #1

	tst	    r3, #(1<<21)	    @ check state of pin 21
    moveq   r0, #2

	tst	    r3, #(1<<16)	    @ check state of pin 16
    moveq   r0, #3
	
    tst	    r3, #(1<<12)	    @ check state of pin 12
    moveq   r0, #4
    
    tst	    r3, #(1<<5)	        @ check state of pin 5
    moveq   r0, #5

    cmp     r0, #0
    bne     return

    b	    loop

return:
    ldmfd   sp!, {r4, pc}
