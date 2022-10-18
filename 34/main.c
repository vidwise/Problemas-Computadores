//
// Created by aleixmt on 28/1/22.
//

// Suponemos que REG_IO (simbolico) ya viene inicializado. Se usa para manipular el hardware de los LEDs
// Sui no fuera simbolico seria un puntero
#define REG_IO = 0x23032345;

// Number of LEDs
#define NUM_LEDS 4

// Mask for the bits. This sould not be a define if we have to do this program for abitrary number of LEDs
#define BITS_LEDS 0xF
/*
unsigned short int BITS_LEDS = 0;
for (int i = 0; i < NUM_LEDS; i++)
{
  BITS_LEDS = BITS_LEDS | (1 << i)
}
*/

// Number of point samples (ticks) for every straight line during the graduation period of 10 s
#define NUM_INTERPOL 300
// Used to count the number of interpolations, which is actually what we use as x (time) in interpolations. When 300,
// gradation is off because it is at its maximum and we have to print the colours. When printing colours we increment it
// to 301 and we do not enter the printing or modulation anymore, we will scan the buttons until a button is pressed in
// order to modulate again.
// 0<gradation<300 is being processed until it reaches 300
// = 300 we are waiting for message
// = 301 we are scanning buttons
unsigned int CURRENT_NUM_INTERPOL = 300;

// Used to count the number of miniticks that need to happen to finish PWM modulation
#define NUM_MINITICK 20
// Used to count the maximum miniticks (20) for PWM modulation.
// When 0, current PWM pulse has been modulated and now we are in sync with the LEDs and can change the colors
// >0 PWM modulation is being processed
unsigned int CURRENT_NUM_MINITICK = 0;

// Positions available at colors array
#define NUM_COLOR 10;

// vector colores preestablecidos (R, G, B, W). Input de programa
unsigned char colores[MAX_COLOR][NUM_LEDS]={ {100, 0, 0, 0},    // Rojo
                                             {75, 100, 0, 15},  // Naranja
                                             {100, 100, 0, 0},  // Amarillo
                                             {15, 65, 0, 20},   // Caqui
                                             {0, 100, 0, 0},    // Verde
                                             {0, 100, 75, 5},   // Esmeralda
                                             {0, 15, 70, 30},   // Azul claro
                                             {0, 0, 100, 0},    // Azul
                                             {40, 0, 90, 5},    // Violeta
                                             {0, 0, 0, 100}     // Blanco
};



unsigned char vectPWM[NUM_LEDS];
unsigned char vectPWM_counter[NUM_LEDS]

void printColours()
{
    printf("color = (");
    for (int i = 0; i < NUM_LEDS - 1; i++)
    {
        printf("%d, ", colores[CURRENT_COLOR][i]);
    }
    printf("%d)\n\n",  colores[CURRENT_COLOR][NUM_LEDS - 1]);
}


int main()
{
    unsigned char CURRENT_COLOR = 0;
    inicializaciones();
    activar_timer0(600)
    do
    {
        // We are not in gradation and we already printed the message
        if (CURRENT_NUM_INTERPOL == NUM_INTERPOL + 1)
        {
            // Wait until timer IRQ. The last IRQ of every 30 IRQ of PWM modulation will cycle through 0 to 19 and
            // start again. If 0 PWM modulation has finished, if >0 modulation is happening
            swiWaitForIRQ();
            if (CURRENT_NUM_MINITICK == 0)
            {
                tareas_independientes();
                scanKeys();
                if (indice_boton(keysDown()) != 255)
                {
                    // Increment circular variable
                    CURRENT_COLOR = CURRENT_COLOR + 1 % NUM_COLOR;
                    // We indicate 1, so we do not process more keys during transition and we start gradation process
                    CURRENT_NUM_INTERPOL = 0;
                }
            }
        }
        else if (CURRENT_NUM_INTERPOL <= NUM_INTERPOL)
        {
            // We are in a gradation and we have to update the values to print using interpolation
            // Sync with IRQ execution
            swiWaitForIRQ();
            if (CURRENT_NUM_MINITICK == 0)
            {
                for (int i = 0; i < NUM_LEDS; i++)
                {
                    // Update the currently displayed intensity (NUM COLOR is circular! the previous element is special!)
                    // y = y0 + m * (x - x0) = y0 + (yf - y0) / (xf - x0) * (x - x0)
                    vectPWM[i] = colores[CURRENT_COLOR - 1 + 10 % NUM_COLOR][i] + (colores[CURRENT_COLOR][i] - (colores[CURRENT_COLOR - 1 + 10 % NUM_COLOR)][i]) / 300 * CURRENT_NUM_INTERPOL;
                }
                // exit this part of the main until another modulation is needed
                if (CURRENT_NUM_INTERPOL == NUM_INTERPOL)
                {
                    // This is the first and last time that we reach this code when modulation has reached 100%, then,
                    // print now the message and go to the part of the main that accepts keys
                    CURRENT_NUM_INTERPOL++;

                    // Screen sync before printing current colours
                    swiWaitForVBlank();
                    printColours();
                }
            }
        }
    } while (1);
}








