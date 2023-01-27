//
// Author: Arey Ferrero Ramos
//

unsigned short Perimetro;
unsigned char Nrayos;
unsigned short Drayos;		// Drayos++ && Drayos = 0
unsigned short Vinst;		// Vinst = Drayos * (Perimetro / Nrayos) * 2
unsigned int Vmed;		// Vmed = Tdist / Ttiempo * 2 / 1000 * 3600
unsigned int Tdist;		// Tdist = Tdist + Perimetro / Nrayos
unsigned int Ttiempo;		// Ttiempo++
unsigned char ind;
unsigned short buffVinst[180];

void main()
{
	inicializaciones();
	do {
		tareas_independientes();
		scanKeys();
		if (keysDown() == KEY_START)
		{
			Drayos = 0;
			Tdist = 0;
			Ttiempo = 0;
			for (ind = 0; ind < 180; ind++)
			{
				buffVinst[ind] = 0;
			}
			ind = 0;
		}
		swiWaitForVBlank();
		representarInfo(Vinst, Vmed, Tdist, buffVinst, ind);
	} while(1);
}

