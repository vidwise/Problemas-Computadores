@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para insertar dos strings en el display LCD.
    @; R0 = str1.
    @; R1 = str2.
insertar_strings:
    push {r0-r2, lr}
    
    mov r2, r1                   @; Se traslada la dirección base del primer string para no perderla.           
    mov r1, #0x080               @; R1 = Comando para fijar la dirección base.        
    bl insertar_string           @; Se inserta el primer string.
    
    mov r0, r2
    mov r1, #0x0C0
    bl insertar_string           @; Se inserta el segundo string.
    
    pop {r0-r2, pc}

