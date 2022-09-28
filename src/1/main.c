//
// Created by aleixmt on 28/9/22.
//


#pragma ide diagnostic ignored "EndlessLoop"


char signal = 1;
char currentTime[6], alarm[6] = {22, 10, 26, 20, 00, 00};

void main()
{
    inicializaciones();
    do
    {
        tareas_independientes();
        inicializar_timer0();

        // Recibimos señal de la RSI
        if (signal == 1)
        {
            // Nos comunicamos con reloj y printeamos
            capturar_tiempo(currentTime);

            swiWaitForVBlank();
            mostrar_tiempo(currentTime);

            detectar_alarma(currentTime, alarm);

            // Cerramos nuestro propio paso a la siguiente iteracion del while principal
            signal = 0;
        }

    } while(1)
}
