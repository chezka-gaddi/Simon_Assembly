    mov     r5, #0          @ r5: counter
    mov     r1, r5
    ldr     r0, =out
    bl      printf          @ print current count
loop:
    mov	    r1, #0		    @ will be used to set outputs
	mov	    r2, #0		    @ will be used to clear outputs
    
    
    @ set pin 17
    tst     r5, #0b00000001
	orrne	r1, r1, #0x10	@ if should be set (LED off)
    orreq	r2, r2, #0x10	@ if should be clear (LED on)

    @ set pin 18
	tst	    r5, #0b00000010     @ check state of pin 23
	orrne	r1, r1, #0x20	@ if should be set (LED off)
	orreq	r2, r2, #0x20	@ if should be clear (LED on)
    
    @ set pin 
	tst	    r5, #0b00000100     @ check state of pin 24
	orrne	r1, r1, #0x40	@ if should be set (LED off)
	orreq	r2, r2, #0x40	@ if should be clear (LED on)
	
    tst	    r5, #0b00001000    
	orrne	r1, r1, #0x1000	    @ if should be set (LED off)
	orreq	r2, r2, #0x1000   	@ if should be clear (LED on)
    
	str	    r2, [r4, #GPSET0]	@ set some pins
	str	    r1, [r4, #GPCLR0]	@ clear some pins

    mov     r6, #0              @ r6: debounce counter
debounce:
    @@ Read the state of the buttons
	@@ Read GPIO Level Register 0 (GPLEV0)
	ldr	    r0, [r4, #GPLEV0]

    tst	    r0, #(1<<22)	    @ check state of pin 22
    mov     r3, #1
    beq     compare

    tst	    r0, #(1<<23)	    @ check state of pin 23
    mov     r3, #0
	beq     compare

    tst	    r0, #(1<<24)	    @ check state of pin 24
    mvn     r3, #1
    beq     compare
    
    mov     r6, #0 
    b       debounce

compare:
    addeq   r6, r6, #1
    cmp     r6, #0x1FC000
    blt     debounce

    cmp     r3, #0
    moveq   r5, #0
    addgt   r5, r5, #1
    sublt   r5, r5, #1

    mov     r1, r5
    ldr     r0, =out
    bl      printf          @ print current count
    b       loop

	ldmfd	sp!, {r4-r7, pc}
