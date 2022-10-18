RSI_timer0:

push{lr, r0-r8}

@; Cargamos nbits restantes i restamos 1
ldr r0, =num_bits_restantes
ldrb r1, [r0]
sub r1, #1
strb r1, [r0]


@: Cargamos el bit 4 del registro de marcas
ldr r0, =REG_MARCAS
ldr r0, [r0]
ldrb r0, [r0]
and r0, #0x10  @; 0b 0001 0000

@; Si el bit 4 esta a 0, no hace falta acumularlo
cmp r0, #0x10
bne .Fin


@; Desplazamos bit 4 del registro a la posicion de correspondiente, segun bits restantes a leer
mov r0, #1
@; mov r0, lsr #4  @; r0 = 0x1
@;sub r1, #4
mov r0, lsl r1  @; en r0 bit a acumular

@; r7 = marcas[num_filas]
ldr r2, =marcas
ldr r2, [r2]
ldr r3, =num_filas
ldr r4, [r3]

mov r5, #4
mul r6, r4, r5

ldr r7, [r2, r6]

@; marcas[num_filas] = marcas[num_filas] | bit_leido
orr r8, r7, r0
str r8, [r2, r6]



.Fin:

@; Si he acabado de leer 32 me desactivo
cmp r1, #0
bne .TimerContinue
bl desactivar_timer0



.TimerContinue:
pop{pc, r0-r8}