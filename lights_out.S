@@ lights_out.S game mode where only audio associated with each button is 
@@ played, no lights

    .text
    .global lights_out
lights_out:
    stmfd   sp!, {r4-r11, lr}

    mov     r0, #21             @ play Memorize buttons to sound audio
    bl      audio

    bl      start_sequence      @ play all of the light and their corresponding
                                @ sound again for the player

    mov     r0, #22             @ play Ready, Go! audio
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
    cmp     r0, r1              @ compare the button press to the array
    blne    fail                @ play booing audio and return back to gamemode
    add     r7, r7, #1
    cmp     r7, r6
    blt     check_loop          @ else, check other button presses
    
    cmp     r6, r5
    blt     lights_loop         @ continue playing by adding more notes to sequence
    bl      win                 @ play claps and return back to gamemode
