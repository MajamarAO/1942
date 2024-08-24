# 1942

### Descripción: El juego 1942 trata de un avión que se enfrenta a múltiples naves lanzando proyectiles y evitando ser golpeado. Dicho avión, el cual será controlado por el jugador, podrá moverse libremente en un entorno 2D en el que diversos enemigos irán apareciendo. Tras colisionar o recibir un disparo proveniente de alguno de estos se perderá una vida teniendo 3 como máximo. El juego contará con un único nivel.

### Enemigos: Existen varios tipos de enemigos los cuales varían de vida (cantidad de disparos necesarios para derribarlos), movimiento(velocidad y patrón), tamaño y la manera en la que disparan.
* #### Cazas Básicos: Pequeños aviones de combate que aparecen en formación y realizan ataques simples. Se derriban de un disparo.
* #### Bombarderos Medios: Aviones más grandes que lanzan bombas o disparan ráfagas más largas. Se derriban de un disparo.
* #### Bombarderos Pesados: Aviones aún más grandes y resistentes, a menudo con múltiples torretas. Se derriban de tres disparos.
* #### Aviones Kamikaze: Aviones que se lanzan directamente hacia el jugador para colisionar, es el único tipo de avión que no dispara. Se derriban de un disparo.
* #### Jefes Finales: Aviones grandes que aparecen al final de los niveles, con mayor resistencia y poder de fuego. Se derriban de diez disparos.

### Roll loop: Esta es una mecánica la cual le permite al jugador ser invulnerable por 1 segundo a costa de dejar de disparar. Cuenta con una animación propia y su uso estará limitado por un contador que indica cuantas veces se puede usar.


