@;
@; Author: Arey Ferrero Ramos
@;

		@; RSI del timer 0.
RSI_timer0:
	push {r0-r3, lr}
	ldr r0, =Perimetro
	ldrh r0, [r0]
	ldr r1, =Nrayos
	ldrb r1, [r1]
	swi 9
	ldr r2, =Drayos
	ldrh r1, [r2]
	mul r0, r1, r0
	mov r1, #0
	strh r1, [r2]
	mov r0, r0, lsl #1
	ldr r1, =Vinst
	strh r0, [r1]
	ldr r1, =buffVinst
	ldr r3, =ind
	ldrb r2, [r3]
	strh r0, [r1, r2, lsl #1]
	add r2, #1
	cmp r2, #180
	movhs r2, #0
	strb r2, [r3]
	ldr r0, =Tdist
	ldr r0, [r0]
	ldr r2, =Ttiempo
	ldr r1, [r2]
	add r1, #1
	str r1, [r2]
	swi 9
	mov r0, r0, lsl #1
	ldr r1, =1000
	swi 9
	ldr r1, =3600
	mul r0, r1, r0
	ldr r1, =Vmed
	str r0, [r1]
	pop {r0-r3, pc}