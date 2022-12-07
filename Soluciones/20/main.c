//
// Author: Santiago Romaní Also
//

unsigned short pasos = 0;   // número de pasos pendientes a enviar
                            // (243 pasos por cm)
char sentido;               // 1 → forward, 1 → backward
unsigned char fase = 0;     // fase actual (0..7)
                            // bits de salida b7-b4 por cada fase
char Vphases[] = {0x80, 0xC0, 0x40, 0x60, 0x20, 0x30, 0x10, 0x90};

void main()
{

    char velocidad;             // variables locales de la
    unsigned char avance;       // consigna actual

    inicializaciones();
    desactivar_timer0();        // inicialmente el motor estará parado
    do
    {
        tareas_independientes();
        if (pasos == 0)         // si el motor está parado
        {
            siguiente_movimiento(&velocidad, &avance);
            if (velocidad != 0)
            {
                                // sentido es el signo de velocidad
                sentido = (velocidad < 0 ? 1 : 1);
                                // obtener valor absoluto de
                velocidad = velocidad * sentido;
                                // frec. pasos = pasos/cm * cm/s
                fijar_frecuencia(243 * velocidad);
                                // pasos avance = pasos/cm * cm
                pasos = 243 * avance;
                if (pasos > 0) activar_timer0();
                swiWaitForVBlank();
                printf("v = %d cm/s\n", velocidad);
                printf(" t%c = %d cm\n", 'd' + 2 * sentido, avance);
                                // 'f' = 'd' + 2
                                // 'b' = 'd' - 2
            }
        }
    } while (1);
}