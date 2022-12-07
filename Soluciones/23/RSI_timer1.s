@;
@; Author: Santiago Romaní Also
@;

@; RSI del timer 1: se activa periódicamente (3 Hz) para realizar la
@; caída de la ficha, una fila por cada activación de la RSI, hasta
@; que detecte otra ficha en la fila inferior o hasta que llegue a
@; la última fila.
RSI_timer1:
        push{r0-r8, lr}

        ldr r0, =fase
        ldrb r1, [r0]           @; R1 = valor de la fase del programa
        cmp r1, #1
        bne .LRSIt1_final       @; salir si no estamos en fase de caída

        ldr r2, =fil
        ldrb r3, [r2]           @; R3 = valor de fila
        cmp r3, #8
        beq .LRSIt1_fincaida    @; finalizar caída por llegar a última fila

        ldr r4, =col
        ldrb r4, [r4]           @; R4 = valor de columna
        sub r4, #1              @; ajustar índice de columna a rango (0..7)
        ldr r5, =matriz         @; R5 = dirección inicial de la matriz de juego
        add r6, r4, r3, lsl #3  @; R6 = desplazamiento (col-1 + fil*8)
        ldrb r7, [r5, r6]       @; comprobar posición inferior (fil indica el
                                @; desplazamiento de la fila inferior,
                                @; porque el índice de filas empiezan en 0
                                @; y la variable fil empieza en 1)
        cmp r7, #0
        bne .LRSIt1_fincaida    @; finalizar caída por detectar ficha debajo

        ldr r8, =turno
        ldrb r8, [r8]           @; R8 = valor del turno
        strb r8, [r5, r6]       @; si se puede bajar la ficha, guardar turno en
        sub r6, #8              @; posición inferior y borrar posición anterior
        strb r7, [r5, r6]       @; (R7 seguro que contiene un 0)
        add r3, #1              @; bajar una fila
        strb r3, [r2]           @; actualizar variable global de fila b
        b .LRSIt1_final

    .LRSIt1_fincaida:
        mov r1, #2              @;cambiar a fase 2 cuando finaliza la caída
        strb r1, [r0]           @;actualizar variable global de fase

    .LRSIt1_final:
        pop {r0-r8, pc}