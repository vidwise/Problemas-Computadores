@;
@; Author: Arey Ferrero Ramos
@;

		@; RSI del timer 0.
RSI_timer0:
	push {r0-r1, lr}
	ldr r0, =REG_RUMBLE
	ldrb r1, [r0]
	eor r1, #0x02
	strb r1, [r0]
	pop {r0-r1, pc}