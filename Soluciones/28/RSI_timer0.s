@;
@; Author: Aleix Mariné-Tena
@;

@; RSI del timer0:
@; Se activará cada tic del timer0, correspondiente al tiempo de referencia de los elementos del código Morse;
@; En caso de final de activación del pulsador, debe almacenar los símbolos 1 o 2 en el vector global simb[], en la
@; posición i_simb, y actualizar dicha posición;
@; En caso de final de desactivación del pulsador, debe determinar el tipo de espacio (códigos 3, 4, 5 o 6) y, para
@; códigos > 3, notificarlo a través de la variable global nuevo_bloque.
RSI_timer0:
        push {r0-r5, lr}

        ldr r0, =cont_tics
        ldrb r1, [r0]  @; R1 = contador de tics
        add r1, #1
        strb r1, [r0]  @; Incrementar el contador
        cmp r1, #9
        bhi .LRSI_finmens @; Forzar fin de mensaje

        ldr r2, =REG_DATA
        ldr r2, [r2]  @; R2 = valor registro de E/S
        and r2, #0x8000  @; Filtrar el valor del bit 15
        ldr r3, =estado_ant
        ldrh r4, [r3]  @; R4 = estado anterior del bit 15
        cmp r4, r2
        beq .LRSI_fin

        @; Detección cambio de estado del bit 15
        strh r2, [r3]  @; Actualizar variable 'estado_ant'
        cmp r2, #0
        bne .LRSI_findes  @; Final de activación

        cmp r1, #3
        movlo r5, #1  @; Detección de punto
        movhs r5, #2  @; Detección de ralla
        ldr r2, =simb
        ldr r3, =i_simb
        ldrb r4, [r3]
        strb r5, [r2, r4]  @; Guardar símbolo en vector simb
        add r4, #1
        strb r4, [r3]  @; Actualizar índice símbolos
        b .LRSI_tics0

    .LRSI_findes:  @; Final de desactivación
        cmp r1, #2
        bls .LRSI_tics0  @; Detección espacio entre símbolos
        cmp r1, #5
        movls r5, #4  @; Detección espacio entre letras
        bls .LRSI_set_nuevo_bloque
        cmp r1, #9
        movls r5, #5  @; Detección espacio entre palabras
    .LRSI_finmens:
        movhi r5, #6  @; Detección final de mensaje
    .LRSI_set_nuevo_bloque:
        ldr r2, =nuevo_bloque
        strb r5, [r2]
    .LRSI_tics0:  @; Reiniciar contador de tics
        mov r1, #0
        strb r1, [r0]
    .LRSI_fin:
        pop {r0-r5, pc}