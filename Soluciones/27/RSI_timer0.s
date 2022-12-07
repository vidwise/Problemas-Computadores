//
// Created by aleixmt on 21/10/22.
//

@; RSI del timer0: se activará a cada tic del timer0 (cada 25 ms);
@;  debe refrescar la visualización de una posición del display de
@;  números, fijando los bits de selección de posición, 7 segmentos
@;  y punto decimal correspondientes en el registro REG_DATA;
@;  solo se refrescan las posiciones que contengan algún valor
@;  significativo en el vector Vdigits[], según el formato decimal
@;  registrado en las variables globales num_dent y num_ddec.
RSI_timer0:
        push {r0-r7, lr}

        ldr r0, =cont_tics
        ldrb r1, [r0]               @; R1 = contador de tics
        add r1, #1
        cmp r1, #40                 @; Comprobar si ha pasado un segundo
        blo .LRSI_nosec
        ldr r2, =nuevo_sec
        mov r3, #1
        strb r3, [r2]               @; Marcar nuevo segundo
        mov r1, #0                  @; Restablecer contador
    .LRSI_nosec:
        strb r1, [r0]               @; Actualizar variable contador

        ldr r0, =cont_pos
        ldrb r1, [r0]               @; R1 = contador de posición
        ldr r2, =Vsegments          @; R2 = dirección Vsegments
        ldr r3, =Vdigits            @; R3 = dirección Vdigits
        ldrb r4, [r3, r1]           @; R4 = dígito en posición actual
        ldrb r5, [r2, r4]           @; R5 = bits de 7 segmentos

        mov r6, #1
        mov r6, r6, lsl r1          @; R6 = máscara para bits de pos.
        orr r5, r6, lsl #8          @; Añadir bits pos. a bits 7 segm.

        ldr r6, =num_dent
        ldrb r7, [r6]               @; R7 = número de dígitos enteros

        add r1, #1                  @; Incrementar contador posición
        cmp r1, r7                  @; (pos+1 == num_dent)?
        orreq r5, #0x80             @; En caso afirmativo, activar punto decimal

        ldr r6, =num_ddec
        ldrb r4, [r6]               @; R4 = número de dígitos decimales
        add r7, r4
        cmp r1, r7                  @; (pos+1 == num_dent + num_ddec)?
        moveq r1, #0                @; En caso afirmativo, volver a posición inicial

        strb r1, [r0]               @; Actualizar contador posiciones

        ldr r2, =REG_DATA
        strh r5, [r2]               @; Fijar 12 bits del reg. E/S

        pop {r0-r7, pc}