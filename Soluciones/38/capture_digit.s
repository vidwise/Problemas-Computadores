@;
@; Author: Arey Ferrero Ramos.
@;

    @; Rutina para capturar el dígito.
    @; R0 = Número de pulsos.
capture_digit:
    push {r1-r3, lr}
	
    ldr r1, =Ntel
    ldr r3, =ind_digit
    ldrb r2, [r3]
    strb r0, [r1, r2]           @; Se almacena el nuevo dígito en el vector que almacena el número de teléfono.
	
    add r2, #1 
    strb r2, [r3]               @; Se almacena el índice a la siguiente posición del vector.			
	
    pop {r1-r3, pc}
	