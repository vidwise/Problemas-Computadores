@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r3, lr}
    
    ldr r0, =cont_visual
    ldrb r1, [r0]
    add r1, #1
    cmp r1, #40
    beq .Lfin_desplazamiento
    
    ldr r1, =desplazamiento
    ldrb r2, [r1]
    mov r3, r2, lsl #2
    eor r2, #0xFE
    strb r2, [r1]

    orr r3, #0x018
    ldr r1, =REG_DISPLAY
    bl sincro_display
    strh r3, [r1]
    
    mov r1, #0
.Lfin_desplazamiento:
    strb r1, [r0]
    
    pop {r0-r3, pc}