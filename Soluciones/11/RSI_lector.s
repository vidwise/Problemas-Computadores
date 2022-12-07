@;
@; Author: Santiago Romaní Also
@;

@; RSI del lector: se activa cada vez que el haz de luz detecta un cambio
@; de intensidad (de claro a oscuro o de oscuro a claro).
RSI_Lector:
        push {r0-r3, lr}

        ldr r1, =i_elem
        ldr r2, [r1]                @; R2 = valor actual de i_elem
        cmp r2, #0
        beq .L_lector_0             @; en primera interrup. solo inicia cronómetro
        cmp r2, #T_ELEM
        bhi .L_fin_lector           @; filtra posibles interrupciones sobrantes
        bl cpuGetTiming             @; R0 = número tics respecto int. anterior
        ldr r3, =t_abs
        sub r2, #1                  @; ajustar R2 a índice anterior
        str r0, [r3, r2, lsl #2]    @; t_abs[i_elem-1] = cpuGetTiming();
        add r2, #1                  @; restablecer R2 a índice actual;
    .L_lector_0:
        mov r0, #0
        bl cpuStartTiming           @; iniciar cronómetro para siguiente int.
        add r2, #1
        str r2, [r1]                @; i_elem++;
    .L_fin_lector:
        pop {r0-r3, pc}