    .equ    TIMER_BASE, 0x20003000
    .equ    VALUE,  0x04
    
    .text
    .global delay
delay:
    stmfd   sp!, {r4-r11, lr}
    

    ldr     r3, =TIMER_BASE
    ldr     r0, [r3, #VALUE]
loop:
    ldr     r1, [r3, #VALUE]
    sub     r2, r1, r0
    cmp     r2, #0xd7000
    blt     loop


    ldmfd   sp!, {r4-r11, pc}
