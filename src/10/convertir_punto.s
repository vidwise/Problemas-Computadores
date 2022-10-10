@; convertir_punto: convierte los valores de (tiempo, flujo), expresados
@; con rangos de (0-200) y (0-30) respectivamente, a valores de píxeles
@; (px, py), expresados con rangos de (20-220) y (0-180) respectivamente,
@; aplicando una inversión de la coordenada Y (si flujo = 0, py = 180).
@; Parámetros:
@;      int ppx (R0): tiempo (número de intervalos de 5 centésimas)
@;      int ppy (R1): flujo (número de impulsos por intervalo)
@; Resultado:
@;      int px (R0): coordenada X
@;      int py (R1): coordenada Y
.global convertir_punto
convertir_punto:
    push {r2, lr}

    add r0, #20         @; px = tiempo + 20
    mov r2, #6
    mul r1, r1, r2
    rsb r1, #180        @; py = 180 - flujo*6

    pop {r2, pc}