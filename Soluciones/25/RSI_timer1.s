@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 1.
RSI_Timer1:
    push {r0-r1, lr}
    ldr r0, =num_disp            @; Cargamos dir.mem num disp
    ldrb r1, [r0]
    cmp r1, #0
    beq .Ldetener_disparos
    sub r1, #1
    strb r1, [r0]
    ldr r0, =REG_SHOOTER
    mov r1, #0x0010
    strh r1, [r0]
    ldr r0, =status
    mov r1, #1
    strb r1, [r0]
    ldr r0, =actualizar_info
    strb r1, [r0]
    ldr r0, =350
    bl activar_timer2
    b .Lfin_detener_disparos
.Ldetener_disparos:
    mov r0, #0x3
    bl desactivar_timers
.Lfin_detener_disparos:
    pop {r0-r1, pc}
	
