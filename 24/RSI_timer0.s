@; 100 Hz
@; Pre --> i_fon = 0;
@; REG_MOUTH ya tiene cargado fonemas[0]
@; num_fon > 0
push {r0-r3, lr}
    ldr r0, =i_fon  @; r0 = @i_fon
    ldrb r1, [r0]  @; r1 = i_fon

    ldr r2, =fcs  @; r2 = char @fcs
    ldrb r3, [r2, r1]  @; r3 = fcs[i_fon]

    cmp r3, #0
    beq .LNextChar
    @; bne implicito
    sub r3, #1
    strb r3, [r2, r1]
    b .Lfin


.LNextChar:
    add r1, #1

    ldr r2, =num_fon  @; r2 = @num_fon
    ldrb r2, [r2]  @; r2 = num_fon
    cmp r1, r2
    bne .LLoadChar
    @; beq implicito, hemos terminado la palabra actual, cerramos todo

    ldr r2, =REG_MOUTH  @; r2 = @REG_MOUTH
    mov r3, #0
    str r3, [r2]  @; ponemos bit 31 a 0.
    bl desactivar_timer0  @; desactivar timer

    mov r1, #-1
    strb r1, [r0]  @; i_fon = -1

    b .Lfin

.LLoadChar:
    strb r1, [r0]  @; actualizar i_fon a siguiente valor
    ldr r0, =fonemas
    ldr r2, [r0, r1]

    orr r2, r2, #0x8000 0000
    ldr r0, =REG_MOUTH  @; r0 = @REG_MOUTH
    str r2, [r0]

.Lfin:

pop {r0-r3, pc}