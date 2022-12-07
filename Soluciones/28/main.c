//
// Author: Aleix Mariné-Tena
//

#define MAX_LETRAS 100                      // Máximo de letras por mensaje

unsigned char i_simb = 0;                   // Índice del vector simb[]
unsigned char simb[8];                      // Vector de símbolos Morse
                                                // 1 → '.' (punto)
                                                // 2 → '-' (ralla)
unsigned char i_mens = 0;                   // Índice del vector mensaje[]
char mensaje[MAX_LETRAS+1];                 // Vector de letras (string)

unsigned char cont_tics = 0;                // Contador de tics (para la RSI)
unsigned short estado_ant = 0;              // Estado anterior del pulsador
unsigned char nuevo_bloque = 0;             // código de nuevo bloque:
                                                // 0 no hay bloque pendiente →
                                                // 4 nueva letra →
                                                // 5 nueva palabra →
                                                // 6 nuevo mensaje

void main() {
    int i;
    i = inicializaciones();                 // determina tiempo de referencia
    inicializar_timer0((unsigned short) (1000 / i));
    do
    {
        swiWaitForVBlank();                 // Sincronización general para escrituras en pantallas

        recibir_mensaje();                  // Tarea independiente
        if (nuevo_bloque)                   // Detectar si hay nuevo bloque
        {
            /*
             * Para cualquier tipo de bloque, traducir, registrar, escribir símbolos y letra correspondiente.
             */
            if (i_simb > 0)
            {
                for (i = 0; i < i_simb; i++)
                {
                    printf("%c", (simb[i] == 1 ? '.' : '-'));
                }
                mensaje[i_mens] = traducir_morse(simb, i_simb);
                // Esta y la siguiente línea pueden condensarse si se usa i_mens++ al indexar
                printf("(%c) ", mensaje[i_mens]);
                i_mens++;
                i_simb = 0;                 // Restablece índice de símbolos
            }
            if ((nuevo_bloque == 5)         // Si ha llegado una nueva palabra
                && (i_mens > 0))            // y hay caracteres pendientes,
            {
                mensaje[i_mens++] = ' ';    // Registrar espacio en blanco
                printf("(SPACE) ");         // y escribir marca
            }
            if ((nuevo_bloque == 6)         // Si ha llegado un nuevo mensaje
                && (i_mens > 0))            // y hay caracteres pendientes,
            {
                mensaje[i_mens] = '\0';     // Añade el centinela
                printf("\n%s\n", mensaje);  // Escribe y envía el mensaje
                enviar_mensaje(mensaje);
                i_mens = 0;                 // Restablece índice de letras
            }
            nuevo_bloque = 0;               // Desactiva señalización bloques
        }
    } while (1);
}