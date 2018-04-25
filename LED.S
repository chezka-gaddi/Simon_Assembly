    
    .equ    GPFSEL0,    0x0000
    .equ    GPSET0,     0x001C
    .equ    GPCLR0,     0x0028


    .text
    .global start_sequence
start_sequence:
    stmfd   sp!, {r4-r7, lr}
    
    ldr     r4, =gpiobase
    ldr     r4, [r4]

    mov     r7, #0
    mov     r6, #0
    mov     r5, #0
flash:
    mov     r1, #0
    mov     r2, #0

    @ flash blue led
    tst     r5, #0b10000
    orrne   r1, r1, #0x100000
    orreq   r2, r2, #0x100000

    @ flash red led
    tst     r5, #0b10100
    orrne   r1, r1, #0x400000
    orreq   r2, r2, #0x400000

    @ flash yellow led
    tst     r5, #0b11000
    orrne   r1, r1, #0x2000
    orreq   r2, r2, #0x2000
    
    @ flash orange led
    tst     r5, #0b100
    orrne   r1, r1, #0x40
    orreq   r2, r2, #0x40

    @ flash green led
    tst     r5, #0b1000
    orrne   r1, r1, #0x10
    orreq   r2, r2, #0x10
    
    str     r2, [r4, #GPSET0]
    str     r1, [r4, #GPCLR0]
    
    cmp     r5, #25
    addlt   r5, r5, #1
    movge   r5, #0

    mov     r0, #0x2000
    bl      usleep
    add     r7, r7, #1
    cmp     r7, #0xC000003F
    blt     flash

    
    mov     r0, #1
    mov     r1, #1
    bl      blink
    mov     r0, #2
    mov     r1, #2
    bl      blink
    mov     r0, #3
    mov     r1, #3
    bl      blink
    mov     r0, #4
    mov     r1, #4
    bl      blink
    mov     r0, #5
    mov     r1, #5
    bl      blink

    ldmfd   sp!, {r4-r7, pc}



@@ void blink( int button, int audio)
    .global blink
blink:
    stmfd   sp!, {r4-r6, lr}
    mov     r4, r0          @ r4: button pressed
    mov     r5, r1          @ r5: audio to play

    bl      led_on
    mov     r0, r5
    bl      audio
    mov     r0, r4
    bl      led_off

    ldmfd   sp!, {r4-r6, pc}
  


@@ void on( int switch )
    .global led_on
led_on:
    stmfd   sp!, {r4, lr}

    @@ r3, the lights to be turned on
    cmp     r0, #1
    moveq   r3, #20
    cmp     r0, #2
    moveq   r3, #22
    cmp     r0, #3
    moveq   r3, #13
    cmp     r0, #4
    moveq   r3, #6
    cmp     r0, #5
    moveq   r3, #4
    
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
    moveq   r3, #20
    cmp     r0, #2
    moveq   r3, #22
    cmp     r0, #3
    moveq   r3, #13
    cmp     r0, #4
    moveq   r3, #6
    cmp     r0, #5
    moveq   r3, #4
    
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
    
    add     r6, r6, #1
    b       play_loop


exit_play:
    ldmfd   sp!, {r4-r7, pc}



@@ void no_lights_play( int *array[], int size
    .global no_lights_play
no_lights_play:
    stmfd   sp!, {r4-r7, lr}

    mov     r4, r0          @ r4: array address
    mov     r5, r1          @ r5: array size

    mov     r6, #0          @ r6: counter
loop_nol:
    ldr     r0, [r4, r6, lsl #2]
    bl      audio
    
    add     r6, r6, #1
    cmp     r6, r5
    blt     loop_nol

    ldmfd   sp!, {r4-r7, pc}
