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