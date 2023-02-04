@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 2.
RSI_Timer2:
    push {r0-r3, lr}

    ldr r3, =status             
    ldr r2, [r3]                @; Se carga el estado.
    cmp r2, #2
    beq .Lreposo
                                @; Si el estado es 1
    ldr r1, =ind_p2
    ldrb r1, [r1]
    mov r0, r2, lsl r1          @; se desplaza el valor 1 tantos bits como indique ind_p2 para obtener p2.
    bl activar_timer2
    
    mov r2, #2                  @; se pasa al estado 2.
    mov r0, #0x0030             @; Se activan los bits half press + full press.
    b .Lfin_reposo

.Lreposo:                       @; Si el estado es 2
    mov r0, #0x04               
    bl desactivar_timers        @; se desactivan los timers.
    
    mov r2, #0                  @; se pasa al estado 0.
    mov r0, #0x00               @; se desactivan los bits half press + full press.

.Lfin_reposo:	
    strb r2, [r3]               @; Se guarda el nuevo valor de estado.
    ldr r1, =REG_SHUTER
    strb r0, [r1]               @; Se actualiza el registro REG_SHUTTER con los valores correspondientes de half press + full press.
	
    pop {r0-r3, pc}
