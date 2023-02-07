@;
@; Author: Arey Ferrero Ramos
@; 

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r5, lr}
    
    ldr r5, =tiempo_restante
    ldrh r4, [r5]
    subs r4, #1                   @; Cada vez que ocurre una interrucpción se reduce el tiempo restante para que siga sonando de la nota.
    bne .Lfin_cargar_nota
                                  @; Si el tiempo restante ha llegado a 0.
    ldr r0, =cambio_nota
    mov r1, #1
    strb r1, [r0]                 @; Se indica que se ha producido un cambio de nota.
    
    ldr r0, =pos_nota
    ldrh r1, [r0]
    add r1, #1                    @; Se incrementa el índice del vector de notas.
    ldr r2, =MAX_NOTAS
    cmp r1, r2                 
    movhs r1, #0                  @; y se asegura que no se haya excedido el límite.
    strh r1, [r0]
    
    ldr r0, =musica
    mov r3, #6
    mul r3, r1, r3                @; Cada nota ocupa 6 Bytes, por lo que el índice del vector de notas debe multiplicarse por 6.
    ldrh r1, [r0, r3]             @; R1 = Frecuencia.
    ldrh r2, [r0, r3, #4]         @; R2 = Volumen.     
    mov r0, #0                    @; R0 = Canal 0.
    bl activar_nota

.Lfin_cargar_nota:
    strh r4, [r5]                 
    
    pop {r0-r5, pc}