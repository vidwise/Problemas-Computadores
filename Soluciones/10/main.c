short tics;             // contador de impulsos del timer
short tiempo;           // número de intervalos de 5 centésimas (0-200)
short flujo;            // nivel de flujo instantáneo (0-30)

char actualizar = 0;    // indica si hay que actualizar el gráfico
char estado = 0;        // indica el estado anterior del bit0

int main()
{
    inicializar_timer0();
    do
    {
        do
        {
            swiWaitForVBlank();
            scanKeys();
        } while (!(keysDown() & KEY_START));
        tics = 0;
        tiempo = 0;
        dibujar_ejes();
        do
        {
            swiWaitForVBlank();
            if (actualizar)
            {
                actualizar = 0;
                actualizar_grafico();
            }
        } while (tiempo < 200);
    } while (1);
    return(0);
}