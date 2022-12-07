@;
@; Author: Santiago Romaní Also
@;

@; normalizar_tiempos: obtiene los tiempos relativos de todos los
@; elementos de un código de barras de 6 dígitos, dividiendo los tiempos
@; absolutos por un tiempo de referencia (T) correspondiente a la anchura
@; unitaria.
@; Parámetros:
@;  R0 = dirección inicial vector t_abs[] (de enteros)
@;  R1 = dirección inicial vector t_rel[] (de bytes)
@; Resultado:
@;  Se actualiza el contenido del vector de tiempos relativos
@;  (por referencia)
normalizar_tiempos:
        push {r0-r6, lr}

        ldr r2, [r0]                @; R2 = t_abs[0]
        ldr r3, [r0, #4]            @; R3 = t_abs[1]
        ldr r4, [r0, #8]            @; R4 = t_abs[2]
        cmp r2, r3
        bls .Lnorm_cont1            @; si (R2 > R3),
        mov r6, r2
        mov r2, r3                  @; intercambio(R2, R3)
        mov r3, r6

    .Lnorm_cont1:
        cmp r3, r4
        bls .Lnorm_cont2            @; si (R3 > R4)
        mov r6, r3
        mov r3, r4                  @; intercambio(R3, R4)
        mov r4, r6

    .Lnorm_cont2:                   @; R4 = max(t_abs[0], t_abs[1], t_abs[2])
        cmp r2, r3
        bls .Lnorm_cont3            @; si (R2 > R3)
        mov r6, r2
        mov r2, r3                  @; intercambio(R2, R3)
        mov r3, r6
                                    @; R2 = min(t_abs[0], t_abs[1], t_abs[2])
    .Lnorm_cont3:
        mov r6, r3                  @; R3 = mediana(t_abs[0], t_abs[1], t_abs[2])




        T - (1 / 8) * T = (8 / 8) T - (1 / 8) T  = (7 / 8) T

        sub r6, r3, lsr #3          @; R6 = T = (7/8)R3 (reducción preventiva)
        mov r2, r0                  @; R2 = dirección inicial t_abs[]
        mov r4, r1                  @; R4 = dirección inicial t_rel[]
        mov r5, #0                  @; R5 es i (índice de elementos)

    .Lnorm_for:
        ldr r0, [r2, r5, lsl #2]    @; R0 = t_abs[i];
        mov r1, r6                  @; R1 = T;
        swi 9
        strb r0, [r4, r5]           @; t_rel[i] = t_abs[i] / T;
        add r5, #1
        cmp r5, #27
        bne .Lnorm_for

        pop {r0-r6, pc}