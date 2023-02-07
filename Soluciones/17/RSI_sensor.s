@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del sensor de distancia.
RSI_sensor:
    push {r0-r1, r3, lr}
	
    ldr r0, =Drayos
    ldrh r1, [r0]	
    add r1, #1
    strh r1, [r0]                       @; Se incrementa el número de rayos por segundo cada vez que un rayo pasa por delante del sensor.
	
    ldr r0, =Perimetro
    ldrh r0, [r0]
    ldr r1, =Nrayos
    ldrb r1, [r1]
    swi 9                               @; R0 = Perímetro / Nrayos.
	
    ldr r3, =Tdist
    ldr r1, [r3]
    add r1, r0                          @; Se acumula la distancia entre dos rayos sobre la distancia total.
    str r1, [r3]                        @; Se guarda la distancia total.	
	
    pop {r0-r1, r3, pc}
