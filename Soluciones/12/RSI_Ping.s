		@; RSI del sensor de distancia.
RSI_Ping:
	push {r0-r2, lr}
	ldr r2, =fase
	ldrb r0, [r2]
	cmp r0, #0
	beq .Lcapturar_tiempo
	bl cpuStartTiming
	mov r0, #1
	b .Lfin_capturar_tiempo
.Lcapturar_tiempo:
	bl cpuGetTiming
	ldr r1, =25135
	sub r0, r1
	ldr r1, =t_in
	str r1, [r0]
	mov r0, #2
.Lfin_capturar_tiempo:
	strb r0, [r2]
	pop {r0-r2, pc}