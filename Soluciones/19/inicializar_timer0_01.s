@;
@; Author: Santiago Romaní Also
@;

@; inicializar_timer0_01: pasada una frecuencia por parámetro, calcula
@; el divisor de frecuencia para el timer0 y lo activa, utilizando la
@; segunda frecuencia de entrada más alta (523.657 Hz).
@; Parámetros:
@; 	R0: frecunecia de salida requerida, en Hz
inicializar_timer0_01:
	push {r0-r3, lr}	@; salvar reg. modificaciones (R3 por swi 9)
	
	ldr r2, =TIMER0_DATA	@; R2 apunta a registros de E/S del timer 0
	mov r1, r0		@; R1 = frec. salida (denominador)
	ldr r0, =-523657	@; R0 = frec. entrada (numerador)
	swi 9			@; llamada a la bios para dividir
	strh r0, [r2]		@; escibir TIMER0_DATA
	mov r0, #0xC1		@; activar timer/int., selec. frec. ent. = 01
	strh r0, [r2, #2]	@; escribir TIMER0_CR

	pop {r0-r3, pc}