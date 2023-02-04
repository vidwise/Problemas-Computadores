@;
@; Author: Arey Ferrero Ramos.
@;

    @; RSI del sensor.
RSI_sensor:
    push {r0-r5, lr}
	
    ldr r4, =num_pulses
    ldrb r0, [r4]               @; Cargamos el número de pulsos.
    ldr r5, =REG_TEL
    ldrh r1, [r5]               @; Cargamos el registro REG_TEL.

    ldr r2, =TIMER0_DATA
    ldrh r2, [r2]               @; Cargamos el contador de tics.
    cmp r2, #0                  @; Si el contador de tics es mayor que 16364 se tiene que tratar el dígito (Se tiene que tener en cuenta que se da la vuelta al contador).
    blo .Ltratar_digito
    ldr r3, =16364
    cmp r2, r3                  @; Si el contador de tics es mayor que 16364 se tiene que tratar el dígito.
    bhi .Ltratar_digito

    add r0, #1                  @; Incrementamos el número de pulsos.
    mov r1, r1, lsl #1          @; Desplazamos una posición los bits del registro REG_TEL
    orr r1, #0x0002             @; y ponemos el penúltimo bit a 1.
    b .Lfin_tratar_digito

.Ltratar_digito:
    bl capture_digit
    mov r0, #1                  @; Reiniciamos el número de pulsos.
    mov r1, #0                  @; Reiniciamos el registro REG_TEL
    ldr r2, =new_digit
    strb r0, [r2]               @; Ponemos new_digit a 1 porque hay un nuevo dígito.

.Lfin_tratar_digit:
    strb r0, [r4]               @; Guardamos el nuevo valor del número de pulsos.
    strb r1, [r5]               @; Guardamos el nuevo valor del registro REG_TEL.
	
    pop {r0-r5, pc}