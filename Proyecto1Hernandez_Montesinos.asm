.macro mostrarCadena (%cadena)	
	li $v0 4
	la $a0 %cadena
	syscall	

.end_macro

.macro leerCadena (%direccion)
	la $a0 %direccion
	li $a1 33
	li $v0 8
	syscall

.end_macro

.macro leerEntero (%registro)
	li $v0 5
	syscall
	move %registro $v0

.end_macro 
	
.macro salto
	li $v0 4
	la $a0 salto
	syscall
	
.end_macro
.macro salir
	li $v0 10
	syscall	
.end_macro 

.data
mensaje1:	.asciiz "Indique el sistema de numeración en el cual introducirá el valor: \n (1) Binario en Complemento a 2 \n (2) Decimal Empaquetado \n (3) Base 10 \n (4) Octal \n (5) Hexadecimal \n ==> "
mensaje2:	.asciiz "Ingrese el valor a convertir ==>  "
mensaje3:	.asciiz "Indique el sistema de numeración al cual desea convertir: \n (1) Binario en Complemento a 2 \n (2) Decimal Empaquetado \n (3) Base 10 \n (4) Octal \n (5) Hexadecimal \n ==> "	


salto: 		.asciiz "\n"

binarioEntrada:	.space 33
bpdEbtrada:	.space 33
decimalEntrada:	.space 9	
octalEntrada:	.space 9		
hexadecEntrada:	.space 9

.text

mostrarCadena(mensaje1)
leerEntero($t0) 	#$t0: guarda el número correspondiente al sistema de enumeración introducido

#Lógica donde se verá en donde guardar el valor (con ifs)

mostrarCadena(mensaje2)
li $t7 33
leerCadena(binarioEntrada) #(Si llegase el usuario a elegir el número 1)
salto

mostrarCadena(mensaje3)
leerEntero($t1)		#$t1: guarda el número correspondiente al sistema de enumeración a convertir

salir
