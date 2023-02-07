@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para activar una nota.
    @; R0 = Canal de sonido.
    @; R1 = Frecuencia de la nota.
    @; R2 = Volumen de la nota.
activar_nota:
    push {r0-r4, lr}
                                       
    ldr r3, =0x04000400            @; Se carga la dirección base de los registros de control de cada canal                 
    orr r3, r0, lsl #4             @; y se selecciona el registro de control correspondiente al canal que se está usando a través del propio canal (desplazado cuatro bits a la izquierda).
    orr r2, #0x88000000
    str r2, [r3]                   @; Se guarda el volumen de la nota en el registro de control a la vez que se activan los bits de incicio y de repetición activados

    ldr r0, =33513982
    mov r0, r0, lsr #1             @; Se divide la frecuencia de entrada entre 2.
    swi 9                          @; div_freq = freq_entrada / frec_salida
    rsb r0, r0, #0                 @; Se pasa el valor del divisor de frecuencia a negativo debido a la propia naturaleza de este contador
    strh r0, [r3, #4]              @; y se guarda en la posición correspondiente del registro de control.
    
    pop {r0-r4, pc}