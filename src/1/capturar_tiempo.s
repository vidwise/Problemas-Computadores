
@; Me entra puntero a char de 6 pos en r0
capturar_tiempo:
push{r0-r3, lr}
    bl iniciar_RTC
    mov r2, r0  @; backup en r2 @ base array salida
    mov r0, #0x26
    bl enviar_RTC

    @; Empieza bucle
    mov r1, #0  @; Indice array

    .bucle1:

    bl recibir_RTC  @; r0 tiene el valor

    cmp r1, #3
    cmpeq r3, #1
    beq .FiException
    moveq r3, #1
    beq .bucle1
    .FiException:

    strb r0, [r2, r1]
    add r1, #1

    b .bucle

    bl parar_RTC
pop{r0-r3, pc}