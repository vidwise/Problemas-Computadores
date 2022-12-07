@;
@; Author: Aleix Mariné-Tena
@;

@; RSI_timer0
RSI_timer0:
    push {r0-r6, lr}

    @; decrementar current bit
    ldr r0, =curr_bit
    ldrb r1, [r0]
    sub r1, #1
    @; strb r1, [r0]

    @; Obtener bitcode de letra a transmitir actualmente
    ldr r2, =curr_ind
    ldrb r3, [r2]

    ldr r6, =transmsg
    ldrb r6, [r6, r3]  @; indice a nbcode

    ldr r4, =nbcode  @; r4 = @nbcode
    ldr r5, [r4, r6 lsl #2]
    and r5, r5, #0x00 FF FF FF  @; r5 = bitcode

    @; poner bit 5 de REG_DATA a ese bit sin modificar el resto de REG_DATA
    mov r5, r5 lsr r1
    and r5, r5, #0x1  @; r5 = 00000000000X
    ldr r4, =REG_DATA
    ldrh r6, [r4]

    mov r5, r5 lsl #5
    orr r6, r5
    strh r4, [r6]

    @; Si curr_bit == 0 entonces siguiente letra
    cmp r1, #0
    bne .End

    @; curr_bit == 0
    ldr r4, =lontr
    ldrb r4, [r4]
    sub r4, #1
    cmp r4, r1
    beq .LEndTimer

    @; current bit == 0 pero lontr - 1 != curr_index
    add r3, #1
    strb r3, [r2]

    ldr r5, [r4, r3 lsl #2]
    mov r5, r5, lsr #24
    strb r5, [r0]
    b .End

.LEndTimer:
    mov r0, #0
    bl desactivar_timer

.End:
    pop {r0-r6, pc}