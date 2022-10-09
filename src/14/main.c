char currentKey = -1;        // código de tecla actual
char tempKey = -1;           // código de tecla temporal (para el barrido)
char num_fila = 0;          // número de fila actual (0..3)

int main()
{
    char prevKey = -1;       // tecla anterior (variable
    inicializaciones();
    REG_TECL = -1;           // inicialmente no se selecciona ninguna fila
    do
    {
        tareas_independientes();
        if (currentKey != prevKey)      // detección cambio de tecla
        {
            prevKey = currentKey;
            if ( currentKey != -1)           // si hay pulsación
            {
                swiWaitForVBlank();
                processKey(currentKey);
            }
        }
    } while (1);               // repetir siempre
}