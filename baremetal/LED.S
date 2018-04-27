    
    .equ    GPFSEL0,    0x0000
    .equ    GPSET0,     0x001C
    .equ    GPCLR0,     0x0028


	.text

    .global start_sequence
start_sequence:
    stmfd   sp!, {r4-r7, lr}
    
    ldr     r4, =gpiobase
    ldr     r4, [r4]

	bl	flash_all
	bl	delay
	
    mov     r0, #1
	bl      blink
	
    mov     r0, #2
	bl      blink
	
    mov     r0, #3
    bl      blink

	mov     r0, #4
    bl      blink
    

    ldmfd   sp!, {r4-r7, pc}



    .global flash_all	
flash_all:
	stmfd	sp!,{r4,lr}
	mov	r4,#0
loop_flash_all:	
	mov	r0,#1
	bl	led_on
	mov     r0,#2
	bl	led_on
	mov     r0,#3
	bl	led_on
	mov     r0,#4
	bl	led_on

	bl	delay

	mov     r0,#1
	bl	led_off
	mov     r0,#2
	bl      led_off
	mov     r0,#3
	bl      led_off
	mov     r0,#4
	bl      led_off

    bl      delay
	add	    r4,r4,#1
	cmp	    r4,#3
	blt	    loop_flash_all

	ldmfd	sp!,{r4,pc}
	
	

@@ void blink( int button, int audio)
    .global blink
blink:
    stmfd   sp!, {r4-r6, lr}
    mov     r4, r0          @ r4: button pressed
	bl      led_on

	bl      delay

    mov     r0, r4
    bl      led_off

    ldmfd   sp!, {r4-r6, pc}
  


@@ void on( int switch )
    .global led_on
led_on:
    stmfd   sp!, {r4, lr}

    @@ r3, the lights to be turned on
    cmp     r0, #1
    moveq   r3, #18
    cmp     r0, #2
    moveq   r3, #23
    cmp     r0, #3
    moveq   r3, #24
    cmp     r0, #4
    moveq   r3, #25
    
    ldr     r4, =gpiobase
    ldr     r4, [r4]

    mov     r2, #0
    mov     r1, #1
    lsl     r1, r1, r3

    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]

    ldmfd   sp!, {r4, pc}



@@ off( int switch )
    .global led_off
led_off:
    stmfd   sp!, {r4, lr}

    @@ r3, the lights to be turned on
    cmp     r0, #1
    moveq   r3, #18
    cmp     r0, #2
    moveq   r3, #23
    cmp     r0, #3
    moveq   r3, #24
    cmp     r0, #4
    moveq   r3, #25
    
    
    ldr     r4, =gpiobase
    ldr     r4, [r4]
    
    mov     r1, #0
    mov     r2, #1
    lsl     r2, r2, r3

    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]
    
    ldmfd   sp!, {r4, pc}



@@ void playback( int *array[], int size, int speed )
    .global playback
playback:
    stmfd   sp!, {r4-r7, lr}
    
    mov     r4, r0          @ r4: array address
    mov     r5, r1          @ r5: array size
    mov     r7, r2          @ r7: playback speed

    mov     r6, #0
play_loop:
    cmp     r6, r5
    bge     exit_play

    mov     r1, r7
    ldr     r0, [r4, r6, lsl #2]
    mov     r1, r0
    bl      blink

	bl      delay
	
    add     r6, r6, #1
    b       play_loop


exit_play:
    ldmfd   sp!, {r4-r7, pc}

