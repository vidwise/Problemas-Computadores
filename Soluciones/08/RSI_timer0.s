@;
@; Author: Arey Ferrero Ramos
@;

    @; RSI del timer 0.
RSI_timer0:
    push {r0-r3, lr}
    
    ldr r0, =cont_visual
    ldrb r1, [r0]
    add r1, #1                     @; Se incrementa el contador que permite gestionar la visualización.
    cmp r1, #40
    beq .Lfin_desplazamiento
                                   @; Si el contador ha llegado a su valor máximo, se debe llevar a cabo la visualización.
    ldr r1, =desplazamiento
    ldrb r2, [r1]
    mov r3, r2, lsl #2             @; Se desplaza el valor de 'desplazamiento' para acomodarlo a los bits que le corresponden en el comando 'cursor/display shift'.
    eor r2, #0xFE                  @; Se invierte el sentido del desplazamiento para la siguiente ocasión en que el contador llegue a 40.
    strb r2, [r1]

    orr r3, #0x018                 @; Se crea el comando 'cursor/display shift' uniendo el sentido indicado por 'desplazamiento' con el bit del comando que indica 'display'.              
    ldr r1, =REG_DISPLAY
    bl sincro_display
    strh r3, [r1]                  @; Se envía comando 'cursor/display shift' en el registro REG_DISPLAY.
    
    mov r1, #0                     @; Se reinicia el contador cuando ha producido la visualización.
.Lfin_desplazamiento:
    strb r1, [r0]                  @; Se guarda el contador.
    
    pop {r0-r3, pc}