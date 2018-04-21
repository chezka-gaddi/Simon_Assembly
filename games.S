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

    mov     r0, #13
    bl      audio

    mov     r0, #1
    bl      led_on
    mov     r0, #14
    bl      audio
    mov     r0, #1
    bl      led_off

    mov     r0, #1
    bl      sleep

    mov     r0, #2
    bl      led_on
    mov     r0, #15
    bl      audio
    mov     r0, #2
    bl      led_off
    
    mov     r0, #1
    bl      sleep
    
    mov     r0, #3
    bl      led_on
    mov     r0, #16
    bl      audio
    mov     r0, #3
    bl      led_off
   
    
    bl      console
    mov     r7, r0
    bl      blink
    mov     r0, r7


    @@ initialize # of buttons to 4
    mov     r7, #4

    cmp     r0, #1
    moveq   r6, #0xD7000  @ r6: speed
    cmp     r0, #2
    moveq   r6, #0          @ r6: speed
    cmp     r0, #3
    moveq   r6, #0          @ r6: speed
    moveq   r7, #5

    @ allocate array of game sequence
    mov     r8, #7
    sub     sp, sp, r8, lsl #2
    mov     r4, sp          @ r4: address of array
    mov     r5, #0          @ r5: counter

@@ fill gets a random number, stores it into an array, plays the sequence to the user
@@ and calls input to read in the users reply. This is a loop that goes through until 
@@ the array is full. If the max sequence is done correctly outputs a cheering sound.	
fill:
    mov     r0, r7
    bl      int_rand			    @ gets a random number
    str     r0, [r4, r5, lsl #2]	@ stores it into the array at current offset
    add     r5, r5, #1			    @ increments array size

    mov     r0, r4			@ moves array address into r0 
    mov     r1, r5			@ moves array size into r1
    mov     r3, r6          @ moves playback speed to r3
    bl      playback      	@ calls playback to output current sequence

    mov     r0, r4			@ moves array address into r0
    mov     r1, r5			@ moves array size into r1
    bl      input			@ calls input to read in players reply
   
    mov     r0, r7
    bl      usleep

    cmp     r5, r8			@ checks to see if array is full
    blt     fill			@ if not full recall fill
	

    mov     r0, #6			
    bl      audio			@ call audio to output cheering
    
    add     sp, sp, r8, lsl #2
    ldmfd   sp!, {r4-r11, pc}
    


    .global learn
learn:
	stmfd   sp!, {r4-r11, lr}
    
	mov     r5, #17
    sub     sp, sp, r5, lsl #2
    mov     r4, sp

    mov     r1, #1
    mov     r2, #2
    mov     r3, #3

    str     r1, [r4]    
    str     r2, [r4, #4]
    str     r3, [r4, #8]

    str     r1, [r4, #12]
    str     r2, [r4, #16]
    str     r3, [r4, #20]
    
    str     r1, [r4, #24]
    str     r1, [r4, #28]
    str     r1, [r4, #32]
    str     r1, [r4, #36]

    str     r2, [r4, #40]
    str     r2, [r4, #44]
    str     r2, [r4, #48]
    str     r2, [r4, #52]
    
    str     r1, [r4, #56]    
    str     r2, [r4, #60]
    str     r3, [r4, #64]
    
    mov     r0, r4
    mov     r1, r5
    bl      printArr

    mov     r0, r4
    mov	    r1, r5
	bl 	    playback

	mov	    r0, r4
	mov	    r1, r5
	bl	    input
	
    add     sp, sp, r5, lsl #2
	ldmfd	sp!, {r4-r11, pc}




    .global record
record:
    stmfd   sp!, {r4-r11, lr}
    
    @ allocate array
    mov     r6, #5          @ r6: array size
    sub     sp, sp, r6, lsl #2
    mov     r5, sp          @ r5: address of array
    
    ldr     r4, =gpiobase   @ r4: gpiobase
    ldr     r4, [r4]

    mov     r7, #0          @ r7: iterator
rec_loop:
    bl      console
    str     r0, [sp, r7, lsl #2]	
    mov     r1, #0
    bl      blink

    add     r7, r7, #1
    cmp     r7, r6
    blt     rec_loop
    
    mov     r0, r5
    mov     r1, r6
    bl      playback

    mov     r0, #6
    bl      audio

    add     sp, sp, r6, lsl #2
    ldmfd   sp!, {r4-r11, pc}



    .global input
input:
    stmfd   sp!, {r4-r11, lr}
	
    ldr	    r4, =gpiobase	@ load pointer to the address of the gpio device
	ldr	    r4, [r4]	    @ load address of the gpio device
    mov     r5, r0          @ array address
    mov     r6, r1          @ # of elements in array

    mov     r7, #0
in_loop:    
    bl      console
    mov     r8, r0		
    mov     r1, #0
    bl      blink

    ldr     r1, [r5, r7, lsl #2]
    cmp     r1, r8
    bne     fail
    add     r7, r7, #1
    cmp     r7, r6
    blt     in_loop

	ldmfd	sp!, {r4-r11, pc}
