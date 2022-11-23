@; RSI timer0: se activa a la frecuencia programada (5, 20 o 50 Hz).
@; Cambia el estado del bit 1 del registro REG_RUMBLE
RSI_Timer0:
    push {r0-r1, lr}

    ldr r0, =REG_RUMBLE  @; R0 apunta al registro de E/S
    ldrb r1, [r0]  @; cargar valor actual en R1
    eor r1, #0x02  @; cambia el valor del bit 1
    strb r1, [r0]  @; actualiza registro de E/S

    pop {r0-r1, pc}