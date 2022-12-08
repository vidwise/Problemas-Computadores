# Escritura Morse

Cálculo de S = ...

... = 0b10101000 --> {8}

8 tic / 1 s = freq salida

freq entrada = {2^15, 2^19, 2^23, 2^29} Hz
0 <= divisor de frecuencia <= 1024
freq salida = 8 tic / 1 s = 8 Hz

freq salida = freq entrada / divisor -->
divisor = freq entrada / freq salida


2 ^ 3 = 2 ^ 15 / x --> x = 2 ^ 15 / 2 ^ 3 = 2 ^ 12 = 4096


Este problema trata sobre controlar un periférico capaz de emitir luz, la cual se utilizará para  codificar caracteres 
en Morse. 
Para ello dispondremos de un registro de E/S que usaremos para controlar si la luz está encendida o no.

Las palabras seran leídas usando una función que ya viene dada que invoca un teclado virtual para tal fin. 
El output de esa función se tendrá que usar en otra función implementada que nos devolverá un array de índices al array 
nbcode, el cual contiene los valores de bits (bitcodes) para codificar los caracteres en Morse, así como el número de 
bits que tiene ese bitcode.

Nuestro objetivo es implementar la rutina de la RSI del timer 0 para ir modificando el estado de la luz para codificar 
los carácteres en Morse. También tenemos que proveer el cálculo de la frecuencia de entrada y del divisor de frecuencia 
tal que se cumpla una cierta medida de tiempo (el carácter S tiene que durar 1 segundo).
