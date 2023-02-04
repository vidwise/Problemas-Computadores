@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r1, lr}
    
    ldr r0, =REG_RUMBLE
    ldrb r1, [r0]            @; Se carga el contenido del registro REG_RUMBLE 
    eor r1, #0x02            @; y se activa el bit 1 si estava desactivado o se desactiva en caso contrario. 
    strb r1, [r0]
    
    pop {r0-r1, pc}