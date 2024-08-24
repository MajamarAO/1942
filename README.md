## 1942

#### Descripción: El juego 1942 es un shooter vertical en el que el jugador controla a un avión que se enfrenta a múltiples naves lanzando proyectiles y evitando ser golpeado. Dicho avión podrá moverse libremente en un entorno 2D en el que diversos enemigos irán apareciendo. Tras colisionar o recibir un disparo proveniente de alguno de estos se perderá una vida teniendo 3 como máximo. El juego contará con un único nivel.

![1942 bombarder](https://github.com/user-attachments/assets/71bae849-a0b5-4481-a7dc-7896d3a2b0ef)

![1942 portaaviones](https://github.com/user-attachments/assets/f074f188-1e64-4af3-bc86-3da016e327e7)

#### Enemigos: Existen varios tipos de enemigos los cuales varían de vida (cantidad de disparos necesarios para derribarlos), movimiento(velocidad y patrón), tamaño y la manera en la que disparan.
* ##### Cazas Básicos: Pequeños aviones de combate que aparecen en formación y realizan ataques simples. Se derriban con un disparo.
* ##### Bombarderos Medios: Aviones más grandes que lanzan bombas o disparan ráfagas más largas. Se derriban con un disparo.
* ##### Bombarderos Pesados: Aviones aún más grandes y resistentes, a menudo con múltiples torretas. Se derriban con tres disparos.
* ##### Aviones Kamikaze: Aviones que se lanzan directamente hacia el jugador para colisionar, es el único tipo de avión que no dispara. Se derriban con un disparo.
* ##### Jefes Finales: Aviones grandes que aparecen al final de los niveles, con mayor resistencia y poder de fuego. Se derriban con diez disparos.

#### Roll loop: Esta es una mecánica la cual le permite al jugador ser invulnerable por 1 segundo a costa de dejar de disparar. Cuenta con una animación propia y su uso estará limitado por un contador que indica cuantas veces se puede usar.
