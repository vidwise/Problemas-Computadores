@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para generar la vibración del dispositivo.
    @; R0 = Frecuencia de salida de la vibración.
generar_vibración:
    push {r0-r1, r3, lr}
    
    cmp r0, #0
    beq .Lparar_vibracion
    mov r1, r0
    
    ldr r0, =32728
    swi 9
    rsb r0, r0, #0
    mov r0, r0, lsl #16
    orr r0, #0x000000C3
    b .Lfin_generar_vibracion

.Lparar_vibracion:
    mov r0, #0

.Lfin_generar_vibracion:
    ldr r1, =TIMER0_DATA
    str r0, [r1]
    
    pop {r0-r1, r3, pc}