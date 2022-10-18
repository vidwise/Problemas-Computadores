RSI_lector:
  push{lr, r0-r1}

  @; num_filas + 1 si no llega a MAX_FILAS
  ldr r0, =num_filas
  ldrb r1, [r0]
  cmp r1, #MAX_FILAS
  beq .Fin
  add r1, #1
  strb r1, [r0]

  @; Cargar variable bits restantes para la rsi del timer 0
  ldr r0, =num_bits_restantes
  mov r1, #32
  strb r1, [r0]

  @; Inicializar timer 0
  mov r0, #5000
  bl inicializar_timer0


  .Fin:

  pop{pc, r0-r1}