//
// Author: Arey Ferrero Ramos
//

int main()
{
    int keys;
    short frec = 0;

    inicializaciones();
    do
    {
        scanKeys();
        keys = keysDown();
        if (keys == KEY_X)
        {                                // Si se pulsa la tecla X
            frec = 5;                    // la frecuencia será de 5 Hz.
        }
        if (keys == KEY_Y)
        {                                // Si se pulsa la tecla Y
            frec = 20;                   // la frecuencia será de 20 Hz.
        }
        if (keys == KEY_A)
        {                                // Si se pulsa la tecla A
            frec = 50;                   // la frecuencia será de 50 Hz.
        }
        if (frec)
        {                                // Si se requiere una vibración (se han pulsado las teclas)
            generar_vibracion(frec);     // se genera una vibración
            retardo(5);                  // durante medio segundo.
            generar_vibracion(0);        // y se para la vibración.
        }
        swiWaitForVBlank();
        printf("La frecuencia de la última vibración activada es de %d Hz", frec);
    } while (1);
}