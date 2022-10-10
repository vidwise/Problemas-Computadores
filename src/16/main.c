int current_ang = 0;        // valor actual del ángulo
int current_ci = 0;         // identificador imagen circular actual (0..1)
unsigned char rect_img[64 * 64];
unsigned int circ_img[2][256 * 3];

void main()
{
    inicializaciones();
    do
    {
        swiWaitForVBlank();
        tareas_independientes();
        if (wifiReceiveImage(rect_img))     // si recepción nueva imagen
        {
            convertirImagen(rect_img, circ_img[1 - current_ci]);
            swiWaitForVBlank();
            mostrarImagen(rect_img);
            current_ci = 1 – current_ci;
        }
    } while (1);            // repetir siempre
}