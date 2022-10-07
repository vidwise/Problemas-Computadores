
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

    .loop:

    bl recibir_RTC  @; r0 tiene el valor

    cmp r1, #2  @; we check with 2 because the index is equal to the num of signals -1 (for the offset) -1 (for counting with 0), to check for the fourth signal
    bne .sumAndNext 
    
    @; we are receiving the fourth trash value or the fifth correct value
    cmp r4, #1
    beq .sumAndNext  @; we have good value in r0, keep iterating
    
    @; currently the bad value in r0
    mov r4, #1  @; now we know we have seen the trash value
    bne .loop  @; continue 

    .sumAndNext
    add r1, #1
    .next:
    strb r0, [r2, r1]

    cmp r1, #5
    bne .loop

    bl parar_RTC
pop{r0-r4, pc}
