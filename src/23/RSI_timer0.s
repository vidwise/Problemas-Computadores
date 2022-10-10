@; RSI del timer 0: se activa periódicamente (240 Hz) para realizar el
@; refresco de una fila de LEDs, en función del contenido de la
@; variable global 'matriz'.
RSI_timer0:
        push {r0-r7, lr}        @;salvar registros a modificar

        ldr r0, =f_refresco
        ldrb r1, [r0]           @; R1 = fila de refresco actual, rango (0..7)
        ldr r2, =matriz
        add r2, r1, lsl #3      @; R2 = dirección inicial de fila de refresco

        mov r3, #0              @; R3 = índice de columna
        mov r4, #0x80           @; R4 = máscara de activación de una columna
        mov r5, #0xFF           @; R5 = patrón de bits de columnas en rojo
        mov r6, #0xFF           @; R6 = patrón de bits de columnas en verde
    .LRSIt0_for:
        ldrb r7, [r2, r3]       @; R7 = valor en la matriz (columna actual)
        cmp r7, #1              @; comprobar si es jugador 1
        biceq r5, r4            @; activar bit (=0) en patrón de rojos
        cmp r7, #2              @; comprobar si es jugador 2
        biceq r6, r4            @; activar bit (=0) en patrón de verdes
        mov r4, r4, lsr #1      @; desplazar máscara
        add r3, #1              @; y avanzar índice de siguiente columna
        cmp r3, #8
        blo .LRSIt0_for         @; cerrar bucle

        mov r7, r6, lsl #16     @; R7 = patrón de bits verdes (desplazados)
        orr r7, r5, lsl #8      @; añadir patrón de bits rojos (desplazados)

        rsb r3, r1, #7          @; invertir f_refresco a núm. bit (R3 = 7 - R1)
        mov r4, #1
        mov r4, r4, lsl r3      @; crear máscara de activación del bit de fila
        orr r7, r4              @; añadir al total de bits
        ldr r2, =RegMLED
        str r7, [r2]            @; escribir registro de Entrada/Salida

        add r1, #1              @; pasar a la siguiente fila de refresco
        cmp r1, #7              @; si supera el último índice (7),
        movhi r1, #0            @; volver a empezar por la fila 0
        strb r1, [r0]           @; actualizar variable global 'f_refresco'

        pop {r0-r7, pc}         @; restaurar registros modificados