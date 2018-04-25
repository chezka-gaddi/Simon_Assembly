@@ classic play mode for Simon
    
    .text
    .global classic
classic:
    stmfd   sp!, {r4-r11, lr}

    mov     r0, #13
    bl      audio

    mov     r0, #1
    mov     r1, #14
    mov     r2, #0
    bl      blink
    
    mov     r0, #2
    mov     r1, #15
    mov     r2, #0
    bl      blink
    
    mov     r0, #3
    mov     r1, #16
    mov     r2, #0
    bl      blink
   
   
    @@ wait for input from the user and blink button pressed
    bl      console
    mov     r7, r0
    mov     r1, r0
    mov     r2, #0
    bl      blink
    mov     r0, r7

    mov     r0, #22
    bl      audio

    @@ initialize # of buttons to 4
    mov     r7, #4

    cmp     r0, #1
    moveq   r6, #0xD70000   @ r6: speed
    cmp     r0, #2
    moveq   r6, #0          @ r6: speed
    cmp     r0, #3
    moveq   r6, #0          @ r6: speed
    moveq   r7, #5

    @ allocate array of game sequence
    mov     r8, #5
    sub     sp, sp, r8, lsl #2
    mov     r4, sp          @ r4: address of array
    mov     r5, #0          @ r5: counter

@@ fill gets a random number, stores it into an array, plays the sequence to the user
@@ and calls input to read in the users reply. This is a loop that goes through until 
@@ the array is full. If the max sequence is done correctly outputs a cheering sound.	
classic_loop:
    mov     r0, r7
    bl      int_rand			    @ gets a random number
    str     r0, [r4, r5, lsl #2]	@ stores it into the array at current offset
    add     r5, r5, #1			    @ increments array size

    mov     r0, r4			@ moves array address into r0 
    mov     r1, r5			@ moves array size into r1
    mov     r3, r6          @ moves playback speed to r3
    bl      playback      	@ calls playback to output current sequence

    mov     r0, r4			@ moves array address into r0
    mov     r1, r5			@ moves array size into r1
    bl      input			@ calls input to read in players reply
   
    mov     r0, r6          @ delay for diffifulty
    bl      usleep

    cmp     r5, r8			@ checks to see if array is full
    blt     classic_loop    @ if not full recall fill
    bl      win	
