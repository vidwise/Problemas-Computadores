//
// Author: Santiago Romaní Also
//

#define NUM_PLANT 4                 // número de plantas a gestionar
unsigned char planta_actual = 0;    // número de planta actual
unsigned char sentido = 1;          // sentido de movimiento actual
                                    // = 1 → subida,
                                    // = 2 → bajada

unsigned char nueva_planta = 0; // indica si el ascensor ha llegado a una nueva planta

void main()
{
    int i;

    inicializaciones();
    do
    {
        tareas_independientes();
        if ((RA_Botons != 0) && (RA_Motor == 0))  // si hay peticiones pendientes y el motor está parado
        {
            cerrar_puerta();
            RA_Motor = siguiente_movimiento(RA_Botons, planta_actual, &sentido);
        }

        if (nueva_planta)  // comprobar si hay detección de llegada a una nueva planta
        {
            nueva_planta = 0;  // desmarcar variable
            swiWaitForVBlank();
            printf("Planta: %d\n", planta_actual);
            printf("Peticiones:\n\t");
            for (i = NUM_PLANT-1; i >= 0; i--)
            {
                // escribir peticiones pendientes
                if (RA_Botons & (1 << i)) printf(“%d “, i);  // planta solicitada
                else printf(“_ “);  // planta no solicitada
            }
            printf("\n");
            if (RA_Motor == 0)  // en caso de motor parado
                abrir_puerta();
        }
    } while (1);
}