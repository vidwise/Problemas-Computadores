//
// Created by aleixmt on 30/1/22.
//

#define MAX_FILAS 64
unsigned char num_filas = -1;  // máximo número de filas por hoja
unsigned int marcas[MAX_FILAS]; // número de filas actual

// vector de marcas capturadas
unsigned short num_hojas = 0; // núm. hojas leídas correctamente

unsigned char num_bits_leidos = 0;

unsigned char *REG_MARCAS;


int main()
{
    inicializaciones();
    do
    {
        tareas_independientes();
        if ((*REG_MARCAS) & 0x1 && !lectura)
        {
            *REG_MARCAS = (*REG_MARCAS) | 0x80;
            lectura = 1;
        }
        else if (! ((*REG_MARCAS) & 0x1))
        {

        }
    } while (1);
}
