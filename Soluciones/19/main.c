//
// Author: Santiago Romaní Also
//

unsigned short vel = 0;		// velocidad acumulada del viento (cm/s)
unsigned short tic_count = 0;	// tics deun intérvalo (centésimas)
unsigned char reset = 0;	// indica si se está haciendo reset

void main()
{
	unsigned short num_med = 1;		// número actual de mediciones
	
	inicializaciones();
	inicializar_timer0_01(100);		// freq. salida = 100 Hz
	do
	{
		tareas_independientes();
		if (tic_count >= 300)		// si han pasado 3 segundos
		{
			swiWaitForVBlank();
			printf("%d:\t%0.2f\n", num_med++, (float) vel / tic_count);
				// con (vel. acumulada / tiempo. intervalo)
				// se obtiene un promedio de la velocidad
				// instantánea del viento (con decimales)
			tic_count = 0;		// puesta a cero para el siguinete
			vel = 0;		// intérvalo
		}	
	} while(1);
}