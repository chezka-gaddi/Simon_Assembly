@@ lights_out.S game mode where only audio associated with each button is 
@@ played, no lights

    .text
    .global lights_out
lights_out:
    stmfd   sp!, {r4-r11, lr}

    mov     r0, #21
    bl      audio

    bl      start_sequence

    mov     r0, #22
    bl      audio
    
    mov     r5, #5              @ r5: size of array
    sub     sp, sp, r5, lsl #2  @ allocate array
    mov     r4, sp              @ r4: address of the array

    mov     r6, #0              @ r6: counter for array
lights_loop:
    @@ receive random number
    mov     r0, #5
    bl      int_rand

    @@ store button press to array
    str     r0, [r4, r6, lsl #2]
    add     r6, r6, #1

    @@ play current button presses
    mov     r0, r4
    mov     r1, r6
    bl      no_lights_play

    mov     r7, #0              @ r7: counter for input
check_loop:
    @@ wait for button press
    bl      console
    
    @@ play audio for specified button 
    bl      audio
    
    ldr     r1, [r4, r7, lsl #2] 
    cmp     r0, r1
    blne    fail    
    add     r7, r7, #1
    cmp     r7, r6
    blt     check_loop
    
    cmp     r6, r5
    blt     lights_loop
    bl      win
