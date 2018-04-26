	.equ	GPLEV0,    0x0034

    .text
    .global gamemode
gamemode:
    stmfd   sp!, {r4, lr}
    
    mov     r0, #17         @ play "Welcome"
    bl      audio 
    mov     r0, #8          @ play "Choose Gamemode"
    bl      audio

    @@ blink lights and play recording with sound option
    mov     r0, #1
    mov     r1, #9
    bl      blink           @ play "Classic"

    mov     r0, #2
    mov     r1, #10
    bl      blink           @ play "Lights Out"
    
    mov     r0, #3
    mov     r1, #11
    bl      blink           @ play "Learn a Song"
    
    mov     r0, #4
    mov     r1, #12
    bl      blink           @ play "Record 20 Notes"
    
    mov     r0, #5
    mov     r1, #23
    bl      blink           @ play "Exit"


    @@ wait for a button event from the user
    bl      console
    mov     r4, r0              @ r4: the button that was pressed
    mov     r1, r0
    bl      blink

    @@ pause
    mov     r0, #1
    bl      sleep

    
    @@ branch to option selected
    cmp     r4, #1
    bleq    classic
    
    cmp     r4, #2
    bleq    lights_out
    
    cmp     r4, #3
    bleq    learn

    cmp     r4, #4
    bleq    record

    cmp     r4, #5
    moveq   r0, #18
    bleq    audio
	cmp	    r4, #5
	bleq    exit

    ldmfd   sp!, {r4, pc}


@@ waits for the user to press a button and returns the button that was pressed    
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

    cmp     r0, #0              @ r0: the button that was pressed
    bne     return
    b	    loop                @ loop until a button is pressed

return:
    ldmfd   sp!, {r4, pc}
