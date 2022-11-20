.macro mostrarCadena (%cadena)	
	li $v0 4
	la $a0 %cadena
	syscall	

.end_macro

.macro mostrarCadenaInversa (%cadena, %cadenaResultado, %fin)
	#li $t2 1
	subi $t2 %fin 1
	li $t4 0
	loopInvertir:
		bltz $t2 finLoopInvertir
		lb $t3 %cadena($t2)
		sb $t3 %cadenaResultado($t4)
				
		subi $t2 $t2 1
		addi $t4 $t4 1
		b loopInvertir
	finLoopInvertir:
		li $t3 0
		sb $t3 %cadenaResultado($t4)
		mostrarCadena(%cadenaResultado)
.end_macro

.macro leerCadena (%direccion)
	la $a0 %direccion
	li $a1 33
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


.macro mostrarSigno(%entero)
	bgez %entero esPositivo
	mostrarCadena(resta)
	b salirMacro	
	esPositivo:
		mostrarCadena(suma)
	salirMacro:
.end_macro

.macro mostrarSignoSuma (%entero)
	bgez %entero esPositivo
	b salirMacro	
	esPositivo:
		mostrarCadena(suma)
	salirMacro:
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
mensaje4:	.asciiz "El número convertido es: "

salto: 		.asciiz "\n"

entrada:	.space 33
	

espacio:	.asciiz " "
suma:		.asciiz "+"
resta:		.asciiz "-"

binResultado: 	.space 32

bpdPila: 	.space 7 

hexAux:		.space 36
hexResultado:	.space 36

.text

mostrarCadena(mensaje1)
leerEntero($t0) 		#$t0: guarda el número correspondiente al sistema de enumeración introducido


introducirValor: 
	mostrarCadena(mensaje2)
	leerCadena(entrada)
	salto
	mostrarCadena(mensaje3)
	leerEntero($t1)		#$t1: guarda el número correspondiente al sistema de enumeración a convertir
	b conversorToDecimal

conversorToDecimal:
	beq $t0 1 binarioToDecimal
	beq $t0 2 bpdToDecimal
	beq $t0 3 decimalToDecimal
	beq $t0 4 octalToDecimal
	beq $t0 5 hexadecToDecimal
	
binarioToDecimal:
	#Aquí va el código de binario a decimal

	li $t3 1 # multiplicacion
	li $t5 31 #apuntador 
	li $t4 2 #contador 
	li $t6 0 #resultado
	
	buclebad:
	beq $t5 1 finalbad # Bad es Binario a decimal 

	lb $t7 entrada ($t5)
	

	addi $t7 $t7 -48 # Se resta el 48 para verificar si es 0 o 1 
	
	bgtz $t7 sumabad
	
	
	mul $t3 $t4 $t3 # Se aumenta el elevado a 2 
	add $t5 $t5 -1 #Se cambia el apuntador 
	
	b buclebad
	
	sumabad:	
	
	add $t6 $t6 $t3 #Se aumenta el resultado 
	mul $t3 $t3 $t4 
	add $t5 $t5 -1
	b buclebad
	
	
	finalbad:
	
	lb $t7 entrada ($t5)
	
	addi $t7 $t7 -48
	
	bgtz $t7 final2bad # Se verifica si es negativo o positivo
	
	move $t9 $t6 #Si es positivo se mueve el resultado 
	
	b conversor	
	
	final2bad:
	
	sub $t6 $t6 $t3 #Si es negativo se resta el resultado 
	move $t9 $t6 # Se mueve el resultado 
	b conversor
	
	
bpdToDecimal:
	li $t9 0				#$t9: guarda el número entero sin signo.
	li $t2 0
	loop1:	
		beq $t2 28 finLoop1
		li $t8 0 			#$t8: guarda el número entero de un byte
		li $t3 8
		loop2:
			beqz $t3 finLoop2 
			lb $t4 entrada($t2)
			subi $t4 $t4 48
			
			mul $t4 $t4 $t3
			
			add $t8 $t8 $t4
			
						
			div $t3 $t3 2 
			
			
			addi $t2 $t2 1
			b loop2
			
		finLoop2:
		mul $t9 $t9 10	
		add $t9 $t9 $t8		
		b loop1
	finLoop1:
	salto
	signo:
		li $t8 0 			#$t8: guarda el número entero de un byte
		li $t3 8	
		loop3:
			beq $t2 32 finLoop3
			lb $t4 entrada($t2)
			subi $t4 $t4 48

			mul $t4 $t4 $t3
			
			add $t8 $t8 $t4
			
			div $t3 $t3 2								
			
			addi $t2 $t2 1
			b loop3
			
		finLoop3:
		
		beq $t8 13 negativo
		b conversor
		negativo:
			mul $t9 $t9 -1 
			b conversor

decimalToDecimal:
	li $t2 1
	li $t9 0
	loop5: 
	
		lb $t3 entrada($t2) 
	
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
		lb $t4 entrada($t2)
		beq $t4 0x2D negativo3
		b conversor
		negativo3:
			mul $t9 $t9 -1 
			b conversor
			
			
octalToDecimal:
	li $t9 0	#$t9: guarda el número entero sin signo.
	li $t3 0	#$t3: contador de caracteres
	li $t2 0
	loopAux2:
		lb $t4 entrada($t2)
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
		lb $t4 entrada($t2)	
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
		lb $t4 entrada($t2)
		beq $t4 0x2D negativo4
		b conversor
		negativo4:
			mul $t9 $t9 -1 
			b conversor
	
hexadecToDecimal: 
	li $t9 0			#$t9: guarda el número entero sin signo.
	li $t3 0			#$t3: contador de caracteres
	li $t2 0
	loopAux:
		lb $t4 entrada($t2)
		beq $t4 10 finLoopAux
		beq $t4 0 finLoopAux
		addi $t2 $t2 1
		addi $t3 $t3 1
		b loopAux
	
	finLoopAux:			
	subi $t3 $t3 2			# para que coincida con los exponentes
	li $t2 1
	
	loop4:
		bltz $t3 finLoop4
		lb $t4 entrada($t2)	
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
		lb $t4 entrada($t2)
		beq $t4 0x2D negativo2
		b conversor
		negativo2:
			mul $t9 $t9 -1 
			b conversor	
		

	

conversor:
	salto 			
	
	beq $t1 1 decimalToBin
	beq $t1 2 decimalToBpd
	beq $t1 3 decimalToDec
	beq $t1 4 decimalToOct
	beq $t1 5 decimalToHex

decimalToBin:
     
        move $t2 $t9     # $t2 guarda el numero

        li $t4 4        # Para ir imprimiendo en 4 digitos

        li $t0 32       # Palabra de 32 bits 
        la $t3 binResultado    #La respeusta se almacenara aqui
        
        mostrarCadena(mensaje4)
	
	loop:   rol $t2 $t2 1    # comenzar con el dígito más a la izquierda
       		and $t1 $t2 1    # enmascarar un dígito binario

        	div $t0 $t4
        	mfhi $t5
        	bnez $t5 skip
        
        	mostrarCadena(espacio)       

		skip:   mostrarEntero($t1) 
	
			# guardar el digito en string

        		add $t1 $t1 48   # ASCII '0' es 48
        		sb $t1,($t3)     # salvar como string
        		add $t3 $t3 1    # Se aumenta el apuntador en 1 
        		add $t0 $t0 -1   # reducir el contador en -1
        		bnez $t0 loop    # continuar si contador es menor a 0
        
        b chao
	
decimalToBpd:
	
	move $t2 $t9 			# $t2: guarda el número entero
	   	
  	
	
	bltz $t2 bpdNegativo 		# Si es negativo salta A CasoDTBnegativo
	
	bpdPositivo:
	
	li $t7 1
	b continuarBpd
	
	bpdNegativo:
	
	li $t7 0
	mul $t2 $t2 -1
	
	continuarBpd:
	
	li $t3 0
	li $s0 10 			#Se guarda la constante 10 para dividir
	
	comienzoconstruccion: 

		beqz $t2 finconstruccion
	
		div $t2 $s0 		#Dividimos el numero que esta guardado entre 10
	
		mflo $t2
		mfhi $t5
	
		#Guardamos el digito leido
		sb $t5 bpdPila($t3)
	
		#movemos $t3 un espacio
	
		addi $t3 $t3 1
	
		b comienzoconstruccion
	
	finconstruccion:
	
	addi $t3 $t3 -1
	
	li $t5 0
	
	conversionDaDe:
	
		bltz $t3 finconversionDade
	
		lb $t6 bpdPila($t3)
	
		#desplazamos los bits de $t1 4 posiciones hacia la izquieda
	
		sll $t5 $t5 4
	
		or $t5 $t6 $t5
	
		addi $t3 $t3 -1
	
		b conversionDaDe
		 
	finconversionDade:
	
	sll $t5 $t5 4
	
	beqz $t7 bpdNegativo2
	b bpdPositivo2
		
	bpdPositivo2:
	
	li $t8 0xC
	add $t5 $t5 $t8
	
	b imprimirBpd
	
	bpdNegativo2:
	
	li $t8 0xD
	add $t5 $t5 $t8
	
	imprimirBpd:
	mostrarCadena(mensaje4)
	li $t3 0
	loopBpd:
		beq $t3 32 finLoopBpd
		li $t4 0
		loopBpd2:
			beq $t4 4 finLoopBpd2
			andi $t6 $t5 0x80000000
			srl $t6 $t6 31
			mostrarEntero($t6)
			sll $t5 $t5 1
			addi $t3 $t3 1
			addi $t4 $t4 1
			b loopBpd2
		finLoopBpd2:
		mostrarCadena(espacio)
		
		b loopBpd
		
	finLoopBpd:
	
	b chao
	
decimalToDec:
	mostrarCadena(mensaje4)
	mostrarSignoSuma ($t9)
	mostrarEntero($t9)
	b chao
			
decimalToOct:
	
        move $t2,$t9     	# $t2: guarda el número entero
                   
        li $t3 0 		# $t3: octal
        li $t4 1 		# $t4: i
        li $s0 8
        
	loopOctal:
		beqz $t2 finLoopOctal
	
		div $t2 $s0
	
		mfhi $t5
		mflo $t2
	
		mul $t6 $t4 $t5
	
		add $t3 $t3 $t6 
		
		mul $t4 $t4 10
	
		b loopOctal
		
	finLoopOctal:
	
		mostrarCadena(mensaje4)
		mostrarSignoSuma ($t9)
		mostrarEntero ($t3)
		
		b chao
		
		
decimalToHex:
	move $t2 $t9    	# $t2: guarda el número entero
        
        abs $t2 $t2		#  hace positivo al número guardado en $t2
                
        li $t8 0 		# $t8: índice para hexAux (servirá también para conocer la longitud de esta)
        li $s0 16		
        
	loopHex:
		beqz $t2 finLoopHex
	
		div $t2 $s0
	
		mfhi $t5
		mflo $t2
		
		addi $t3 $t5 48		# Se le suma 48 para guardarlo en memoria en su equivalente en hexadecimal
		bge $t5 10 letra
		b continuar
		letra:
			addi $t3 $t3 7	# Se le suma 7 más para los casos de que el equivalente sea una letra en hexadecimal
		continuar:
			sb $t3 hexAux($t8)
		
			addi $t8 $t8 1	
	
			b loopHex
	finLoopHex:
		
		li $t3 0
		sb $t3 hexAux($t8)
			
		mostrarCadena(mensaje4)
		mostrarSigno($t9)
		mostrarCadenaInversa(hexAux, hexResultado, $t8)
		
		b chao	
		
chao:		
	salir
