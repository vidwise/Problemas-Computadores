@; RSI del timer 0: se activa 40 veces por segundo, de modo que se
@; utilizará para activar el barrido de una fila, aunque se
@; interpretarán las columnas activas de la fila anterior,
@; lo cual introducirá un retardo de 25 milisegundos entre activación
@; de fila y consulta de columnas correspondientes.
@; La RSI fijará el código de tecla en la variable global currentKey
@; después de analizar las 4 filas de cada barrido completo del teclado.
RSI_timer0:
    push {r0-r6, lr}

    ldr r6, =REG_TECL
    ldrh r0, [r6]           @; R0 = valor actual de REG_TECL
    ldr r2, =num_fila
    ldrb r1, [r2]           @; R1 = número de fila actual
    bl descodificar_tecla   @; R0 = código de tecla de fila actual
    ldr r3, =tempKey
    ldsb r4, [r3]           @; R4 = código temporal de tecla
    cmp r0, r4
    ble .Lkey_cont1
    mov r4, r0              @; actualizar R4 si código de fila actual
                            @; es mayor que código temporal del barrido
.Lkey_cont1:
    add r1, #1              @; pasar a siguiente fila
    cmp r1, #4
    blo .Lkey_cont2
    ldr r5, =currentKey     @; si estamos en la “quinta” fila (R1==
    strb r4, [r5]           @; Actualizar currentKey con código temporal
    mov r4, #-1             @; reset código temporal
    mov r1, #0              @; reset número de fila

.Lkey_cont2:
    strb r4, [r3]           @; actualizar código de tecla temporal
    strb r1, [r2]           @; actualizar número de fila actual
    mov r0, #0x10
    mvn r0, r0, lsl r1      @; R0 tiene el bit de fila actual a cero
    strh r0, [r6]           @; actualiza REG_TECL para siguiente interrupción

.Lkey_fin:
    pop {r0-r6, pc}