//
// Author: Arey Ferrero Ramos.
//

typedef struct                                          // Coordenadas de sprites
{
    short px;                                           // [-64..288]
    short py;                                           // [-32..224]
} t_pos;

t_pos ang_pos[360];                                     // Vector con posiciones (px, py) para cada ángulo

unsigned char bpm = 60;                                 // "Beats" por minuto
unsigned char accent = 4;                               // Divisiones para generar el acento
unsigned char paused = !0;                              // Metrónomo pausado? (!0: sí, 0: no)

unsigned int ang_actual = 0;                            // Ángulo actual (en formato Q12)
unsigned int fraccion = ((bpm / accent) / 10) << 12;    // Incremento del ángulo en un VBL (Q12)

int main(void)
{
    inicializaciones();
    do
    {
        tareas_independientes();
        if (gestionar_botones())
        {                                               // Actualizar fracción según nuevos
	    fraccion = ((bpm / accent) / 10) << 12;     // Valores de bpm i accent
        }
        swiWaitForVBlank();
        actualizar_pantallas();
        // activar_beat();
    } while(1);
}