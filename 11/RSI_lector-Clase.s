
RSI_lector:

        push {r0-r4, lr}

        ldr r1, =i_abs  @; r1 = &i_abs
        ldrb r2, [r1]  @; r2 = i_abs
        cmp r2, #0
        moveq r0, #0
        bleq cpuStartTiming
        beq .LRSIEnd

        cmp r2, #28
        bhs .LEnd


        @; t_abs[i_abs - 1] = cpuGetTiming();
        bl cpuGetTiming
        sub r3, r2, #1

        ldr r4, =t_abs

        str r0, [r4, r3, lsl #2]

    .LRSIEnd:
        add r2, #1
        strb r2, [r1]

    .LEnd:
        push {r0-r4, pc}