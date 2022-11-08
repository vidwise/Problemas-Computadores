//
// Created by aleixmt on 9/10/22.
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
        {
            frec = 5;
        }
        if (keys == KEY_Y)
        {
            frec = 20;
        }
        if (keys == KEY_A)
        {
            frec = 50;
        }
        if (frec)
        {
            generar_vibracion(frec);
            retardo(5);
            generar_vibracion(0);
        }
        swiWaitForVBlank();
        printf("La frecuencia de la última vibración activada es de %d Hz", frec);
    } while (1);
}