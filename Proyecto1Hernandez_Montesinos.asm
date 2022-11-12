.data 

mensaje1: .asciiz  "Hola porfavor ingrese primero el sistema de numero en el cual introducira el numero: \n" 
mensaje2: .asciiz  " Ahora Ingresa el tipo de sistema que desea convertir \n"
ingresar: .asciiz  "Ingrese el valor a convertir\n"

opciones: .asciiz  " Presiona 1 si es: Binacio En complemento2 \n Presiona 2 si es Decimal empaquetado \n Presione 3 si es en base 10 \n Presione 4 si es Octal \n Presione 5 si es Hexadecimal "
error: .asciiz "El numero que ingreso no es ninguna de la anteriores opciones se cerrara el programa \n"

.text


# Mensajes de entrada   

li $v0 4
la $a0 mensaje1
syscall

li $v0 4
la $a0 opciones
syscall

#Se eliga el caso
li $v0 5
syscall
move $t0 $v0 

#salto del caso dependiendo del valor
beq $t0,1,casobinarioempaquetado
beq $t0,2,casodecimalempaquetado
beq $t0,3,casobase10
beq $t0,4,casooctal
beq $t0,5,casohexadecimal


#si el numero introducido no corresponde con ningun caso se rompe el programa
li $v0 4
la $a0 error
syscall

b finCasos

#Realizando el baso binario empaquetado
casobinarioempaquetado:





#Realizando el caso decimal empaquetado
casodecimalempaquetado:







#Realizando el caso Base 10
casobase10:

li $v0 4
la $a0 ingresar
syscall

li $v0 5
syscall
move $t0 $v0 

li $v0 4
la $a0 mensaje2
syscall

li $v0 4
la $a0 opciones
syscall



#Realizando Caso Octal
casooctal:







#Realizando casoHexadecimal
casohexadecimal:





finCasos:

# Fin del Programa
li $v0 10
syscall