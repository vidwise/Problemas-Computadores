//
// Author: Arey Ferrero Ramos
//

unsigned short Perimetro;	// Perímetro de la rueda. Valor fijo.
unsigned char Nrayos;		// Número de rayos de la rueda. Valor fijo.
unsigned short Drayos;		// Número de rayos por segundo. Valor variable -> Drayos++ && Drayos = 0
unsigned short Vinst;		// Velocidad instantánea (cm/s). Valor variable -> Vinst = Drayos * (Perimetro / Nrayos) * 2
unsigned int Vmed;		// Velocidad media (dam/h). Valor variable -> Vmed = Tdist / Ttiempo * 2 / 1000 * 3600
unsigned int Tdist;		// Distancia total (cm). Valor variable -> Tdist = Tdist + Perimetro / Nrayos
unsigned int Ttiempo;		// Tiempo total (semisegundos). Valor variable -> Ttiempo++
unsigned char ind;		// Índice posición actual buffer Vinst.
unsigned short buffVinst[180];			

void main()
{
    inicializaciones();			
    do 
    {
        tareas_independientes();
        scanKeys();
        if (keysDown() == KEY_START)
        {                                       // Si se ha pulsado la tecla start
            Drayos = 0;                         // Reiniciar los contadores.
            Tdist = 0;
            Ttiempo = 0;
            for (ind = 0; ind < 180; ind++)
            {                                   // Reiniciar el buffer con las velocidades instantáneas.
                buffVinst[ind] = 0;
            }
            ind = 0;
        }
        swiWaitForVBlank();
        representarInfo(Vinst, Vmed, Tdist, buffVinst, ind);
    } while(1);
}

