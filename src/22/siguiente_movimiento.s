@; siguiente_movimiento: calcula cual es el siguiente sentido del
@; movimiento del motor, según las peticiones pendientes (se supone que
@; existe al menos una), la planta actual y el sentido actual del
@; movimiento; el tercer parámetro se pasa por referencia para poder
@; ser modificado directamente en memoria desde la propia rutina; además,
@; el nuevo valor del sentido se devolverá también como resultado de la
@; rutina.
@; Parámetros:
@; R0: peticiones pendientes (unsigned short)
@; R1: valor de planta actual (unsigned char)
@; R2: referencia de la variable que memoriza el sentido actual
@; del movimiento (unsigned char *)
@; Resultado:
@; R0: siguiente sentido del movimiento (1 → subida, 2 → bajada)
siguiente_movimiento:
        push {r3-r5, lr}        @; salvar registros a modificar

        ldrb r3, [r2]           @; R3 = valor de sentido actual
        mov r4, #1
        mov r4, r4, lsl r1      @; R4 = máscara de bit de planta actual
        mov r5, r1              @; R5 = índice de búsqueda (número de planta)

        cmp r3, #1              @; comprobar sentido actual del movimiento
        bne .Lsm_bajada

    .Lsm_subida:
        mov r4, r4, lsl #1      @; máscara de piso siguiente (superior)
        add r5, #1              @; avanzar índice de piso
        cmp r5, #NUM_PLANT-1    @; si se pasa del índice máximo
        movgt r3, #2            @; cambiar el sentido de movimiento
        bgt .Lsm_actualizar
        tst r0, r4              @; mientras no detecte nueva petición,
        beq .Lsm_subida         @; continuar bucle
        b .Lsm_final            @; si hay detección, finalizar rutina sin cambio de sentido

    .Lsm_bajada:
        mov r4, r4, lsr #1      @; máscara de piso siguiente (inferior)
        sub r5, #1              @; retroceder índice de piso
        cmp r5, #0              @; si se pasa del índice mínimo
        movlt r3, #1            @; cambiar el sentido de movimiento
        blt .Lsm_actualizar
        tst r0, r4              @; mientras no detecte nueva petición,
        beq .Lsm_bajada         @; continuar bucle
        b .Lsm_final            @; si hay detección, finalizar rutina sin cambio de sentido

    .Lsm_actualizar:
        strb r3, [r2]           @;actualizar variable sentido, por referencia

    .Lsm_final:
        mov r0, r3              @; y devolver su valor como resultado

        pop {r3-r5, pc}         @;restaurar registros modificados