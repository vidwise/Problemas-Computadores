@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r4, lr}
    
    ldr r0, =capturar
    ldrb r1, [r0]
    add r1, #1
    strb r1, [r0]                @; Se autoriza la captura de una muestra.
    
    ldr r0, =Vdigits
    ldr r3, =num_digit
    ldrb r2, [r3]
    ldrb r1, [r0, r2]            @; Se carga el dígito del vector que contiene los dígitos del reloj indicado por el contador de dígitos.
    
    ldr r0, =Vsegments           
    ldrb r1, [r0, r1]            @; Se carga el conjunto de segmentos correspondiente al dígito cargado.
    mov r0, #0x100
    orr r1, r0, lsl r2           @; Se desplazan los bits de los segmentos tantas posiciones a la izquierda como indique el contador de dígitos y se activa el bit 8.
    add r2, #1                   @; Se incrementa el contador de dígitos.
    
    ldr r0, =num_dent
    ldrb r0, [r0]
    cmp r2, r0                   @; Si se ha tratado el último dígito de la parte entera
    addeq r1, #128               @; se suma el valor correspondiente al segmento '.' al conjunto de segmentos del dígito tratado.
    
    ldr r4, =num_ddec
    ldrb r4, [r4]
    add r0, r4                   
    cmp r2, r0                   @; Si se ha tratado el último dígito
    moveq r2, #0                 @; Se restablece el contador de dígitos.
    
    strb r2, [r3]                @; Se actualiza el valor del contador de dígitos. 
    ldr r0, =REG_DATA
    strh r1, [r0]                @; Se guarda el conjunto de segmentos correspondientes al dígito tratado en el registro REG_DATA.
    
    pop {r0-r4, pc}