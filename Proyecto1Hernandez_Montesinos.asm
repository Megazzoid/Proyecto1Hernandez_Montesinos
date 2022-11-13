.macro mostrarCadena (%cadena)	
	li $v0 4
	la $a0 %cadena
	syscall	

.end_macro

.macro leerCadena (%direccion)
	la $a0 %direccion
	li $a1 36
	li $v0 8
	syscall

.end_macro

.macro mostrarEntero (%entero)
	li $v0 1
	move $a0 %entero
	syscall
.end_macro

.macro leerEntero (%registro)
	li $v0 5
	syscall
	move %registro $v0

.end_macro 
	
.macro convertirNegativo (%registro)
	mul %registro %registro -1
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

binarioEntrada:	.space 36
bpdEntrada:	.space 33
decimalEntrada:	.space 9	
octalEntrada:	.space 9		
hexadecEntrada:	.space 9

.text

mostrarCadena(mensaje1)
leerEntero($t0) 	#$t0: guarda el número correspondiente al sistema de enumeración introducido

#Lógica donde se verá en donde guardar el valor (con ifs)
mostrarCadena(mensaje2)
li $t7 33

beq $t0 2 bpdSeleccion

beq $t0 3 decimalSeleccion
beq $t0 4 octalSeleccion
beq $t0 5 hexadecSeleccion

bpdSeleccion:
	leerCadena(bpdEntrada) #(Si llegase el usuario a elegir el número 1)
	b asd	

decimalSeleccion:
	leerCadena(decimalEntrada)
	b asd	

octalSeleccion:
	leerCadena(octalEntrada)
	b asd

hexadecSeleccion:
	leerCadena(hexadecEntrada)
	b asd

asd: 
	salto
	mostrarCadena(mensaje3)
	leerEntero($t1)		#$t1: guarda el número correspondiente al sistema de enumeración a convertir
	b conversor

conversor:
	beq $t0 2 bpdToDecimal
	beq $t0 3 decimalToDecimal
	beq $t0 4 octalToDecimal
	beq $t0 5 hexadecToDecimal
	

bpdToDecimal:
	li $t9 0	#$t9: guarda el número entero sin signo.
	li $t2 0
	loop1:	
		beq $t2 28 finLoop1
		li $t8 0 #$t8: guarda el número entero de un byte
		li $t3 8
		loop2:
			beqz $t3 finLoop2 #t3= 8, t3= 4, t3=2, t3=1
			lb $t4 bpdEntrada($t2)
			subi $t4 $t4 48
			#mostrarEntero($t4)
			mul $t4 $t4 $t3
			
			add $t8 $t8 $t4
			
						
			div $t3 $t3 2 #t3 = 8/2 = 4, t3= 4/2 = 2, t3=2/2 = 1
			
			
			addi $t2 $t2 1
			b loop2
			
		finLoop2:
		mul $t9 $t9 10	
		add $t9 $t9 $t8		
		b loop1
	finLoop1:
	salto
	signo:
		li $t8 0 #$t8: guarda el número entero de un byte
		li $t3 8	
		loop3:
			beq $t2 32 finLoop3
			lb $t4 bpdEntrada($t2)
			subi $t4 $t4 48
			#mostrarEntero($t4)
			mul $t4 $t4 $t3
			
			add $t8 $t8 $t4
			
			div $t3 $t3 2								
			
			addi $t2 $t2 1
			b loop3
			
		finLoop3:
		
		beq $t8 13 negativo
		b mostrar
		negativo:
			mul $t9 $t9 -1 
			b mostrar

decimalToDecimal:
	li $t2 1
	li $t9 0
	loop5: 
	
		lb $t3 decimalEntrada($t2)  #t1 = 49, t2 = 49
	
		beqz $t3 finLoop5
		beq $t3 10 finLoop5
		
		subi $t4 $t3 48 
	
		mul $t9 $t9 10 
		
		add $t9 $t9 $t4
			
		addi $t2, $t2, 1 
	
		b loop5
	finLoop5:
	signo3:
		li $t2 0
		lb $t4 decimalEntrada($t2)
		beq $t4 0x2D negativo3
		b mostrar
		negativo3:
			mul $t9 $t9 -1 
			b mostrar
octalToDecimal:
	li $t9 0	#$t9: guarda el número entero sin signo.
	li $t3 0	#$t3: contador de caracteres
	li $t2 0
	loopAux2:
		lb $t4 octalEntrada($t2)
		beq $t4 10 finLoopAux2
		beq $t4 0 finLoopAux2
		addi $t2 $t2 1
		addi $t3 $t3 1
		b loopAux2
	
	finLoopAux2:			
	subi $t3 $t3 2		#para que coincida con los exponentes
	li $t2 1
	
	loop6:
		bltz $t3 finLoop6
		lb $t4 octalEntrada($t2)	
		subi $t4, $t4 48
		

		mul $t6 $t3 3
		li $t5 0x0001
		sllv $t5 $t5 $t6			
		mul $t4 $t4 $t5
		add $t9 $t9 $t4
			
		subi $t3 $t3 1
		addi $t2, $t2, 1
			
		b loop6
				
		
	finLoop6:
	
	signo4:
		li $t2 0
		lb $t4 octalEntrada($t2)
		beq $t4 0x2D negativo4
		b mostrar
		negativo4:
			mul $t9 $t9 -1 
			b mostrar
	
hexadecToDecimal: 
	li $t9 0	#$t9: guarda el número entero sin signo.
	li $t3 0	#$t3: contador de caracteres
	li $t2 0
	loopAux:
		lb $t4 hexadecEntrada($t2)
		beq $t4 10 finLoopAux
		beq $t4 0 finLoopAux
		addi $t2 $t2 1
		addi $t3 $t3 1
		b loopAux
	
	finLoopAux:			
	subi $t3 $t3 2		#para que coincida con los exponentes
	li $t2 1
	
	loop4:
		bltz $t3 finLoop4
		lb $t4 hexadecEntrada($t2)	
		bge $t4 65 restar55
		subi $t4, $t4 48
		b seguir
		restar55:
			subi $t4, $t4 55	
		seguir:

			mul $t6 $t3 4
			li $t5 0x0001
			sllv $t5 $t5 $t6
			
			mul $t4 $t4 $t5
			add $t9 $t9 $t4
			
			subi $t3 $t3 1
			addi $t2, $t2, 1
			
			b loop4
				
		
	finLoop4:
	
	signo2:
		li $t2 0
		lb $t4 hexadecEntrada($t2)
		beq $t4 0x2D negativo2
		b mostrar
		negativo2:
			mul $t9 $t9 -1 
			b mostrar	
		

	

mostrar:
	salto 			
	mostrarEntero($t9)
		
salir
