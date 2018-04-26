@@ record.S allows user to create sequence, stores sequence in an array and 
@@ plays back song created

    .text
    .global record
record:
    stmfd   sp!, {r4-r6, lr}

    mov     r0, #19         @ play "Recording" audio
    bl      audio


    @ allocate array
    mov     r5, #5          @ r5: array size
    sub     sp, sp, r5, lsl #2
    mov     r4, sp          @ r4: address of array
    
    mov     r6, #0          @ r6: iterator
rec_loop:
    bl      console                 @ wait for button press
    str     r0, [r4, r6, lsl #2]	@ store button press to array
    mov     r1, r0
    mov     r2, #0
    bl      blink                   @ flash and play associated light and audio

    add     r6, r6, #1
    cmp     r6, r5
    blt     rec_loop                @ repeat until 20 notes have been played
    
    mov     r0, #20                 @ play "Generating Song" audio
    bl      audio
    
    
    mov     r0, r4
    mov     r1, r5
    bl      playback                @ play back contents of array

    mov     r0, #6                  @ play claps
    bl      audio

    add     sp, sp, r5, lsl #2
    ldmfd   sp!, {r4-r6, pc}
