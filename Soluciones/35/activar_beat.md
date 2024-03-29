A continuación se ofrece una recopilación de las conclusiones que se deben ir extrayendo, a partir de la información 
proporcionada por el problema, para resolver la cuestión de si la rutina activar_beat() debe ser llamada desde el main 
o desde la RSI del Vertical Blank.
 -	De entrada, debemos valorar el tiempo de ejecución de la rutina activar_beat(), que es 5 us. Atendiendo a que el 
	tiempo de ejecución máximo que puede tener una RSI es 100 us, podemos concluir que no existe ninguna limitación 
	temporal para llamar a la rutina activar_beat desde la RSI.
 -	Seguidamente, deberíamos valorar si la rutina activar_beat() tiene que seguir una periodicidad estricta. En el caso 
	de las RSIs ligadas a los timers, esto es fundamental dado que la frecuencia del bucle principal del programa no
	tiene ningún tipo de relación con la frecuencia de los timers. Esto implica que nuca se podrá saber que instrucción 
	del bucle principal se estará ejecutando cuando se produzca la interrupción. En estos casos, si la rutina debe seguir 
	una periodicidad estricta, se llamará siempre desde la RSI. No obstante, en este problema la RSI está ligada a la 
	interrupción del vertical blank. Esto significa que, al incorporar la instrucción swiWaitForVBlank() en el programa 
	principal, la RSI del vertical blank y el bucle principal se ejecutarán a la misma frecuencia y las instrucciones 
	contenidas en la RSI del vertical blank se ejecutaran entre las llamadas a las rutinas swiWaitForVBlank() y 
	actualizar_pantallas() desde el main. En consecuencia, podríamos decir que la rutina activar_beat() se ejecutará con 
	una periodicidad igual de estricta tanto si se llama desde el main como si se llama desde la RSI.
 -	Por último, se debe evaluar la funcionalidad que realiza la propia rutina, que en este caso es generar un sonido
	relacionado con la colocación de un sprite concreto en ciertos puntos de la pantalla. Aquí se debe destacar que, 
	idealmente, la actualización de las pantallas y la generación de sonido se deberían realizar en paralelo pero, por la
	naturaleza del problema, se llevaran a cabo de forma concurrente. Así pues, mientras se cumpla la condición de que la
	llamada a la rutina actualizar_pantallas() y la llamada a la rutina activar_beat() se ejecuten lo más cerca posible la 
	una de la otra, no es importante cual se ejecutará primero. Esto implica que primero se puede ejecutar la llamada a la
	rutina activar_beat() desde la RSI y después la llamada a la rutina actualizar_pantallas() desde el main o primero la 
	llamada a la rutina actualizar_pantallas() desde el main y después la llamada a la rutina activar_beat() también desde el
	main.
Como se puede ver, con la información de que se dispone, no se ha podido determinar si la rutina activar_beat() debe ser llamada
desde el main o desde la RSI del Vertical Blank. Hay otros criterios que se podrían tener en cuenta como, por ejemplo, si 
existe un riesgo alto de que varias interrupciones tengan lugar entre la llamada a la rutina actualizar_pantallas() y la llamada
a la rutina activar_beat(), o si dentro de la rutina actualizar_pantallas() se modifican primero los gráficos del modo frame 
buffer (250 us aprox.) o los gráficos de los Sprites (0'5 us aprox.), pero esta información, además de que no consideramos que sea
especialmente relevante, tampoco se proporciona en el enunciado del problema.
	