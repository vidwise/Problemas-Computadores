# Lector de códigos de barras

Este problema trata sobre controlar un periférico capaz de leer códigos de barras. Al pasar el dispositivo por encima 
del código, nuestro computador va a recibir interrupciones cada vez que haya un cambio de luz correspondiente a la 
transición de zona oscura a zora clara o al revés. La forma de detectar el valor correspondiente a cada barra va a ser 
usando un timer que nos indique cuanto tiempo ha pasado desde la última vez que recibimos una interrupción por cambio de 
luz. Esos tiempos se almacenarán en un vector que luego se relativizaran con respecto a un tiempo unitario, el cual es 
el tiempo mínimo que puede pasar entre dos interrupciones por cambio de luz. Este tiempo unitario deberá ser calculado a
partir de los calibrajes obtenidos en las tres primeras marcas de la lectura. Finalmente, tras obtener los tiempos 
relativos de cada una de las barras, traduciremos el código al valor representado y lo printearemos por pantalla.
