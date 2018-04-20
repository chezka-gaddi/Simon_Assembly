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

    .data
out:    .asciz  "# of Notes: %d\n"

    .text
    .global original


original:
    stmfd   sp!, {r4-r11, lr}
    
    @ allocate array of game sequence
    mov     r0, #5
    bl      malloc
    mov     r4, r0      @ r4: address of array

    mov     r5, #0

@@ fill gets a random number, stores it into an array, plays the sequence to the user
@@ and calls input to read in the users reply. This is a loop that goes through until 
@@ the array is full. If the max sequence is done correctly outputs a cheering sound.	
fill:
    bl      int_rand			@gets a random number
    str     r0, [r4, r5, lsl #2]	@stores it into the array at current offset
    add     r5, r5, #1			@incraments array size
    
    mov     r0, r4
    mov     r1, r5
    bl      printArr

    mov     r0, r4			@moves array address into r0 
    mov     r1, r5			@moves array size into r1
    bl      playback      		@calls playback to output current sequence

    mov     r0, r4			@moves array address into r0
    mov     r1, r5			@moves array size into r1
    bl      input			@calls input to read in players reply
    

    cmp     r5, #5			@checks to see if array is full
    blt     fill			@if not full recall fill
					
    mov     r0, #6			
    bl      audio			@call audio to output cheering
    ldmfd   sp!, {r4-r11, pc}
    
    
    
    .global input
input:
    stmfd   sp!, {r4-r11, lr}
	
    ldr	    r4, =gpiobase	@ load pointer to the address of the gpio device
	ldr	    r4, [r4]	    @ load address of the gpio device
    mov     r5, r0          @ array address
    mov     r6, r1          @ # of elements in array

    mov     r7, #0
loop:    
    @@ Read the state of the buttons
	@@ Read GPIO Level Register 0 (GPLEV0)
	ldr 	r3, [r4, #GPLEV0]
    mov     r0, #0

	mov	    r1, #0		@ will be used to set outputs
	mov	    r2, #0		@ will be used to clear outputs

    tst	    r3, #(1<<19)	    @ check state of pin 22
    moveq   r0, #1

	tst	    r3, #(1<<21)	    @ check state of pin 23
    moveq   r0, #2

	tst	    r3, #(1<<16)	    @ check state of pin 24
    moveq   r0, #3
	
    tst	    r3, #(1<<12)	    @ check state of pin 25
    moveq   r0, #4
    
    tst	    r3, #(1<<5)	        @ check state of pin 25
    moveq   r0, #5

    cmp     r0, #0
    bne     exit

    b	    loop

exit:
    mov     r8, r0		
    mov     r1, #0
    //mov     r1, #0x35C00
    bl      blink

    ldr     r1, [r5, r7, lsl #2]
    cmp     r1, r8
    bne     fail
    add     r7, r7, #1
    cmp     r7, r6
    blt     loop

	ldmfd	sp!, {r4-r11, pc}
