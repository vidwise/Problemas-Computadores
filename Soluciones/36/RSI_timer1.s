@;
@; Author: Aleix Mariné-Tena
@;

RSI_timer1:

push {r0 - r5, lr}

@; Generar pulsos, invertir estado del bit 7 par control M1
ldr r2, =REG_TEL
ldrb r3, [r2]

and r4, r3, #0x80  @; 0b1000 0000
cmp r4, #0x80
moveq r5, #0
movne r5, #0x80

strb r5, [r2]

@; Comparar RA actual RA destino con circ_sub
ldr r0, =ra_objetivo
ldr r0, [r0]
ldr r1, =ra_actual
ldr r1, [r1]

bl circ_sub
@; Usar R0 para saber direccion
cmp r0, #0
movlt r2, #-1
movgt r2, #1

ldr r0, =seek_ra
ldrb r3, [r0]
cmp r3, #1
bne .NotSeeking
@; Estamos en modo busqueda

cmp r1, #120
blo .LessThan120
@; r1 => 120

mov r0, #1
ldr r1, =divfreq_vmax
ldrh r1, [r1]
bl activar_timer

ldr r2, =REG_TEL
ldrb r3, [r2]

@; r3 = 0b XX1X XXXX
@;   0x20 =0010 0000 = 1101 1111

bic r3, #0x20    @; 0b0010 0000
strb r3, [r2]

b .End



.LessThan120:
cmp r1, #0
beq .Difference0
@; Menor de 120

mov r0, #1
ldr r1, =divfreq_vmax
ldrh r1, [r1]
bl activar_timer

ldr r2, =REG_TEL
ldrb r3, [r2]

orr r3, #0x20    @; 0b0010 0000
strb r3, [r2]

b .End

.Difference0:

ldr r3, =track
mov r4, #1
strb r4, [r3]

mov r0, #1
ldr r1, =divfreq_vmin
ldrh r1, [r1]
bl activar_timer

b .End


.NotSeeking:

mov r0, #1
ldr r1, =divfreq_vmin
ldrh r1, [r1]
bl activar_timer

ldr r2, =REG_TEL
ldrb r3, [r2]
orr r3, #0x20    @; 0b0010 0000
strb r3, [r2]

.End:

ldr r3, =ra_actual
ldr r4, [r4]

@; circ_sub r1 = 1 o bvien r1 = -1
@; depende de giro grueso o fino o r3 120 o 1
@; mul r5, r1, r3
@; add r4, r5



pop {r0 - r5, pc}