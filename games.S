@@ reads in the buttons and checks if the right buttons are pressed
    .global input
input:
    stmfd   sp!, {r4-r11, lr}
	
    mov     r4, r0          @ array address
    mov     r5, r1          @ # of elements in array

    mov     r6, #0
in_loop:
    @@ receives button press from user and blinks the button
    bl      console
    mov     r7, r0          @ r7: button pressed		
    mov     r1, r7
    bl      blink

    @@ compare the button pressed to the current element in the array
    ldr     r1, [r4, r6, lsl #2]
    cmp     r1, r7
    bne     fail            @ sound boos and exit if the wrong button was pressed
    add     r6, r6, #1
    cmp     r6, r5
    blt     in_loop

	ldmfd	sp!, {r4-r11, pc}



    .global fail
fail:
    mov     r0, #7
    bl      audio

    add     sp, sp, #20
    bl      gamemode



    .global win
win:
    mov     r0, #6
    bl      audio

    add     sp, sp, #20
    bl      gamemode
