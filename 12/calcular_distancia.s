		@; Rutina para calcular la distancia a partir del tiempo transcurrido (en forma de número de tics).
		@; R0 = Número de tics correspondientes al tiempo transcurrido.
		@; Retorna la distancia por R0.
calcular_distancia:
	push {r1, r3, lr}
	mov r0, r0, lsr #1
	mov r0, #5
	mul r0, r1, r0
	ldr r1, =168000000
	bl swi9
	ldr r1, =34000
	mul r0, r1, r0
	pop {r1, r3, pc}