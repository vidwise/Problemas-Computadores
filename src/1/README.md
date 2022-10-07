
| Posición | Campo | Rangos |
|----------|-------|--------|
| 0 | Año | número del 0 al 99 (de 2000 a 2099) |
| 1 | Mes | número del 1 al 12 (de enero a diciembre) |
| 2 | Día | número del 1 al 31 (según el mes) |
| 3 | Hora | número del 0 al 23 (en modo 24 horas) |
| 4 | Minuto | número del 0 al 59 |
| 5 | Segundo | número del 0 al 59 |

Los valores del RTC estan contenidos en un array de bytes de 6 posiciones

Hay que utilizar las interrupciones del timer0 para realizar la captura del tiempo real


El total de tiempo para realizar esta comunicación supera los 500 microsegundos, por lo tanto, no se aconseja realizarla dentro de una RSI.

Todo el protocolo de comunicación se encapsulará dentro de una rutina de nombre capturar_tiempo(char *tiempo) , la cual guardará la información del tiempo real dentro del vector que se pasa por parámetro (por referencia).

En el contexto del problema, la codificación BCD (Binary Coded Decimal) son números decimales de 2 dígitos codificados dentro de un único byte, en el cual se guardan las unidades en los 4 bits de menos peso y las decenas en los 4 bits de más peso. Por ejemplo, el número en BCD 0x39 (0011 1001) representa 3 decenas y 9 unidades, o sea, el valor decimal 39.

#### Se pide
Programa principal en C, RSI del timer 0 y rutina `capturar_tiempo()` en ensamblador.

el tiempo se almacena en vector de 6 bytes 

char = byte --> strb / ldrb
short int = 2 bytes = 1 half-word --> ldrh / strh
int =~ 4 Bytes = word --> ldr / str

@calib
0x1000 xoff  | 0b0001 1111
0x1001 xoff  | 0b1000 0000
--
0x1002 yoff  | 0b1111 1111
0x1003 yoff  | 0b1111 1111

r0 0x0000 0000
ldrh r0, [#0x1000]
r0 = 0x0000 801F



r0 0x0000 0000
ldr r0, [#0x1000]
r0 = 0xFFFF 801F  @; xoff + yoff * 2^ 16



r0 0x0000 0000
ldrh r0, [#0x1002]
r0 = 0x0000 FFFF



char tiempo[6];

|              |

15 (natural bin) = 0b 0000 1111
15 (BCD) = 0b 0001 0101

06 (natural) =
 = 06 (BCD)

255 - 15 = 0b 1111 1111 - 0b 0000 1111 = 240
--> r0
and r1, r0, 0b 1111 0000  @; 0b XXXX 0000
mov r2, r1, lsr #4  @; 0b 0000 XXXX
mov r4, #10
mul r3, r2, r4  @; 10

and r2, r0, 0b 0000 1111  @; 15



add r0, r3, r2

return r0





