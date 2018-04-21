learn:
	stmfd   sp!, {r4-r11, lr}
    
	@ allocate array of game sequence
	mov     r0, #18
	bl      malloc
	mov	r4,r0

hot_cross:
	mov	r0,r4
	mov	r1,#1
	bl	read

	mov	r0,r4
	mov	r1,#18
	bl 	playback

	mov	r0,r4
	mov	r1,#18
	bl	input
	
	ldmfd	sp!,{r4-r11,pc}
	
	
