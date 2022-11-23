
@; r0: @incl
@; r1: acel
@; r2: off
@; r3: sens
convertir_aceleracion:
push{r0-r5, lr}

@; (acel_X - off)
sub r1, r1, r2

ldrh r4, [r0]
mla r5, r1, r3, r4
strh r5, [r0]

pop{r0-r5, pc}