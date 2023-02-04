@;
@; Author: Arey Ferrero Ramos
@;

    @; Rutina para generar la vibración del dispositivo.
    @; R0 = Frecuencia de salida de la vibración.
generar_vibración:
    push {r0-r1, r3, lr}
    
    cmp r0, #0                    @; Si la frecuencia de salida es 0 
    beq .Lparar_vibracion         @; se debe parar la vibración.
    mov r1, r0
    
    ldr r0, =32728                @; Se carga la frecuencia de entrada (frecuencia base / 1024).
    swi 9                         @; divisor_freq = freq_entrada / freq_salida.
    rsb r0, r0, #0                @; El divisor de frequencia se carga con un valor negativo.
    mov r0, r0, lsl #16           @; Se integra el divisor de frecuencia 
    orr r0, #0x000000C3           @; junto con los bits de actualización del registro de control (.               
    b .Lfin_generar_vibracion

.Lparar_vibracion:
    mov r0, #0                    @; Se guarda el parámetro para parar la vibración.

.Lfin_generar_vibracion:
    ldr r1, =TIMER0_DATA          @; El registro de datos y el registro de control de los timers son contiguos.        
    str r0, [r1]                  @; Se guarda el divisor de frecuencia en el registro de datos del timer 0 al mismo tiempo que se actualiza el registro de control de dicho timer.
    
    pop {r0-r1, r3, pc}