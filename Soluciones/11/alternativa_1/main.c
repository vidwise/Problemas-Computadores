//
// Author: Aleix Mariné-Tena
//

#define NUM_ELEMS 27


int t_abs[NUM_ELEMS];
char i_abs = 0;

void main()
{
    char t_rel[NUM_ELEMS];

    inicializaciones();
    do
    {
        tareas_independientes();

        if (i_abs > NUM_ELEMS)
        {
            normalizar_tiempos(t_abs, t_rel);

            swiWaitForVBlank();
            decodificar_codigo(t_rel);
            i_abs = 0;
        }

    } while(1)

}