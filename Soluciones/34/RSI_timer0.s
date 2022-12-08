@;
@; Author: Aleix Mariné-Tena
@;

@; Every 1 / 30 s (1 TICK) start PWM cycle. if gradation in progress, update percentage intensity values regarding the
@; linear ratio between the last valid intensities and the destiny intensities
@; Every 1 / 600 s (1 MINITICK = 1 TICK / 20) perform PWM cycle
RSI_timer0:
    push{lr}

        @; cycle through CURRENT_NUM_MINITICK for each minitick
        ldr r0, =CURRENT_NUM_MINITICK
        ldr r1, [r0]
        add r1, #1
        cmp r1, #20
        moveq r1, #0
        str r1, [r0]
        beq .tick_process
        @; Minitick process


        mov r0, #REG_IO  @; direction
        ldrh r1, [r0]  @; value

				


        .tick_process:
        @; On tick update CURRENT_NUM_INTERPOL
        ldr r0, =CURRENT_NUM_INTERPOL
        ldr r1, [r0]
        cmp r1, #300
        addlt r1, #1
        strlt r1, [r0]




    pop{pc}
