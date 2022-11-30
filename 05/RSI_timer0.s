@; RSI timer0: se activa a 100 veces por segundo (100 Hz) y decrementa
@; el tiempo restante de la nota actual: si llega a 0, carga la siguiente
@; nota.
RSI_Timer0:
        push {r0-r4, lr}

        ldr r0, =tiempo_restante
        ldrh r1, [r0]           @; R1 = tiempo_restante
        sub r1, #1
        cmp r1, #0              @; verificar si se acabó el tiempo
        bne .Lfin_rsi_timer0

        ldr r2, =nota_actual
        ldrh r3, [r2]           @; R3 = nota_actual
        add r3, #1
        cmp r3, #MAX_NOTAS      @; verificar si final de música
        bne .Lno_final_musica
        mov r3, #0              @; vuelta a empezar
    .Lno_final_musica:
        strh r3, [r2]           @; actualizar nota_actual

        ldr r2, =musica         @; R2 = dir. base vector música
        mul r4, r3, #6          @; R4 = offset de nota actual
        push {r0, r2}
        mov r0, #0              @; canal 0
        ldrh r1, [r2, r4]       @; frecuencia
        ldrh r2, [r2, r4, #4]   @; volumen
        bl activar_nota
        pop {r0, r2}
        ldrh r1, [r2, r4, #2]   @; R1 = tiempo restante nota actual

        ldr r2, =cambio_nota
        mov r4, #1
        strh r4, [r2]           @; cambio_nota = 1

    .Lfin_rsi_timer0:
        strb r1, [r0]           @; actualizar tiempo_restante

        pop {r0-r4, pc}