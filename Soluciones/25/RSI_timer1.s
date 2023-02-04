@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 1.
RSI_Timer1:
    push {r0-r1, lr}
    
    ldr r0, =num_disp            
    ldrb r1, [r0]                   @; Se carga el número de disparos.
    cmp r1, #0
    beq .Ldetener_disparos
                                    @; Si quedan disparos
    sub r1, #1                      @; se disminuye el número de disparos.
    strb r1, [r0]
    
    ldr r0, =REG_SHUTER
    mov r1, #0x0010
    strh r1, [r0]                   @; se activa el bit half press del registro REG_SHUTTER. 
    
    mov r1, #1
    ldr r0, =status
    strb r1, [r0]                   @; se pasa al estado 1.
    ldr r0, =actualizar_info
    strb r1, [r0]                   @; se activa la variable booleana 'actualizar_info'.
    
    ldr r0, =350
    bl activar_timer2               @; se activa el timer 2 con un periodo de 350 ms.
    
    b .Lfin_detener_disparos

.Ldetener_disparos:                 @; Si no quedan disparos
    mov r0, #0x3
    bl desactivar_timers            @; se paran los timers.

.Lfin_detener_disparos:
    pop {r0-r1, pc}
	
