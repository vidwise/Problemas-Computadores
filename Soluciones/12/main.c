//
// Created by aleixmt on 7/11/22.
//

unsigned int t_in;
unsigned char fase = 0;

int main()
{
    int distancia, medida = 1;

    inicializaciones();
    do
    {
        tareas_independientes();
        if (fase == 0)
        {
            startPulse();
        }
        else if (fase == 2)
        {
            fase = 0;
            distancia = calcular_distancia(t_in);
            swiWaitForVBlank();
            printf("%i: %i cm\n", medida++, distancia);
        }
        else
        {
            swiWitForVBlank();
        }
    } while (1);
    return 0;
}