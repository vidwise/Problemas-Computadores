Hay que controlar un número indeterminado de LEDs (aunque se explique con 4)

Para manipular el estado de encendido y apagado hay que manipular el registro REG_IO en sus bits bajos. No hay que usar 
bits que no se conecten a nada (usar mascaras para manipular el registro)

Cuando estan encendidos los LEDs emiten el 100 % de su posible intensidad y estan a 0 % cuando estan apagados. Para 
modular la intensidad habra que usar PWM que consiste en tener encendido el LED durante una fraccion de tiempo, lo que 
al ojo humano parece que hay uan reduccion de intensidad. El intervalo de tiempo en el que modularemos la intensidad es
de 33.33 ms = 1000 ms / 30 tics = T = 33,333 ms --> f = 30 tics / 1 s = 30 Hz
Es decir, que tendremos que entrar como mínimo 30 veces por segundo a la RSI para hacer el cambio de color.

Sim embargo, dentro de este intervalo de modulación, tendremos que poder subdidividir el intervalo en 20 tiempos, para
saber cuando debemos apagar el LED para hacer la modulacion de la intensidad. De esta forma, si antes habiamos calculado
un timer de 30 Hz, ahora tenemos que hacer lo mismo 20 veces más, por lo que 30 Hz * 20 = 600 Hz.
Alternativamente: 1 s / (30 cambio_color * 20 (cambio_intensidad / cambio_color) ) = 1 / 600 = 0,00166 s --> 600 Hz

Debemos apagar el LED para modular la intensidad dependiendo del porcentaje de intensidad que se nos indique, siendo un
incremento del 5 % un 1 / 600 s de más que debemos dejar el LED encendido para ver el cambio de luminosidad. 

El problema dice que si se pulsa un boton se cambia el esquema de colores por el siguiente "indicado por el usuario"
pero como no hay ninguna indicacion de como funcionan los controles lo que hare sera suponer que cualquier boton carga 
el siguiente color, usando el array de colores como un vector circular. 

La parte dificil del problema consiste en que entre la modulacion de cada color hay un periodo de cambio (10s) en que la 
transicion entre un color y otro debe ser gradual. Para tal fin debemos trazar una recta entre un punto final y un 
punto inicial, formado cada punto por el tiempo en el que se emite y el valor de intensidad de ese punto. La pendiente 
de esta recta nos indica la velocidad a la que hay que modular la intensidad de ese LED. Habra que tener en cuenta las
veces que modularemos la intensidad en ese periodo de tiempo de transición. 

Habra que ir realizando unas tareas independientes que no hace falta realizar cuando estamos realizando la gradación de
colores.

Notar también que 10 segundos = 300 cambios de tiempo = 6000 cambios de intensidad. Para hacer la gradacion durante 10 
segundos habrá que contar 300 cambios de tiempo, siendo cada "cambio de tiempo" en este estado en realidad la 
actualizacion de la intensidad de cada LED para dibujar un punto más de la recta que modela la intensidad del LED.

Este problema presenta varias incoherencias. La primera es un #define de la mascara usada para obtener los bits del 
registro. No deberia ser un define sino una variable que se calcula en funcion de NUM_LEDS:

unsigned short int BITS_LEDS = 0;
for (int i = 0; i < NUM_LEDS; i++)
{
  BITS_LEDS = BITS_LEDS & (1 << i)
}

La dificultad principal de este problema consiste en obtener la cantidad de porcentaje que debemos cambiar durante la 
gradacion de color por cada tick. Calculando la pendiente de la recta podremos ver que:
y - yi = m(x - xi) --> m = (y - yi) / (x - xi) = (100 - 75)% / (10 s) = 25 % / 300 tiks = 0.08333

Pero no podemos incrementar 0.08333 por tick debido a que trabajamos con enteros. De hecho, el porcentaje solo puede 
modificarse de 5 en 5. Usamos una regla de tres:

Por ejemplo si partimos de 25 % hasta 50 %

25 / 300 = 5 / x --> Donde x es la cantidad de ticks que debemos esperar para incrementar 5 el porcentaje:

x = 5 * 300 / 25 = 60 --> cada 60 ticks variamos 5 % 