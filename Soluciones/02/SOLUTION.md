# Detector de inclinación
El segundo problema trata sobre el uso de un dispositivo de expansion GBA que se usa para medir la inclinación de la 
consola. Nuestras tareas son printear los valores de inclinación en todo momento en el main en C,  implementar la RSI 
del timer0 en assembler para obtener los datos cada cierto periodo de tiempo y transformarlos usando una rutina en 
assembler implementada por nosotros mismo para hacer esta manipulacion de datos. Este problema es más sencillo y su 
dificultad radica en entender como se relacionan las estructuras de datos de C (arrays unidimensionales) con la forma de
manipular estas estructuras en assembler.