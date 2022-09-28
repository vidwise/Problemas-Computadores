
push{r0, r1, r7-r9, lr}

ldr r0, =signal
mov r1, #1
strb r1, [r0]

pop{r0, r1, r7-r9, pc}