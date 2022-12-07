# Boca artificial

Este problema trata sobre controlar un periférico capaz de vocalizar y emitir sonidos, emulando una boca humana. Para 
ello dispondremos de un registro de E/S que usaremos para controlar las cuerdas vocales del dispositivo, la nariz, la
lengua y el paso de aire. Los bits de este registro controlan directamente elementos mecánicos de la boca que permiten
la modulación de la pronunciación. Nuestro objetivo será el de recibir palabras por Wi-Fi, usando el ARM7, que será 
transparente para nosotros en este ejercicio. Estas palabras seran reenviadas al ARM9 (el que ejecutará la totalidad del
código implementado) usando el sistema de comunicación entre los dos procesadores IPC-FIFO. Las palabras serán 
decodificadas por una función que viene implementada que transformará nuestro array de carácteres en dos arrays que 
tendran tantas posiciones como fonemas tengamos que pronunciar para la palabra actual. El primer vector contendrá los 
valores que tendremos que escribir en nuestro registro de control del dispositivo y el segundo el tiempo que durará el 
fonema en centésimas de segundo.

El control de tiempo, la gestión del cambio de fonema y la gestión del final de la palabra se realizará desde la RSI de 
un timer. El primer fonema debe prepararse desde el main. Habrá que sincronizar main y timer para que trabajen 
conjuntamente de forma coordinada.