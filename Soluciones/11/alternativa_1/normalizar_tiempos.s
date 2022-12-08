@;
@; Author: Aleix Mariné-Tena
@;

@;             normalizar_tiempos(int* t_abs, char* t_rel);
normalizar_tiempos:

        push {r0-r6, lr}
        mov r5, r0
        mov r6, r1

        ldr r2, [r0]
        ldr r3, [r0, #4]
        ldr r4, [r0, #8]

        add r2, r3
        add r3, r4

        mov r0, r3
        mov r1, #3
        swi 9  @; (T1 + T2 + T3) / 3

        mov r2, r0  @; r2 = T = promedio(T1, T2, T3)





        mov r3, #0  @; i = 0
    .LbucleGuardar:
        ldr r0, [r5, r3, lsl #2]
        mov r1, r2
        swi 9
        strb r0, [r6, r3]

        add r3, #1
        cmp r3, 27
        bne .LbucleGuardar

        pop {r0-r6, pc}