#define T_ELEM = 27             // se supone que todos los códigos constan
                                // de 27 elementos (barras y espacios)

int t_abs[T_ELEM];              // vector de tiempos absolutos
char t_rel[T_ELEM];             // vector de tiempos relativos

int i_elem;                     // índice del elemento que se está leyendo
                                // actualmente
void main()
{
    inicializaciones();
    i_elem = 0;                 // primera inicialización del índice
    do
    {
        tareas_independientes();
        if (i_elem > T_ELEM)    // vector lleno i_elem = 28
        {
            normalizar_tiempos(t_abs, t_rel);
            swiWaitForVBlank();
            decodificar_codigo(t_rel);
            i_elem = 0;         // inicialización para siguiente código
        }
    } while (1);
}