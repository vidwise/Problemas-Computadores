
@; Me entra puntero a char de 6 pos en r0
capturar_tiempo:
push{r0-r4, lr}
    bl iniciar_RTC
    mov r2, r0  @; backup en r2 @ base array salida
    mov r0, #0x26
    bl enviar_RTC

    @; Empieza bucle
    mov r1, #-1  @; Indice array
    mov r4, #0  @; weekday found 

    .bucle1:

    bl recibir_RTC  @; r0 tiene el valor

    cmp r1, #3
    bne .sumAndNext 
    
    @; we are receiving the fourth trash value or the fifth correct value
    cmp r4, #1
    beq .next  @; we have good value in r0, and the bad value is in the position r3 of the array. Overwrite the value by no incrementing index
    
    @; currently the bad value in r0
    mov r4, #1
    add r1, #1  @; this and the following instruction could be only "bne .sumAndNext" with one less instruction but doing a useless memory access by writing the trash values temporarily into the array
    bne .bucle1

    .sumAndNext
    add r1, #1
    .next:
    strb r0, [r2, r1]

    b .bucle1

    bl parar_RTC
pop{r0-r4, pc}
