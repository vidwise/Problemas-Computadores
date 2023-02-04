@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r4, lr}
    
    ldr r0, =capturar
    ldrb r1, [r0]
    add r1, #1
    strb r1, [r0]
    
    ldr r0, =Vdigits
    ldr r3, =num_digit
    ldrb r2, [r3]
    ldrb r1, [r0, r2]
    
    ldr r0, =Vsegments
    ldrb r1, [r0, r1]
    mov r0, #0x100
    orr r1, r0, lsl r2
    add r2, #1
    
    ldr r0, =num_dent
    ldrb r0, [r0]
    cmp r2, r0
    addeq r1, #128
    
    ldr r4, =num_ddec
    ldrb r4, [r4]
    add r0, r4
    cmp r2, r0
    moveq r2, #0
    
    strb r2, [r3]    
    ldr r0, =REG_DATA
    strh r1, [r0]
    
    pop {r0-r4, pc}