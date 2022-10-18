@;RSI de la interfaz con el ascensor: se activará cada vez que el
@; ascensor llegue a una nueva planta; activará la variable global
@; 'nueva_planta' y actualizará 'planta_actual' consecuentemente;
@; además, si la planta a la que acaba de llegar el ascensor
@; estaba solicitada, parará el motor y desactivará el bit de petición
@; correspondiente.
RSI_Ascensor:
        push {r0-r7, lr}

        ldr r0, =nueva_planta
        mov r1, #1
        strb r1, [r0]           @; activar variable 'nueva_planta'

        ldr r0, =RA_Detect
        ldrh r1, [r0]           @; R1 = bits de detección de planta
        ldr r2, =RA_Botons
        ldrh r3, [r2]           @; R3 = bits de peticiones pendientes

        ldr r4, =planta_actual
        ldrb r5, [r4]           @; R5 = número de planta actual
        mov r6, #1
        mov r6, r6, lsl r5      @; R6 = máscara de planta actual
        ldr r7, =sentido
        ldrb r7, [r7]           @; R7 = sentido de movimiento actual
        cmp r7, #1
        addeq r5, #1            @; si subiendo, incrementar contador de planta
        moveq r6, r6, lsl #1    @; y mover máscara a planta superior
        subne r5, #1            @; si bajando, decrementar contador de planta
        movne r6, r6, lsr #1    @; y mover máscara a planta inferior
        strb r5, [r4]           @; actualizar variable 'planta_actual'

        tst r3, r6              @; comprobar si bit de petición activado
        beq .LRSIA_final        @; si planta actual no solicitada, salir de
                                @; la rutina de servicio de interrupción

        ldr r0, =RA_Motor
        mov r1, #0
        strb r1, [r0]           @; parar motor (inmediatamente < 5s)
        bic r3, r6              @; bit de petición de planta actual = 0
        strh r3, [r2]           @; actualizar registro RA_Botons

        .LRSIA_final:
        pop {r0-r7, pc}