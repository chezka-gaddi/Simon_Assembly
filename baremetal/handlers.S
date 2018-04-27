// FILE: handlers.S

// Definitions of mode field and interrupt bits in CPSR
	.equ	I_BIT, 0x80	    // when I=1 IRQ is disabled
	.equ	F_BIT, 0x40	    // when F=1 FIQ is disabled
	.equ	USR_MODE, 0x10	// shares sp,lr,CPSR with sys mode
	.equ	FIQ_MODE, 0x11	// fiq mode all interrupts masked
	.equ	IRQ_MODE, 0x12	// irq mode all interrupts masked
	.equ	SVC_MODE, 0x13
	.equ	ABT_MODE, 0x17
	.equ	UND_MODE, 0x1B
	.equ	SYS_MODE, 0x1F	// shares sp,lr,CPSR with usr mode

    .data
    .global button_set
button_set: .word   0

    .text
	.align	2

//  --------------------------------------------------------------
// On reset, jump to startup function. The CPU must not
// be in usr or sys mode! (add some code to check it)
	.global	reset_handler
reset_handler:
	b       _start

//  --------------------------------------------------------------
	.global	irq_handler
irq_handler:  			            @ must subtract 4 from lr
	stmfd	sp!, {r0-r7, lr}

    // find out which interrupt we are servicing
    bl      get_interrupt_number    @ returns in r0
    stmfd   sp!, {r0}               @ save interrupt number

    // handler body goes here
    cmp     r0, #54                 @ is it the timer interrupt?
    bleq    check_timer_interrupt	
    
    bl      console
    mov     r0, #3
    bl      led_on

return:
    ldmfd   sp!, {r0}               @ retrieve interrupt number
    bl      end_of_interrupt        @ tell GIC we are done

	ldmfd	sp!, {r0-r7, lr}
	subs	pc,  lr,  #4

//  --------------------------------------------------------------
	.global	undef_handler
undef_handler:  		@ lr holds  exact  return  address
	stmfd	sp!, {r0-r7, lr}
	
    //  handler  body  goes  here
	ldmfd	sp!, {r0-r7, lr}
	movs	pc, lr

//  --------------------------------------------------------------
	.global	swi_handler
swi_handler:  			@ lr holds  exact  return  address
	stmfd 	sp! ,{r0-r7, lr}
	
    //  handler  body  goes  here
	ldmfd	sp!, {r0-r7,  lr}
	movs	pc, lr

//  --------------------------------------------------------------
	.global	pAbort_handler
pAbort_handler:  		@ must subtract 4 from  lr
	stmfd	sp!, {r0-r7, lr}
	
    // handler body goes here
	ldmfd	sp!, {r0-r7, lr}
	subs	pc, lr, #4

//  --------------------------------------------------------------
	.global	dAbort_handler
dAbort_handler:  		@ must subtract 8 from lr
	stmfd	sp!, {r0-r7, lr}
	
    // handler body goes here
	ldmfd	sp!, {r0-r7, lr}
	subs	pc, lr, #8

// --------------------------------------------------------------
	.global	reserved_handler
reserved_handler:  		@ this will never be called
	stmfd	sp!, {r0-r7, lr}
	
    //  handler body goes here
	ldmfd	sp!, {r0-r7, lr}
	movs	pc, lr

//--------------------------------------------------------------
	.global	fiq_handler
fiq_handler:			@ must subtract 4 from lr
	stmfd	sp!, {r0-r7, lr}
	
    // handler body goeshere
	ldmfd	sp!, {r0-r7, lr}
	subs	pc, lr, #4
