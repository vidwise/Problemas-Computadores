@; RSI del timer 0: se activará a la frecuencia de pasos calculada
@; según la velocidad de rotación requerida del motor; a cada
@; activación debe cambiar de fase, según el sentido actual de avance
@; y la fase anterior; además, debe decrementar el número de pasos
@; pendientes, y parar el timer si dicho número ha llegado a cero.
RSI_timer0:
    push {r0-r2, lr}
    ldr r0, =fase
    ldrb r1, [r0]           @; R1 es fase actual
    ldr r2, =sentido
    ldsb r2, [r2]           @; R2 es sentido de avance
    add r1, r2              @; actualizar fase (inc. o
    and r1, #7              @; módulo 8 para actualización circular
    strb r1, [r0]           @; actualiza variable global '
    ldr r0, =Vphases
    ldrb r2, [r0, r1]       @; R2 es estado de los bits de salida
                            @; según la nueva fase
    mov r0, #0x0A000000     @; R0 es dirección registro E/S
    ldr r1, [r0]            @; R1 es valor actual del reg. E/S
    bic r1, #0xF0           @; limpiar bits b7-b4
    orr r1, r2              @; añadir bits de fase
    str r1, [r0]            @; actualiza reg. E/S

    ldr r0, =pasos
    ldrh r1, [r0]           @; decrementa contador de pasos restantes
    subs r1, #1             @; si llega a cero, FZ = 1
    bleq desactivar_timer0  @;si FZ = 1, parar las interrupciones
    strh r1, [r0]

    pop {r0-r2, pc}