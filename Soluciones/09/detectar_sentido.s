@;
@; Author: Santiago Romaní Also
@;

@; detectar_sentido: verifica el sentido de movimiento dadas dos fases
@; consecutivas, utilizando los vectores globales s_derecha y s_izquierda
@; Parámetros:
@;      char f_ant (R0): fase anterior
@;      char f_act (R1): fase actual
@; Resultado:
@;      R0 : +1 si derecha, -1 si izquierda, 0 si no coincide con ningún
@;      sentido.
detectar_sentido:
        push {r2, r3, lr}

        ldr r2, =s_derecha
        ldrb r3, [r2, r0]           @; R3 = s_derecha[f_ant]
        cmp r1, r3
        bne .Lno_derecha            @; if (f_act = s_derecha[f_ant])
        mov r0, #1                  @; return(1);
        b .Lfin_detectar_sentido

    .Lno_derecha:                   @; else
        ldr r2, =s_izquierda
        ldrb r3, [r2, r0]           @; R3 = s_izquierda[f_ant]
        cmp r1, r3
        bne .Lno_izquierda          @; if (f_act == s_izquierda[f_ant])
        mov r0,                     #-1 @; return(-1);
        b .Lfin_detectar_sentido

    .Lno_izquierda:
        mov r0, #0                  @; else return(0);

    .Lfin_detectar_sentido:
        pop {r2, r3, pc}
