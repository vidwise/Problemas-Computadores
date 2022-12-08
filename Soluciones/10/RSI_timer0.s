@;
@; Author: Santiago Romaní Also
@;

@; RSI timer0: se activa a una frecuencia aproximada de 2000 Hz.
@; Captura el estado del bit que introduce el tren de impulsos,
@; i lo compara con el estado anterior para determinar cuando hay un
@; nuevo impulso; actualiza el nivel de flujo para cada impulso
@; y el gráfico cada 5 centésimas de segundo.
    .global RSI_Timer0
RSI_Timer0:
        push {r0-r3, lr}            @; a cada interrupción del timer 0

        ldr r0, =0x0A0000180
        ldrb r1, [r0]               @; R1 = estado del tren de impulsos
        cmp r1, #0
        beq .Lcont_timer0           @; continúa si se encuentra en 0
        ldr r2, =estado
        ldrb r3, [r2]               @; R3 = estado anterior
        cmp r1, r3
        beq .Lcont_timer0
        strb r1, [r2]               @; actualiza estado

        ldr r0, =flujo
        ldrh r1, [r0]               @; R1 = valor actual de flujo
        add r1, #1
        strh r1, [r0]               @; incrementa el nivel de flujo

    .Lcont_timer0:
        ldr r2, =tics
        ldrh r3, [r2]               @; R3 = valor actual de tics
        add r3, #1
        strh r3, [r2]               @; incrementa el número de tics

        cmp r3, #100
        blo .Lfin_timer0            @; finaliza si todavía no han pasado
                                    @; 5 centésimas de segundo
        mov r3, #0
        strh r3, [r2]               @; tics = 0;

        ldr r2, =tiempo
        ldrh r3, [r2]               @; R3 = valor actual de tiempo
        cmp r3, #200
        bhs .Lcont2                 @; salta si tiempo supera 10 segundos
        add r3, #1
        strh r3, [r2]               @; incrementa el número de intervalos

        push {r0}
        mov r0, r3                  @; R0 = tiempo / R1 = flujo
        bl convertir_punto          @; R0 = px / R1 = py
        bl add_pixel
        pop {r0}

        ldr r2, =actualizar
        mov r3, #1
        strb r3, [r2]               @; actualizar = 1;

    .Lcont2:
        mov r1, #0
        strh r1, [r0]               @; flujo = 0;

    .Lfin_timer0:
        pop {r0-r3, pc}