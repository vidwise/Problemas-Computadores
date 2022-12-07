//
// Author: Santiago Romaní Also
//


int main() {
    short frec;  // variables locales
    int keys;
    inicializaciones();
    do {
        swiWaitForVBlank();  // ajustar velocidad encuesta periódica
        scanKeys();
        keys = keysDown();  // captura pulsación actual
        frec = 0;  // determinar frecuencia de vibración
        if (keys & KEY_X) frec = 5;
        if (keys & KEY_Y) frec = 20;
        if (keys & KEY_A) frec = 50;
        if (frec != 0) {
            generar_vibracion(frec);  // activar vibración
            retardo(5);  // esperar medio segundo
            generar_vibracion(0);  // parar vibración
            swiWaitForVBlank();
            printf("Ultima frecuencia = %d Hz n", frec);
        }
    } while (1);
    return (0);
}