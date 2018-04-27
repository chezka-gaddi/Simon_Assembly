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

    str     r1, [r4]		@ stores 1 at offset 0    
    str     r2, [r4, #4]	@ stores 2 at offset 4
    str     r3, [r4, #8]	@ stores 3 at offset 8

    str     r1, [r4, #12]	@ stores 1 at offset 12
    str     r2, [r4, #16]	@ stores 2 at offset 16
    str     r3, [r4, #20]	@ stores 3 at offset 20
    
    str     r1, [r4, #24]	@ stores 1 at offset 24
    str     r1, [r4, #28]	@ stores 1 at offset 28
    str     r1, [r4, #32]	@ stores 1 at offset 32
    str     r1, [r4, #36]	@ stores 1 at offset 36

    str     r2, [r4, #40]	@ stores 2 at offset 40
    str     r2, [r4, #44]	@ stores 2 at offset 44
    str     r2, [r4, #48]	@ stores 2 at offset 48
    str     r2, [r4, #52]	@ stores 2 at offset 52
    
    str     r1, [r4, #56]    	@ stores 1 at offset 56
    str     r2, [r4, #60]	@ stores 2 at offset 60
    str     r3, [r4, #64]	@ stores 3 at offset 64
    
    

    mov     r0, r4		@ moves array address into r0
    mov	    r1, r5		@ moves array size into r1
	bl 	    playback

	mov     r0, r4		@ moves	array address into r0
	mov     r1, r5		@ moves	array size into	r1
	bl	    input
	
    add     sp, sp, r5, lsl #2
	ldmfd	sp!, {r4-r11, pc}

