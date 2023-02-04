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
    strh r1, [r2]               @; Se fija la dirección base del string con el comando 'DDRAM Address set'
    
    mov r1, #0
.Lnueva_posicion:
    
    ldrb r3, [r0, r1]           @; Se carga una elemento (byte) del string. 
    orr r3, #0x200              @; Se construye el comando 'DDRAM or CGRAM write' con un elemento del string.
    bl sincro_display
    strh r3, [r2]               @; Se escribe el elemento del string en el display.
    
    add r1, #1
    cmp r1, #MAX_ELEMENTS       @; Se comprueba si se ha llegado al final del string.
    blo .Lnueva_posicion
    
    pop {r0-r3, pc}

