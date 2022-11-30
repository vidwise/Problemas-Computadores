//
// Created by aleixmt on 28/9/22.
//



#pragma ide diagnostic ignored "EndlessLoop"



// Señales de RSI al main
short int inclin_X, inclin_Y;
short int calib[6];

void main()
{
    inicializaciones();
    inicializar_timer0();
    calibrar_inclinacion(calib);
    do
    {
        tareas_independientes();

        swiWaitForVBlank();
        dibujar_inclinacion(inclin_X, inclin_Y);
    } while (1);
}
