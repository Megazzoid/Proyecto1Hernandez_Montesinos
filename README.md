# Proyecto 1: Organización del Computador


Desde la décima versión del sistema operativo Windows, se ha incluido dentro de la distribución ofrecida a los usuarios un programa de "calculadora" con funcionalidades aumentadas bastante interesantes. Una de ellas es el modo "programador" que permite al usuario, entre muchas cosas, colocar un número en una base numérica (por ejemplo, colocar un entero en base 10) y convertirlo a otra base numérica (por ejemplo, base 16 o hexadecimal). Para este primer proyecto, deberán construir en lenguaje de ensamblaje de MIPS 2000 un programa relativamente similar a este. A continuación se especifican los requisitos del proyecto:

Se debe desarrollar un programa que permita fácilmente realizar conversiones entre distintos sistemas de numeración. El usuario deberá indicar 3 datos: 
El sistema de numeración en el cual introducirá el valor a convertir. 
El valor como tal que desea convertir.
El sistema de numeración hacia el cual quiere convertir el valor introducido. 
Por ejemplo, el usuario podrá indicar que quiere convertir un número expresado en base 10, luego procederá a introducir dicho número (digamos que el número introducido es "+540"), y posteriormente podrá indicar al sistema de numeración al cual quiere convertir el número. Por ejemplo, si quiere convertirlo a binario en complemento a 2, el entero introducido pasaría a ser:
0000 0000 0000 0000 0000 0010 0001 1100

Las representaciones numéricas que deberán permitirse tanto para el valor introducido como para el resultado serán las siguientes.
Binario en Complemento a 2.
Decimal Empaquetado.
Base 10 (Cuando un número sea expresado en Base 10, será antecedido por el signo que le corresponda. "+" para números positivos, "-" para números negativos).
Octal (Cuando un número sea expresado en Octal, será antecedido por el signo que le corresponda. "+" para números positivos, "-" para números negativos)
Hexadecimal  (Cuando un número sea expresado en Hexadecimal, será antecedido por el signo que le corresponda. "+" para números positivos, "-" para números negativos)
Los números introducidos deberán ser leídos como cadenas. Pueden asumir que el usuario no colocará un número entero que esté por fuera de lo que los registros de 32 bits del procesador MIPS 2000 pueden almacenar.

La fecha de entrega para este proyecto será el domingo 20 de noviembre. Los proyectos serán sometidos a defensa con el preparador.

Finalmente, se les deja un ejemplo de una conversión para que lo tengan como referencia. Si el usuario pide convertir el siguiente número expresado en Base 10: +15

Si quisiera convertirlo a Binario en Complemento a 2: 0000 0000 0000 0000 0000 0000 0000 1111
Si quisiera convertirlo a decimal empaquetado: 0000 0000 0000 0000 0000 0001 0101 1100
Si quisiera convertirlo a Base 10: +15 (obviamente sería el mismo número que el usuario introdujo)
Si quisiera convertirlo a Octal: +17
Si quisiera convertirlo a Hexadecimal: +F
