@;
@; Author: Santiago Romaní Also
@;

@; generar_vibración: dada una frecuencia por parámetro, calcula el
@; divisor de frecuencia para el timer0 y lo activa; si la frecuencia
@; es cero, desactiva el
@; Parámetros:
@; R0 = frecuencia requerida, en Hz
generar_vibracion:
    push {r0-r3, lr}        @;salvar reg. modificados (R3 por swi 9)

    ldr r2, =TIMER0_DATA    @; R2 apunta a registros de timer0
    cmp r0, #0
    beq .Lfin_vibracion

    mov r1, r0              @; R1 = frec. salida (denominador)
    ldr r0, =32728          @; R0 = frec. entrada (numerador)
    swi 9                   @; llamada a la BIOS (dividir)
    rsb r0, r0, #0          @; negar el divisor de frecuencia
    mov r0, r0, lsl #16
    mov r0, r0, lsr #16     @; poner a 0 los 16 bits altos
    orr r0, #0x00C30000     @; adjuntar valores para TIMER0_CR
                            @; (bit 7 = 1 , bit 6 = 1 bits 10 = 11)

    .Lfin_vibracion:
    str r0, [r2]            @; fijar TIMER0_DATA y TIMER0_CR
                            @; si R0 = 0, para la vibración
    pop {r0-r3, pc}
