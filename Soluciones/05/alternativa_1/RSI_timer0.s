@;
@; Author: Arey Ferrero Ramos
@; 

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r5, lr}
    
    ldr r5, =tiempo_restante
    ldrh r4, [r5]
    subs r4, #1
    bne .Lfin_cargar_nota
    
    ldr r0, =cambio_nota
    mov r1, #1
    strb r1, [r0]
    
    ldr r0, =pos_nota
    ldrh r1, [r0]
    add r1, #1
    ldr r2, =MAX_NOTAS
    cmp r1, r2
    movhs r1, #0
    strh r1, [r0]
    
    ldr r0, =musica
    mov r3, #6
    mul r3, r1, r3
    ldrh r1, [r0, r3]
    ldrh r2, [r0, r3, #4]
    mov r0, #0
    bl activar_nota

.Lfin_cargar_nota:
    strh r4, [r5]
    
    pop {r0-r5, pc}