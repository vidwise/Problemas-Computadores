@;
@; Author: Santiago Romaní Also
@;

@; RSI timer0: se activa a una frecuencia aproximada de 300 Hz.
@; Captura el estado de los bits A y B de los dos paddles, compara con
@; el estado anterior y, en caso de cambio, determina el sentido y
@; actualiza las variables globales correspondientes.
    .global RSI_Timer0
RSI_Timer0:
        push {r0-r3, lr}

        ldr r0, =0x0A0000000        @; a cada interrupción del timer 0
        ldrh r1, [r0]               @; R1 = estado de los dos paddles
        mov r2, r1, lsr #1
        and r2, #0x3                @; R2 = bits AB de paddle 1
        ldr r0, =f_ant1
        ldrb r3, [r0]               @; R3 = fase anterior paddle 1
        cmp r2, r3
        beq .Lcont_timer0           @; si son iguales, continua
        strb r2, [r0]               @; actualiza el valor de fase anterior
        push {r1}
        mov r0, r3
        mov r1, r2
        bl detectar_sentido         @; R0 = -1, 0 o 1
        pop {r1}                    @; restaura valor de R1
        ldr r3, =posY1
        ldrh r2, [r3]               @; R2 = posY1
        add r2, r0                  @; incrementa o decrementa posición
        strh r2, [r3]               @; actualiza variable global
        ldr r0, =dibujar1
        mov r2, #1
        strb r2, [r0]               @; dibujar1 = 1;

    .Lcont_timer0:
        mov r2, r1, lsr #4
        and r2, #0x3                @; R2 = bits AB de paddle 2
        ldr r0, =f_ant2
        ldrb r3, [r0]               @; R3 = fase anterior paddle 2
        cmp r2, r3
        beq .Lfin_timer0            @; si son iguales, finaliza RSI
        strb r2, [r0]               @; actualiza el valor de fase anterior
        mov r0, r3
        mov r1, r2
        bl detectar_sentido         @; R0 = -1, 0 o 1
        ldr r3, =posY2
        ldrh r2, [r3]               @; R2 = posY2
        add r2, r0                  @; decrementa o incrementa posición
        strh r2, [r3]               @; actualiza variable global
        ldr r0, =dibujar2
        mov r2, #1
        strb r2, [r0]               @; dibujar2 = 1;

    .Lfin_timer0:
        pop {r0-r3, pc}
