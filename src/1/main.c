//
// Created by aleixmt on 30/1/22.
//
#pragma ide diagnostic ignored "EndlessLoop"


// Año, Mes, Día, Hora, Minuto, Segundo
char alarma[] = {16, 10, 26, 17, 0, 0};
char captura = 0;
int main()
{
    inicializaciones();
    inicializar_timer0();
    do
    {
        tareas_independientes();

        if (captura)
        {

        }
    } while (1);
}

