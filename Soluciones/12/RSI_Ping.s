@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del sensor de distancia.
RSI_Ping:
    push {r0-r2, lr}
    
    ldr r2, =fase
    ldrb r0, [r2]              @; Se carga la fase. 
    cmp r0, #0
    bne .Lcapturar_tiempo
                               @; En la fase 0 del programa
    bl cpuStartTiming          @; Se inicia el contaje de tics.
    mov r0, #1                 @; Finaliza la fase 0 del programa.
    b .Lfin_capturar_tiempo

.Lcapturar_tiempo:             @; En la fase 1 del programa
    bl cpuGetTiming            @; se captura una muestra de tiempo (tics).
    ldr r1, =25135
    sub r0, r1                 @; Se resta 25513 tics a la muestra de tiempo para descontar el tiempo que tarda el dispositivo en generar la ráfaga.
    ldr r1, =t_in
    str r0, [r1]               @; Se guarda la muestra de tiempo en el vector de muestras de tiempo.    
    mov r0, #2                 @; Finaliza la fase 1 del programa.

.Lfin_capturar_tiempo:
    strb r0, [r2]              @; Se guarda la nueva fase del programa.
    
    pop {r0-r2, pc}