@;
@; Author: Santiago Romaní Also.
@;

@; RSI del timer 0: se activará a 100 Hz, para contabilizar el número de
@; 	impulsos que genera el anemómetro y poner el biestable J-K a cero,
@;	además de contabilizar el paso del tiempo (centésimas de segundo).
RSI_timer0:
	push {r0-r3, lr}
	
	mov r0, #0x0A000000		@; R0 es dirección del registro E/S
	ldr r1, [r0]			@; R1 captura bits de registro E/S
	ldr r2, =reset			
	ldrb r3, [r2]			@; R3 = 1 si la interrupción anterior
	cmp r3, #1			@; activó el reset del J-K
	beq .LRSIt0_reset1

.LRSIt0_reset0:
	tst r1, #0x20			@; testear bit 5
	beq .LRSIt0_cont		@; continuar si es cero
	
	bic r1, #0x10			@; desactiva el bit 4 del registro E/S
	str r1, [r0]			@; lo cual activa el reset del J-K
	mov r3, #1
	strb r3, [r2]			@; memoriza 1 en la variable global 'reset'
	
	ldr r0, =vel
	ldrh r1, r0			@; R1 = acumulador de cm/s
	add r1, #112			@; (1,12 m/s por impulso detectado)
	strh r1, [r0]			@; actualiza la variable global 'vel'

	b .LRSIt0_cont

.LRSIt0_reset1:
	orr r1, #0x10			@; activa el bit 4 del registro E/S
	strh r1, [r0]			@; lo cual desactiva el reset del J-K
	mov r3, #0
	strb r3, [r2]			@; memoriza 0 en la variable global 'reset'
	
.LRSIt0_cont:
	ldr r0, =tic_count
	ldrh r1, [r0]			@; R1 = contador de tics
	add r1, #1
	strh r1, [r0]			@; actualiza la variable global 'tic_count'

	pop {r0-r3, pc}			














