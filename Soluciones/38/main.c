//
// Author: Arey Ferrero Ramos.
//

#define MAX_DIGITS 14

unsigned char Ntel[MAX_DIGITS];		// Vector para almacenar el número de teléfono.
unsigned char ind_digit = 0;		// Índice del dígito actual.
unsigned char new_digit = 0;		// Si vale 1 es que hay nuevos dígitos.
unsigned char num_pulses = 0;		// Número de pulsos actual.

void main(void)
{
	unsigned char ind_digit_ant = 0; 	// Índice del dígito anterior.
	incializaciones();
	TIMER0_DATA = 0;			// Fijar divisor de frecuencia máximo.
	
	do
	{
		tareas_independientes();
		if (new_digit)
		{					// Si se han marcado nuevos dígitos.
			swiWaitForVBlank();
			if (ind_digit_ant == 0)
			{					// Si se trata del primer dígito.
				printf("Número tel.: ");
			}
			while (ind_digit_ant < ind_digit)
			{					// Visualizar dígitos pendientes.
				printf("%d", Ntel[ind_digit_ant]);
				ind_digit_ant++;
			}
			if (num_pulses == 0)
			{					// Si se ha terminado la marcación de los dígitos.
				printf("\n");
				realizar_llamada(Ntel, ind_digit);
				ind_digit_ant = 0;
				ind_digit = 0;			// Reiniciar el proceso de marcación.
			}
			new_digit = 0;
		}
	} while(1);
}