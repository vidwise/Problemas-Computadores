@;transferir_radio: a partir de la dirección base de una imagen circular
@; y del número de radio (ángulo) que se pasan por parámetro, obtener el
@; estado de los bits de rojo, verde y azul para los 32 áxels, y
@; generar un patrón de 32 bits donde cada bit indicará si el LED
@; correspondiente debe estar encendido o apagado, según el estado del
@; botón SELECT:
@; soltado (=1): activar LED si el bit verde está a 1 y alguno de los
@; otros dos bits está a 1 (pero no los dos a la vez)
@; pulsado (=0): activar LED si algún bit de color está a 1,
@; La rutina envía los 32 bits resultantes por el registro de datos del
@; dispositivo.
@; Parámetros:
@; R0 = dirección base de la imagen circular
@; R1 = número de radio (ángulo : [0..255])
transferir_radio:
        push {r0-r3, lr}

        mov r2, #12
        mla r0, r1, r2, r0          @; R0 += núm.radio (ang.) * 12 bytes/ángulo
        ldr r1, [r0]                @; R1 carga bits de rojo
        ldr r2, [r0, #4]            @; R2 carga bits de verde
        ldr r3, [r0, #8]            @; R3 carga bits de azul
        ldr r0, =REG_KEYINPUT
        ldrh r0, [r0]               @; R0 carga estado botones
        tst r0, #0x04               @; comprobar estado bit de SELECT
        beq .Ltrans_select          @; saltar si bit SELECT = 0 (botón pulsado)
        eor r3, r1                  @; R3: bit activo si bit azul o rojo activo,
                                    @; pero no los dos a la vez (or exclusiva)
        and r1, r2, r3              @; R1: bit activo si bit verde y bit R3 activo
        b .Ltrans_cont
    .Ltrans_select:
        orr r1, r2
        orr r1, r3                  @; R1: bit activo si algún bit de color activo
    .Ltrans_cont:
        ldr r0, =RDISP_DATA
        str r1, [r0]                @; transferir 32 bits del radio actual

        pop {r0-r3, pc}