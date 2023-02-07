@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r3, lr}
	
    ldr r0, =Perimetro
    ldrh r0, [r0]                       @; Cargamos el perímetro.
    ldr r1, =Nrayos
    ldrb r1, [r1]                       @; Cargamos el número de rayos.
    swi 9                               @; R0 = Perímetro / Nrayos.

    ldr r2, =Drayos
    ldrh r1, [r2]                       @; Cargamos el número de rayos por segundo.
    mov r3, #0
    strh r3, [r2]                       @; Reiniciamos el contador de rayos por segundo.
	
    mul r0, r1, r0                      @; R0 = (Perímetro / Nrayos) * Drayos.
    mov r0, r0, lsl #1                  @; Vinst = Drayos * (Perímetro / Nrayos) * 2.
    ldr r1, =Vinst
    strh r0, [r1]                       @; Guardamos la muestra actual de velocidad instantánea.
	
    ldr r1, =buffVinst
    ldr r3, =ind
    ldrb r2, [r3]
    strh r0, [r1, r2, lsl #1]           @; Guardamos la nueva muestra de velocidad instantánea en el buffer con las velocidades instantáneas.
    add r2, #1
    cmp r2, #180                        @; Si el índice del búffer de velocidades instantáneas es mayor que 180
    movhs r2, #0                        @; se reinicia a 0 (buffer circular).			
    strb r2, [r3]
	
    ldr r0, =Tdist
    ldr r0, [r0]                        @; Cargamos la distancia total.
    ldr r2, =Ttiempo
    ldr r1, [r2]                        @; Cargamos el contador de tiempo total.
    add r1, #1                          @; Incrementamos el contador de tiempo total. 
    str r1, [r2]			
    swi 9                               @; Vmed (cm / ss) = Tdist / Ttiempo
	
    mov r0, r0, lsl #1                  @; Vmed (cm / s)
    ldr r1, =1000
    swi 9                               @; Vmed (dam / s)
    ldr r1, =3600
    mul r0, r1, r0                      @; Vmed (dam / h)
    ldr r1, =Vmed
    str r0, [r1]                        @; Guardamos la velocidad media.
	
    pop {r0-r3, pc}