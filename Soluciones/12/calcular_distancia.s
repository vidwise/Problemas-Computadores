@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para calcular la distancia a partir del tiempo transcurrido (en forma de número de tics).
    @; R0 = Número de tics correspondientes al tiempo transcurrido.
    @; Retorna la distancia por R0.
calcular_distancia:
    push {r1, r3, lr}
    
    mov r1, r0, lsr #1         @; Se divide el número de tics entre 2.
    mov r0, #5
    mul r0, r1, r0             @; Se multiplica el número de tics por 5
    
    ldr r1, =168000000
    swi 9                      @; y se divide entre 168000000 para pasarlo a segundos.
    
    ldr r1, =34000
    mul r0, r1, r0             @; Se multiplica el tiempo por 34000 para obtener la distancia (cm).
    
    pop {r1, r3, pc}