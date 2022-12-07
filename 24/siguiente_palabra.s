@; int siguiente_palabra(char *string);
@; Entrada:
@; r0 = @String (salida)
@;
@; Salida:
@; r0 = num_char en @String
siguiente_palabra:
    push {r1-r4, lr}

    ldr r1, =REG_IPC_FIFO_CR  @; r1 = @REG_IPC_FIFO_CR
    ldr r2, =REG_IPC_FIFO_RX
    mov r3, #0

.Lbucle:
    ldr r4, [r1]
    and r4, r4, #0x0000 0080  --> 0b 0000000000000000 0000 0000 1000 0000 @; tst r4, #0x0000 0080
    cmp r4, #0x0000 0080
    beq .Lvacio

    ldrb r4, [r2]
    strb r4, [r0, r3]
    add r3, #1
    b .Lbucle

.Lvacio:
    mov r1, #0
    strb r1, [r0, r3]
    mov r0, r3

    pop {r1-r4, pc}