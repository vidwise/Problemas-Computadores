@; descodificar_tecla: a partir del estado de los bits b3..b0 de las
@; columnas y de la fila que se pasa por parámetro, detectar la columna
@; de mayor peso de dicha fila que presenta pulsación (bit a 0);
@; a partir de esta información (fila, columna), devolver el código
@; numérico correspondiente (fila*4+columna), o -1 si no hay pulsación
@; en la fila
@;
@; Parámetros:
@;      R0 = estado de las columnas (valor de bits b3..b0 de REG_TECL)
@;      R1 = número de fila analizada (0..3)
@;
@; Resultado:
@;      R0 = código numérico de tecla
descodificar_tecla:
    push {r2-r3, lr}

    mov r2, #3              @; R2 = código de columna testada (
    mov r3, #1              @; R3 es máscara de test (inicialmente,
    .Ldesc_col:
    tst r0, r3
    beq .Ldesc_fincol       @; salir del bucle si encuentra bit a 0
    mov r3, r3, lsl #1      @;desplazar máscara a la izquierda
    sub r2, #1              @; siguiente código columna (de mayor a menor)
    cmp r2, #0
    bge .Ldesc_col          @;repetir mientras código de columna >= 0

    mov r0, #-1             @; R0 = código de no pulsación
    b .Ldesc_fin

    .Ldesc_fincol:
    add r0, r2, r1, lsl #2  @;R0 = columna (r2) + fila*4 (r1 lsl #2)
    .Ldesc_fin:
    pop {r2-r3, pc}