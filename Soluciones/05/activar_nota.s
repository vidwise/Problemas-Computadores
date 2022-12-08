@;
@; Author: Santiago Romaní Also
@;

@; activar_nota: dado un canal, una frecuencia y un volumen,
@; activa la generación de sonido por ese canal por un tiempo indefinido
@; Parámetros:
@;      short canal (R0): canal de sonido (0..15)
@;      short frec (R1): frecuencia requerida, en Hz
@;      short vol (R2): volumen requerida (0..127)
activar_nota:
    push {r0-r3, lr}

    and r0, #0xF            @; filtra valor de canal
    and r2, #0x7F           @; filtra valor de volumen
    push {r0}
    ldr r0, =33513982
    mov r0, r0, lsr #1      @; R0 = frecuencia de entrada
    swi 9
    rsb r3, r0, #0          @; R3 = -(frec_entrada / frec_salida)
    pop {r0}
    mov r0, r0, lsl #4      @; desplazar canal 4 bits a la izquierda
    ldr r1, =0x04000400
    orr r1, r0              @; R1 = dirección registro de control
    strh r3, [r1, #4]       @; guardar valor divisor de frecuencia
    orr r2, #0xA0000000     @; activar bits inicio + bucle infinito
    strh r2, [r1]           @; guardar valor registro control

    pop {r0-r3, pc}