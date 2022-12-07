@;
@; Author: Santiago Romaní Also
@;

@; intr_main: rutina principal de gestión de las interrupciones;
@; comprueba si se ha activado la RSI del timer 0 y, en caso afirmativo,
@; invoca a la rutina RSI_timer0();
@; además, debe notificar la resolución de cualquier IRQ que se haya
@; producido al controlador de interrupciones y a la posición global
@; de memoria INTR_WAIT_FLAGS
intr_main:
    push {r0-r2, lr}

    ldr r0, =REG_IF
    ldr r1, [r0]            @; R1 = valor actual de REG_IF
    tst r1, #IRQ_TIMER0     @; verificar si se ha activado IRQ_TIMER0
    blne RSI_timer0         @; en caso afirmativo, llamar la RSI específica

    str r1, [r0]            @; marcar todas las IRQ activadas en REG_IF
    ldr r2, =INTR_WAIT_FLAGS
    str r1, [r2]            @; ídem en INTR_WAIT_F LAGS

    pop {r0-r2, pc}