@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para insertar un único string en el display LCD.
    @; R0 = string.
    @; R1 = Comando para fijar la dirección base.
insertar_string:
    push {r0-r3, lr}
    
    ldr r2, =REG_DISPLAY
    bl sincro_display
    strh r1, [r2]
    
    mov r1, #0
.Lnueva_posicion:
    
    ldrb r3, [r0, r1]
    orr r3, #0x200
    bl sincro_display
    strh r3, [r2]
    
    add r1, #1
    cmp r1, #MAX_ELEMENTS
    blo .Lnueva_posicion
    
    pop {r0-r3, pc}

