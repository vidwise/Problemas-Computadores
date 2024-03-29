//
// Author: Arey Ferrero Ramos
//

unsigned char num_disp = 0;           // Número de disparos pendientes
unsigned char ind_p1 = 0;             // Índice del periodo p1
unsigned char ind_p2 = 0;             // Índice del periodo p2
unsigned char status = 0;             // Estado actual (0 --> parado,
                                                     // 1 --> half press,
                                                     // 2 --> half+full press)
unsigned char actualizar_info = 0;    // Indica si hay que actualizar información en pantalla

void main()
{
    int keys = 0;
    
    inicializaciones();
    do
    {
        tareas_independientes();
        
        scanKeys();
        keys = keysDown();
        if (keys & KEY_START)
        {                                           // Si se ha pulsado la tecla KEY_START.
            if (num_disp == 0)
            {                                       // Si no se ha efectuado ningún disparo
                activar_timers01(1 << ind_p1);      // se activan los timers para que se inicie los disparos.
            }
            num_disp++;                             // Se incrementa el número de disparos.
            actualizar_info = 1;
        }
        if ((keys & KEY_LEFT) && (ind_p1 > 0))
        {
            activar_timers01(1 << --ind_p1);        // Primero se decrementa el contador y después se lleva a cabo el desplazamiento de bits.
            actualizar_info = 1;
        }
        if ((keys & KEY_RIGHT) && (ind_p1 < 9))
        {
            activar_timers01(1 << ++ind_p1);        // Primero se incrementa el contador y después se lleva a cabo el desplazamiento de bits.
            actualizar_info = 1;                    
        }
        if ((keys & KEY_DOWN) && (ind_p2 > 0))
        {
            ind_p2--;
            actualizar_info = 1;
        }
        if ((keys & KEY_UP) && (ind_p2 < 9))
        {
            ind_p2++;
            actualizar_info = 1;
        }
        
        swiWaitForVBlank();                         // Se pone fuera porque la evaluación de la condición apenas ralentiza el programa y no existirán problemas de colisiones.
                                                    // Así, se disminuye el consumo de la CPU aunque no haya pulsación de teclas.
        if (actualizar_info == 1)
        {
            printf("Periodo 1: %d s\n Periodo 2: %d ms\n Disparos pendientes: %d", 1 << ind_p1, 1 << ind_p2, num_disp);
            actualizar_info = 0;
            keys = 0;
        }
    } while(1);
}
