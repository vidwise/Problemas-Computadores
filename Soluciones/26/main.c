//
// Author: Santiago Romaní Also
//

#define MAX_LETRAS 100              // Máximo de letras por mensaje

unsigned char i_simb = 0;           // Índice del vector simb[]
unsigned char simb[8];              // vector de símbolos Morse
                                        // 1 → '.' (punto)
                                        // 2 → '-' (ralla)
unsigned char i_mens = 0;           // Índice del vector mensaje[]
char mensaje[MAX_LETRAS+1];         // Vector de letras (string)
unsigned char cont_tics = 0;        // Contador de tics (para la RSI)
unsigned short estado_ant = 0;      // Estado anterior del pulsador
unsigned char nuevo_bloque = 0;     // Código de nuevo bloque:
                                        // 0 → no hay bloque pendiente
                                        // 4 → nueva letra
                                        // 5 → nueva palabra
                                        // 6 → nuevo mensaje
int main()
{
    int t = inicializaciones();  // Determina tiempo de referencia
    inicializar_timer0((unsigned short) (1000 / t));
    do
    {
        swiWaitForVBlank();  // Sincronización general para escrituras en pantallas

        recibir_mensaje();  // Tarea independiente
        if (nuevo_bloque)  // Detectar si hay nuevo bloque
        {
            if (i_simb > 0)  // Para cualquier tipo de bloque, traducir, registrar, escribir símbolos y letra correspondiente
            {
                for (int i = 0; i < i_simb; i++)
                {
                    printf("%c", (simb[i] == 1 ? '.' : '-');
                }
                mensaje[i_mens] = traducir_morse(simb, i_simb);
                printf("(%c) ", mensaje[i_mens++]);
                i_simb = 0;  // Restablece índice de símbolos
            }
            if ((nuevo_bloque == 5) && (i_mens > 0))  // Si ha llegado una nueva palabra y hay caracteres pendientes,
            {
                mensaje[i_mens++] = ' ';  // Registrar espacio en blanco
                printf("(SPACE) ");  // Y escribir marca
            }
            if ((nuevo_bloque == 6) && (i_mens > 0))  // Si ha llegado un nuevo mensaje y hay caracteres pendientes,
            {
                mensaje[i_mens] = '\0';  // Añade el centinela
                printf("\n%s\n", mensaje);  // Escribe y envía el mensaje
                enviar_mensaje(mensaje);
                i_mens = 0;  // Restablece índice de letras
            }
            nuevo_bloque = 0;  // Desactiva señalización bloques
        }
    } while (1);
}