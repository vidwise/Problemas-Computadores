@;
@; Author: Santiago Romaní Also
@;


@; Me entra puntero a char de 6 pos en r0
capturar_tiempo:
push{r0-r5, lr}
        bl iniciar_RTC
        mov r4, r0
        mov r0, #0x26
        bl enviar_RTC

        @; Empieza bucle
        mov r2, #0
        mov r3, #0

        .loop:

        bl recibir_RTC  @; r0 tiene el valor

        cmp r3, #3
        beq .LfinIf

        mov r1, r0, lsr #4
        and r0, #0xF
        mov r5, #10
        mla r0, r1, r5, r0
        strb r0, [r4, r2]
        add r2, #1

    .LfinIf:

        add r3, #1
        cmp r1, #7
        blo .loop

        bl parar_RTC
pop{r0-r5, pc}
