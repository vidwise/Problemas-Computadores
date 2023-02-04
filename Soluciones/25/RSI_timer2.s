@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 2.
RSI_Timer2:
    push {r0-r3, lr}

    ldr r3, =status             @; Dir Mem status
    ldr r2, [r3]
    cmp r2, #2
    beq .Lreposo
    
    ldr r1, =ind_p2
    ldrb r1, [r1]
    mov r0, r2, lsl r1          @; Si hemos entrado es porque r2 = 1, lo desplazamos tantos bits como r1 y guardamos en r0 para activar rutina timer2
    bl activar_timer2
    
    mov r2, #2
    mov r0, #0x0030             @; bits 4 y 5 a 1 --> 0011 0000
    b .Lfin_reposo

.Lreposo:
    mov r0, 0x4                 @; 0100
    bl desactivar_timers
    
    mov r2, #0
    mov r0, #0x0

.Lfin_reposo:	
    strb r2, [r3]
    ldr r1, =REG_SHOOTER
    strb r0, [r1]
	
    pop {r0-r3, pc}
