//
// Author: Santiago Romaní Also
//

unsigned char matriz[8][8];                 //valores de los LEDs, en cada posición:
                                            // = 0 → vacía (apagado)
                                            // = 1 → ficha jugador 1 (rojo)
                                            // = 2 → ficha jugador 2 (verde)
unsigned char turno = 1;                    // número de jugador actual

unsigned char fil = 1, col = 4;             // fila y columna de la ficha que se está colocando

unsigned char fase = 0;                     // fase actual del programa:
                                            // = 0 → seleccionar columna
                                            // = 1 → caída de ficha
                                            // = 2 → comprobar ganador
                                            // = 3 → final de partida

unsigned char f_refresco = 0;               // índice de fila que se tiene
                                            // que refrescar en el display
void main()
{
    int keys;
    inicializaciones();                     // la matriz estará toda a ceros,
    matriz[0][col - 1] = turno;             // excepto la posición de salida
    do
    {
        swiWaitForVBlank();                 // relajar bucle principal
        switch (fase)
        {
        case 0:                             // selección de columna
            scanKeys();
            keys = keysDown();
            if ((keys & KEY_LEFT) && (col > 1))
            {
                matriz[0][col - 1] = 0;
                col--;
                matriz[0][col - 1] = turno;
            }
            if ((keys & KEY_RIGHT) && (col < 8))
            {
                matriz[0][col-1] = 0;
                col++;
                matriz[0][col-1] = turno;
            }
            if ((keys & KEY_SELECT) && (matriz[1][col - 1] == 0))
            {
                printf("Jug: %d\tCol: %d\n", turno, col);
                fase = 1;
            }
        break;
        case 1:                             // esperar caída de ficha
        break;
        case 2:
            if (comprobar_4(&matriz[1][0], 7, 8))  // detección de ganador
            {
                mostrar_ganador(turno);
                fase = 3;                   // programa finalizado
            }
            else                            // cambio de turno
            {
                turno = 3 - turno;
                fil = 1;
                col = 4;           // inicializaciones para
                matriz[0][col-1] = turno;   // la nueva selección
                fase = 0;
            }
        break;
        }
        }
    } while (1);
}