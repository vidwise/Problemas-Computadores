@;
@; Author: Aleix Mariné-Tena
@;

RSI_timer0:
push{r0-r5, lr}
bl iniciar_MK6

mov r0, #0
bl enviar_MK6
bl recibir_MK6
mov r1, r0  @; acel X
ldr r0, =inclin_X  @; @inclin_X
@; r2 offX, r3 sensX
ldr r4, =calib  @; @@calib
ldr r4, [r4]  @; @calib
ldrh r2, [r4]  @; r2 = xoff

mov r5, #6
ldrh r3, [r4, r5]
bl convertir_aceleracion

@; Y

mov r0, #0x2
bl enviar_MK6
bl recibir_MK6
mov r1, r0
ldr r0, =inclin_Y

mov r5, #2
ldrh r2, [r4, r5]

mov r5, #8
ldrh r3, [r4, r5]
bl convertir_aceleracion


pop{r0-r5, pc}