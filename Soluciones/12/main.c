//
// Author: Arey Ferrero Ramos
//

unsigned int t_in;              // Variable para almacenar las muestras de distancia.
unsigned char fase = 0;         // Variable para gestionar en que fase se encuentra el programa.

int main()
{
    int distancia, medida = 1;

    inicializaciones();
    do
    {
        tareas_independientes();
        if (fase == 0)
        {                                   // Si el programa está en la fase 0
            startPulse();                   // se tiene que generar un nuevo pulso.
        }
        else if (fase == 2)
        {                                   // Si el programa está en la fase 2
            fase = 0;
            distancia = calcular_distancia(t_in);        // se hace la media de todas las distancias
            swiWaitForVBlank();
            printf("%i: %i cm\n", medida++, distancia);  // y se imprime dicha media por pantalla.
        }
        else
        {
            swiWitForVBlank();              // Se quiere reducir el consumo de la CPU aunque el programa no esté en la fase 2.
        }
    } while (1);
    return 0;
}