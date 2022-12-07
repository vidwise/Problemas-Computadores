@;
@; Author: Santiago Romaní Also
@;

@; RSI del timer 0: se activa 256*25 veces por segundo;
@; se utilizará para transferir una linea de píxeles circulares al
@; display de revolución, es decir, un radio con 32 áxels, según la
@; imagen circular actual 'current_ci' y el ángulo actual 'current_ang',
@; además de incrementar el ángulo y ponerlo a cero cuando llegue al
@; límite (256); también debe resetear el valor del ángulo si se detecta
@; la activación del bit de puesta a cero.
RSI_timer0:
    push {r0-r2, lr}

    ldr r0, =circ_img
    ldr r1, =current_ci
    ldr r1, [r1]                @; R1 = número actual de imagen circular
    cmp r1, #1
    addeq r0, #256 * 12         @; R0 apunta al inicio de imagen circular act.
    ldr r2, =current_ang
    ldr r1, [r2]                @; R1 = ángulo actual
    bl transferir_radio
    add r1, #1                  @; incrementar ángulo actual
    cmp r1, #256                @; si ángulo >= 256,
    movhs r1, #0                @; resetear ángulo actual

    ldr r0, =RDISP_STATUS
    ldrh r0, [r0]               @; R0 = bit de puesta a cero
    tst r0, #1                  @; si bit a 1
    movne r1, #0                @; también hay que resetear ángulo actual

    str r1, [r2]                @;actualizar variable global

    pop {r0-r2, pc}