@@ learn.S is the gamemode that helps the user learn a new song by playing
@@ a hardcoded song and having them playback the notes
    .text
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

