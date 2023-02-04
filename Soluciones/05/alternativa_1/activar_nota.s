@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para activar una nota.
    @; R0 = Canal de sonido.
    @; R1 = Frecuencia de la nota.
    @; R2 = Volumen de la nota.
activar_nota:
    push {r0-r4, lr}
    
    mov r3, r0, lsl #4
    ldr r4, =0x04000400
    orr r4, r3
    orr r2, #0x88000000
    str r2, [r4]

    ldr r0, =33513982
    mov r0, r0, lsr #1
    swi 9
    rsb r0, r0, #0
    strh r0, [r4, #4]
    
    pop {r0-r4, pc}