@@@ FILE: RasPi_timer.S
@@@ The timer runs off the 250MHz APB_clocksource
@@  .equ	TIMER_BASE, 0x7E003000	@ BCM28354
	.equ	TIMER_BASE, 0x20003000	@ BCM28354
	.equ	LOAD, 0x00		@ Load
	.equ	VALUE, 0x04		@ Value (read only)
	.equ	CONTROL, 0x08	@ Control
	.equ	IRQACK, 0x0C	@ IRQ Clear/Ack (write only)
	.equ	RAWIRQ, 0x10	@ Raw IRQ (read  only)
	.equ	MSKIRQ, 0x14	@ Masked IRQ (read only)
	.equ	RELOAD, 0x18	@ Reload
	.equ	PREDIV, 0x1C	@ Pre-divider
	.equ	COUNT, 0x20		@ Free-running counter

	.text
	.align	2

@@@---------------------------------------------------------------
@@@ Configures and enables timer0 to generate interrupts at a
@@@ fixed frequency. Also configures the Generic Interrupt
@@@ Controller (GIC) to send interrupts to CPU 0.
	.global	enable_timer
enable_timer:
	ldr	    r0, =TIMER_BASE
    mov	    r1, #0x7F		@ divide clock to 1,953,125Hz
	str	    r1, [r0, #PREDIV]
	mov     r1, #0xD60    
    //ldr	    r1, =954		@ should give about 8Hz
	str	    r1, [r0, #LOAD]
	ldr	    r1, =0b1111100000000010101010
	str	    r1, [r0, #CONTROL]
	mov	    pc, lr

@@@---------------------------------------------------------------
@@@ int check_timer_interrupt()
@@@ Check and clear the timer 0 interrupt. Returns 1 if the
@@@ interrupt was active. Returns  0 otherwise.
	.global	check_timer_interrupt
check_timer_interrupt:
	ldr	    r1, =TIMER_BASE
	ldr	    r0, [r1, #MSKIRQ]
	ands	r0, #1
	strne	r0, [r1, #IRQACK]
    bl      console
    mov	    pc, lr
