//
// Author: Santiago Romaní Also
//

#define posX1 10        // posiciones X de las raquetas (fijas)
#define posX2 240

short posY1 = 96;       // posiciones Y de las raquetas (variables)
short posY2 = 96;

char s_derecha[] = {1, 3, 0, 2};        // indicadores de la fase siguiente
char s_izquierda[] = {2, 0, 3, 1};      // para cada sentido de giro

char f_ant1 = 0;        // fases anteriores (una por raqueta)
char f_ant2 = 0;

char dibujar1 = 0;      // indicadores de necesidad de redibujar
char dibujar2 = 0;      // cada una de las raquetas

int main()
{
    inicializaciones();
    do
    {
        tareas_independientes();
        swiWaitForVBlank();
        if (dibujar1)
        {
            dibujar_raqueta(posX1, posY1);
            dibujar1 = 0;
        }
        if (dibujar2)
        {
            dibujar_raqueta(posX2, posY2);
            dibujar2 = 0;
        }
    } while (1);
    return(0);
}