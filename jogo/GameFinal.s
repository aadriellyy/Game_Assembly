.include "MACROSv21.s"

.data 
SCORE: .string "SCORE"
MENU: .string "MENU"
VIDAS: .string "VIDAS"
.include "valk.data"
.include "map1.data"
.include "cinza.data"
.include "matriz.data"
.include "matriz2.s"
.include "new_chave.data"
.include "porta_tentativa.data"
.include "tela_principal.data"
.include "coracao.data"
.include "tiro.data"
.include "erase_tiro.data"
.include "map2.s"
.include "map3.s"
.include "matriz3.s"
.include "victory.s"

NUM: .word 64
NOTAS: 60,595,62,595,64,397,62,595,64,595,65,397,67,595,69,198,67,198,65,397,64,1191,60,198,61,198,60,198,69,2580,60,198,62,198,64,198,62,1588,59,1588,60,595,62,595,64,397,62,595,64,595,65,397,71,992,67,198,65,198,67,198,64,992,60,198,61,198,60,198,72,595,69,2183,60,198,64,198,62,595,59,2183,61,397,60,198,64,198,67,198,60,2580,61,198,62,198,65,198,61,2580,59,198,62,198,65,198,59,2580,57,198,60,198,64,198,60,198,59,198,62,198,65,198,57,198,55,1588,79,397,79,1191

#NUM_END: .word 33
#NOTAS_END: 65,120,67,120,69,120,71,120,69,120,71,120,72,240,67,120,64,360,65,120,67,120,69,120,71,120,69,120,71,120,72,360,64,360,65,120,67,120,69,120,71,120,69,120,71,120,72,240,67,120,64,240,79,120,77,240,76,120,74,240,76,120,72,360,84,360

PERSO_POS:	.half 8,8
OLD_PERSO_POS:	.half 8,8

PERSO_POS2:	.half 8,8
OLD_PERSO_POS2:	.half 8,8


PERSO_POS3: .half 8,8
OLD_PERSO_POS3: .half 8,8


flag:		.byte 0 # essa flag é onde vamos guardar a condicao de verdade "faca isso ate que tal coisa aconteca"
flag2:		.byte 0
flag3:		.byte 0

DIRECAO:	.byte 0
POSICAO_TIRO:	.half 0,0
ANTIGA_POSICAO_TIRO:	.half 0,0

.text 

	j inicio
	
SETUP:		la a0,map1	#o registrador a0 vai receber o endereÃ§o do map1
		la s1,matriz
		addi s1,s1,8
		li a1,0 			#a1 recebe 0
		li a2,0 			#a2 recebe 0
		li a3,0				#a3 recebe 0
		li a4, 320			# largura imagem
		li a5, 239			# altura da imagem
		call PRINT 			#chamamos a LABEL PRINT
		li a3,1 			#a3 recebe 1
		call PRINT 			#chamamos a LABEL PRINT
		
		#imprime o coracao
		la a0,coracao
		li a1,308
		li a2,100
		li a3,1
		li a4,8
		li a5,8
		call PRINT
		li a3, 0
		call PRINT
		li a3,1 			#a3 recebe 1
		call PRINT 			#chamamos a LABEL PRINT
		
		li a7,104        
		la a0,MENU       
		li a1,268
		li a2,5 
		li a3,0x0a0
		li a4,0
		ecall
		li a7,104        
		la a0,MENU     # Imprimir a label menu
		li a1,268
		li a2,5
		li a3,0x0a0
		li a4,1
		ecall
		
		
		
		li a7,104        
		la a0,SCORE       
		li a1,268
		li a2,50 
		li a3,0x070
		li a4,0
		ecall
		li a7,104        
		la a0,SCORE     # Imprimir a label score
		li a1,268
		li a2,50
		li a3,0x070
		li a4,1
		ecall
		
		li a7,104        
		la a0,VIDAS       
		li a1,268
		li a2, 100
		li a3,0x070
		li a4,0
		ecall
		li a7,104        
		la a0,VIDAS     # Imprimir a label score
		li a1,268
		li a2,100
		li a3,0x070
		li a4,1
		ecall
		
		li s6,3
		jal PRINT_VIDAS
		
		li s7,2000
		jal PRINT_SCORE
		#chamamos a label PRINT duas vezes pois queremos que o mapa apareca tanto se 
		#o frame for 1 quanto se o frame for 0
		

#gambiarra: 	la a0,black
#		li a1,275
#		li a2,110
#		li a3,1
#		li a4,8
#		li a5,8
#		call PRINT
#		li a3,1
#		call PRINT
#		jal PRINT_SCORE
CHAVE:
		la a0,new_chave
		li a1,64
		li a2,216
		li a3,0
		li a4,8
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
PORTA:
		la a0,porta_tentativa
		li a1,24
		li a2,200
		li a3,0
		li a4,8
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
		
	
		#desenhando o personagem:ss
GAME_LOOP:	
		call KEY2
		
		xori s0,s0,1 			#vai alternar entre 0 e 1, se o frame atual for 0 ele vai alternar e mostrar o 1	
								
		la t0,PERSO_POS			#t0 guarda a posicao do personagem

		la a0,valk
		lh a1,0(t0)
		lh a2,2(t0) 			#Ã© 2 pq estamos usando uma half word, se fosse word seria 4
		mv a3,s0
		li a4, 8
		li a5, 8
		call PRINT
		
		la t0,OLD_PERSO_POS		#t0 guarda a posicao antiga do personagem
	
		la a0,cinza
		lh a1,0(t0)
		lh a2,2(t0) 			#Ã© 2 pq estamos usando uma half word, se fosse word seria 4
		
		mv a3,s0
		xori a3,a3,1
		call PRINT
		
		mv zero,a0
		la a0,flag 			# vai ler a flag e colocar as informacoes no a0
		li t0,1				# t0 recebe 1
		lb t1, 0(a0)			# t1 recebe as informcoes do a0
		
		beq t1,t0,SETUP2		# se a flag for VERDADEIRA, ou seja, ele chegou na porta e esta com a chave, o código vai fechar
	
		li t0,0xFF200604
		sw s0,0(t0)
		
		j GAME_LOOP
	
KEY2:		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
  		
  		li t0, 'x'
		beq t2,t0, SETUP
		
  		li t0, 'l'
		beq t2,t0,TIRO
	
		li t0,'a' 			#carrega no registrador uma tecla aleatoria que a gente escolhe
		beq t2,t0,PER_ESQ		#faz uma comparacao entre 0 t0 e o t2 (t2 Ã© a tecla que o  usuario clicou)
	
		li t0,'d'
		beq t2,t0,PER_DIR
		
		li t0, 'w'
		beq t2,t0,PER_UP
		
		li t0, 's'
		beq t2,t0,PER_DOWN
		
		li t0, 'n'
		beq t2,t0,SETUP2
		
		
		
		
TIRO:
	#Atualiza posicao inicial do tiro
	la t0, PERSO_POS
	lh t1, 0(t0)
	lh t2, 2(t0)
	la t0, POSICAO_TIRO
	sh t1, 0(t0)
	sh t2, 2(t0)
	
	la t0, DIRECAO
	lb t5, 0(t0)
	li t1, 'w'
	beq t5, t1, TIRO_UP
	li t1, 's'
	beq t5, t1, TIRO_DOWN
	li t1,'d'
	beq t5, t1, TIRO_RIGHT
	li t1, 'a'
	beq t5, t1, TIRO_LEFT
	ret
		
	
	
		
		TIRO_UP:
		#ebreak
		
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, -4
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a2, 2(a0)
		#lh a1, 0(a0)
		#addi a1, a1, 
		#sh a1, 0(a0)
		
LOOP_PRINT_TIRO_UP: beq s3,t5,GAME_LOOP
		la a0,POSICAO_TIRO
		
		lh a2, 2(a0)
		addi a2, a2, -4
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a2, 2(a0)
		lh a1, 0(a0)
		
		la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		mv t1, t0
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li t0, 8
		blt a2, t0, GAME_LOOP
		
		
		j  LOOP_PRINT_TIRO_UP
		END_TIRO_UP: ret
		
		
		TIRO_DOWN:
		#ebreak
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, 20
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a2, 2(a0)
		#lh a1, 0(a0)
		#addi a1, a1, 8
		#sh a1, 0(a0)
		LOOP_PRINT_TIRO_DOWN: beq s3,t5,GAME_LOOP
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, 4
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a2, 2(a0)
		lh a1, 0(a0)
		la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		call PRINT

		li t0, 210
		bgt a2, t0, GAME_LOOP
		
		
		j LOOP_PRINT_TIRO_DOWN
		END_TIRO_DOWN: ret
		
		
		####
		TIRO_RIGHT:
		#ebreak
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		lh a2, 2(a0)
		addi a1, a1, 20
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		add t5,t5,a1
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a1, 0(a0)
		#addi a2, a2, 8
		#sh a2, 2(a0)
LOOP_PRINT_TIRO_RIGHT: beq s3,t5,GAME_LOOP
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		addi a1, a1, 4
		sh a1, 0(a0)
		lh a2, 2(a0)
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		add t5,t5,a1
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, ANTIGA_POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		
		
		call PRINT
		li t0, 294
		bge a1, t0, GAME_LOOP
		j LOOP_PRINT_TIRO_RIGHT
		END_TIRO_RIGHT: ret
		
		
		TIRO_LEFT:
		#ebreak
		la a0,POSICAO_TIRO
		lh a1, 0(a0)
		lh a2, 2(a0)
		addi a1, a1, -4
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		#lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a1, 0(a0)
		lh a2, 2(a0)
		#addi a2, a2, 8
		#sh a2, 2(a0)
LOOP_PRINT_TIRO_LEFT: beq s3,t5,GAME_LOOP
		la a0,POSICAO_TIRO
		
		lh a1, 0(a0)
		addi a1, a1, -4
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		#lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP
		
		sh a1, 0(a0)
		lh a2, 2(a0)
		la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, ANTIGA_POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		call PRINT
		li t0, 16
		blt a1, t0,GAME_LOOP
		
		
		j LOOP_PRINT_TIRO_LEFT
		END_TIRO_LEFT: ret
			

CHAVE_PEGA:	
		mv s11,zero				# movendo o zero pro s11
		sh t2,0(t1) 				# passando as informações do s2 para o t1, que no caso é a antiga porição do personagem
		sh t3, 2(t1)				# passando as informações do t3 para o proximo endereço de t1
		sh s4,0(t0)
		li s11,5
		
		j EFEITO	
		ret



	

PER_ESQ:	la t0, DIRECAO
		li t1, 'a'
		sb t1, 0(t0)
		
		la t0,PERSO_POS				#o personagem mover a esquerda Ã© igual a diminuir o valor de x
		la t1,OLD_PERSO_POS			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)

		
		lh s4,0(t0)
		addi s4,s4,-8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_ESQUERDA	
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)

		addi s7,s7,-1
		j PRINT_SCORE
		
		ret
		
PER_DIR:	la t0, DIRECAO
		li t1, 'd'
		sb t1, 0(t0)
		la t0,PERSO_POS				#o personagem mover a esquerda Ã© igual a diminuir o valor de x
		la t1,OLD_PERSO_POS			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		lh s4,0(t0)
		addi s4,s4,8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		#verificar se o valor na posicao é igual ao valor que representa a chave na matriz
		#se for a booleana de pegar a chave recebe 1
		#quando a booleana da chave estiver em 1 eu não printo ela 
		
		lb s3,-8(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DIREITA
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		addi s7,s7,-1
		j PRINT_SCORE
		
		ret
		
PER_UP:		la t0, DIRECAO
		li t1, 'w'
		sb t1, 0(t0)
		la t0, PERSO_POS
		la t1, OLD_PERSO_POS
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		
		lh s4,2(t0)
		addi s4,s4,-8
		li t5,320
		mul t5,s4,t5
		add s2,s1,t5
		add s2,s2,t2
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_UP
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		
		addi s7,s7,-1
		#li t6, 10
		#blt s7, t6, gambiarra
		j PRINT_SCORE
		
		ret
		
PER_DOWN:	la t0, DIRECAO				#recebe em t0 a DIRECAO
		li t1, 's'				#armazena em t1 a letra 's'
		sb t1, 0(t0)				#passa o valor de t1 para a label DIRECAO
		la t0, PERSO_POS			#guarda a posicao do persongaem em t0
		la t1, OLD_PERSO_POS			#guarda a antiga posicao do personagem em t1
		lh t2,0(t0)				#passa os valores da posicao do personagem para o t3
		lh t3, 2(t0)				#e para o t3
		
		
		lh s4,2(t0)				#passa para o s4 a posicao do personagem
		addi s4,s4,8				#adiciona o s4 +8, que é a posicao personagem, fazemos isso para mover esse sprite para baixo
		li t5,320				
		mul t5,s4,t5				#multiplica o t5 (linha) por s4 (guarda a próxima posicao do personagem) e guarda esse valor em t5
		add s2,s1,t5				#soma o valor de s1 (valor da matriz) ao t5 (atual posicao do personagem) e armazema tudo em s2
		add s2,s2,t2				#soma a posicao do personagem na matriz e no mapa (o s2) ao número de linhas e armazena novamente em s2
		lb s3,0(s2)				#passa o valor do s2 para o s3
		li t5,1
		beq s3,t5,FIM				#compara se a posicao onde o personagem será printado é uma parede, se for ele retorna ao inicio do loop
		
		lb s3,-8(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA
		
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DOWN
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
	
		addi s7,s7,-1
		j PRINT_SCORE
		
		ret

		

#	
#	a0 = endereco da imagem que queremos imprimir, no caso o MAP1
#	a1 = x - Ã© a linha da imagem
#	a2 = y - Ã©  a coluna da imagem
#	a3 = frame (0 ou 1)
#	a4 = tamanho a pintar (linha)
#	a5 = tamanho a pintar (coluna)
##
#	t0 = endereco do bitmap display
#	t1 = endereco da imagem
#	t2 = contador de linha
#	t3 = contado de coluna

#      s1 = endereço matriz





PRINT:		li t0, 0xFF0 			#t0 vai recebero emdereÃ§o do bitamap
		add t0,t0,a3 			#isso vai definir se o bitmap vai receber bit 1 ou bit 0
		slli t0,t0,20 			#movendo o to 20 bits para a esquerda para dar o tamanho exato do endereÃ§o do bitmap
		#endereco do bitmap esta feito
	
		add t0,t0,a1 			#aqui estamos adicionando o x (linha) ao t0(endereco da imagem)
	
		li t1,320 			#adicionando 320 ao t1 para poder multiplicar depois (qtd de pixels em uma linha)
		 	 			#lembrando que em t1 tbm esta o endereÃ§o da imagem que queremos imprimir
		mul t1,t1,a2 			#fazendo a multiplicaÃ§Ã£o linha * 320 - desse modo o t1 vai guardar a proxima linha
		add t0,t0,t1 			#adicionando t1 + t0, dessa forma nos vamos adicionar a linha mais a coluna, para saber onde esta 
			     			#localizado o proximo pixel que queremos printar 
	
		addi t1,a0,8 			#aqui nos adicionamos 8 ao a0 pois queremos que ele passe para o proximo endereÃ§o, depois movemos td para o t1
	
		mv t2,zero 			#zerando o t2
		mv t3,zero 			#zerando o t3
	
		#lw t4,0(a0) 			#em vez de t4 vamos usar o a4 passado como argumento
		#lw t5,4(a0)			#em vez de t5 vamos usar o a5   "      "       "
	
PRINT_LINHA:
		lw t6,0(t1)
		sw t6,0(t0)
	
		addi t0,t0,4
		addi t1,t1,4
	
		addi t3,t3,4
		blt t3,a4,PRINT_LINHA 		#enquanto t3 for menor que t4 a linha vai ser desenhada
	
		addi t0,t0,320
		sub t0,t0,a4
	
		mv t3,zero
		addi t2,t2,1
		bgt a5,t2,PRINT_LINHA 		#enquanto o contador da linha for menor ou igual a altura, ele vai pular para o PRINT_LINHA
	
		ret
		

	
VERIFICAR:     
	        la, a0,flag			# passando as informações da flag para o a0
		li t0,1				# passsando 1 para o t0
		sb t0, 0(a0)			# passando as informações do t0 para o a0, ou seja, a flag agora vale 1
		ret				# volta para o game loop
		
CONDICAO_DIREITA:
		li t5,5
		bne t5,s11,FIM
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		j VERIFICAR
		
CONDICAO_ESQUERDA:	
		li t5,5
		bne t5,s11,FIM
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		j VERIFICAR
		
CONDICAO_UP:		
		li t5,5 			# guardamos 5 no t5
		bne t5,s11,FIM			# se t5 for diferente de s11 (isso significa que ele não tem a chave), voltamos para o início do código (GAME LOOP)
		sh t2,0(t1)			# dessa parte do código até o verificar só estamos guardando a posição correta do personagem conforme a direção que ele vá
		sh t3, 2(t1)			# assim, o código consegue detectar se ele está tentando entrar na porta por todas as direcoes, pois temos uma condicao para cada
		sh s4,2(t0)
		j VERIFICAR
		
CONDICAO_DOWN:		
		li t5,5
		bne t5,s11,FIM
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		j VERIFICAR

inicio:		li t1,0xFF000000		# endereco inicial da Memoria VGA - Frame 0
		li t2,0xFF012C00		# endereco final 
		la s9,tela_principal		# endereï¿½o dos dados da tela na memoria
		addi s9,s9,8			# primeiro pixels depois das informaï¿½ï¿½es de nlin ncol
		
LOOP_MUS:   	beq t1,t2,MUS           	# Se for o ï¿½ltimo endereï¿½o entï¿½o sai do loop
		lw t3,0(s9)			# le um conjunto de 4 pixels : word
		sw t3,0(t1)			# escreve a word na memï¿½ria VGA
		addi t1,t1,4			# soma 4 ao endereï¿½o
		addi s9,s9,4
		j LOOP_MUS			# volta a verificar




MUS:		la s10,NUM			# define o endereï¿½o do nï¿½mero de notas
		lw s9,0(s10)			# le o numero de notas
		la s10,NOTAS			# define o endereï¿½o das notas
		li t0,0				# zera o contador de notas
		li a2,105			# define o instrumento
		li a3,127			# define o volume

LOOP2:		beq t0,s9, SETUP
		call KEY2			# contador chegou no final? entï¿½o  vï¿½ para FIM
		lw a0,0(s10)			# le o valor da nota
		lw a1,4(s10)			# le a duracao da nota
		li a7,31			# define a chamada de syscall
		ecall				# toca a nota
		mv a0,a1			# passa a duraï¿½ï¿½o da nota para a pausa
		li a7,32			# define a chamada de syscal 
		ecall				# realiza uma pausa de a0 ms
		addi s10,s10,8			# incrementa para o endereï¿½o da prï¿½xima nota
		addi t0,t0,1			# incrementa o contador de notas
		j LOOP2				# volta ao loop		


PRINT_VIDAS:	
		mv a0, s6
		li a7,101        	
		li a1,275		
		li a2,110		
		li a3,0x07		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, s6		   
		li a1,275		
		li a2,110		
		li a3,0x07		
		li a4,1			
		ecall
		ret
		
PRINT_SCORE:
		li t5,1230
		mv a0,t5
		li a7,101

		      	
		li a1,275		
		li a2,60		
		li a3,0x0		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, t5
		li a1,275	
		li a2,60		
		li a3,0x0		
		li a4,1			
		ecall
		
		
		mv a0, s7
		beqz s7,SETUP2
		li a7,101

		      	
		li a1,275		
		li a2,60		
		li a3,0x07		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, s7
		li a1,275	
		li a2,60		
		li a3,0x07		
		li a4,1			
		ecall
		ret
		
FIM:		
		ret				# retorna

#SAIDA:		
#		call SETUP2
		
		
##########FASE 2############

SETUP2:		
		la a0,map2	#o registrador a0 vai receber o endereÃ§o do map1
		la s1,matriz2
		addi s1,s1,8
		li a1,0 			#a1 recebe 0
		li a2,0 			#a2 recebe 0
		li a3,0				#a3 recebe 0
		li a4, 320			# largura imagem
		li a5, 240			# altura da imagem
		call PRINT			#chamamos a LABEL PRINT
		li a3,1 			#a3 recebe 1
		call PRINT			#chamamos a LABEL PRINT
		
		#imprime o coracao
		la a0,coracao
		li a1,308
		li a2,100
		li a3,0
		li a4,8
		li a5,8
		call PRINT
		li a3, 1
		call PRINT
		
		
		li a7,104        
		la a0,MENU       
		li a1,268
		li a2,5 
		li a3,0x0a0
		li a4,0
		ecall
		li a7,104        
		la a0,MENU     # Imprimir a label menu
		li a1,268
		li a2,5
		li a3,0x0a0
		li a4,1
		ecall
		
		
		
		li a7,104        
		la a0,SCORE       
		li a1,268
		li a2,50 
		li a3,0x070
		li a4,0
		ecall
		li a7,104        
		la a0,SCORE     # Imprimir a label score
		li a1,268
		li a2,50
		li a3,0x070
		li a4,1
		ecall
		
		li a7,104        
		la a0,VIDAS       
		li a1,268
		li a2, 100
		li a3,0x070
		li a4,0
		ecall
		li a7,104        
		la a0,VIDAS     # Imprimir a label score
		li a1,268
		li a2,100
		li a3,0x070
		li a4,1
		ecall
		
		li s6,3
		jal PRINT_VIDAS
		
		li s7,2000
		jal PRINT_SCORE
		#chamamos a label PRINT duas vezes pois queremos que o mapa apareca tanto se 
		#o frame for 1 quanto se o frame for 0
		
		
CHAVE2:
		la a0,new_chave
		li a1,8
		li a2,204
		li a3,0
		li a4,8 
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
PORTA2:
		la a0,porta_tentativa
		li a1,248
		li a2,120
		li a3,0
		li a4,8
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
		li s0,0
		
GAME_LOOP2:	
		call KEY3
		
		xori s0,s0,1 			#vai alternar entre 0 e 1, se o frame atual for 0 ele vai alternar e mostrar o 1	
								
		la t0,PERSO_POS2			#t0 guarda a posicao do personagem

		la a0,valk
		lh a1,0(t0)
		lh a2,2(t0) 			#Ã© 2 pq estamos usando uma half word, se fosse word seria 4
		mv a3,s0
		li a4, 8
		li a5, 8
		call PRINT
		
		la t0,OLD_PERSO_POS2		#t0 guarda a posicao antiga do personagem
	
		la a0,cinza
		lh a1,0(t0)
		lh a2,2(t0) 			#Ã© 2 pq estamos usando uma half word, se fosse word seria 4
		
		mv a3,s0
		xori a3,a3,1
		call PRINT
		
		mv zero,a0
		la a0,flag2			# vai ler a flag e colocar as informacoes no a0
		li t0,1				# t0 recebe 1
		lb t1, 0(a0)			# t1 recebe as informcoes do a0
		
		beq t1,t0,SETUP3		# se a flag for VERDADEIRA, ou seja, ele chegou na porta e esta com a chave, o código vai fechar
	
		li t0,0xFF200604
		sw s0,0(t0)
		
		j GAME_LOOP2
		
		
KEY3:		
		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM2   	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
  		
  		li t0, 'l'
		beq t2,t0,TIRO2
	
		li t0,'a' 			#carrega no registrador uma tecla aleatoria que a gente escolhe
		beq t2,t0,PER_ESQ2		#faz uma comparacao entre 0 t0 e o t2 (t2 Ã© a tecla que o  usuario clicou)
	
		li t0,'d'
		beq t2,t0,PER_DIR2
		
		li t0, 'w'
		beq t2,t0,PER_UP2
		
		li t0, 's'
		beq t2,t0,PER_DOWN2
		
		li t0, 'n'
		beq t2,t0,SETUP3
		
		
TIRO2:
	#Atualiza posicao inicial do tiro
	la t0, PERSO_POS2
	lh t1, 0(t0)
	lh t2, 2(t0)
	la t0, POSICAO_TIRO
	sh t1, 0(t0)
	sh t2, 2(t0)
	
	la t0, DIRECAO
	lb t5, 0(t0)
	li t1, 'w'
	beq t5, t1, TIRO_UP2
	li t1, 's'
	beq t5, t1, TIRO_DOWN2
	li t1,'d'
	beq t5, t1, TIRO_RIGHT2
	li t1, 'a'
	beq t5, t1, TIRO_LEFT2
	ret
		
	


TIRO_UP2:
#ebreak

la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, -4
		
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP2
		
		sh a2, 2(a0)
		#lh a1, 0(a0)
		#addi a1, a1, 
		#sh a1, 0(a0)

LOOP_PRINT_TIRO_UP2: beq s3,t5,GAME_LOOP2
la a0,POSICAO_TIRO

lh a2, 2(a0)
addi a2, a2, -4

li t5,320
mul t5,a2,t5
add t5,s1,t5
lh a1, 0(a0)
add t5,a1,t5
lb s3,0(t5)
li t5,1
beq s3,t5,GAME_LOOP2

sh a2, 2(a0)
lh a1, 0(a0)

		la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		mv t1, t0
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li t0, 8
		blt a2, t0, GAME_LOOP2


j  LOOP_PRINT_TIRO_UP2
END_TIRO_UP2: ret


TIRO_DOWN2:
#ebreak
	la a0,POSICAO_TIRO
	lh a2, 2(a0)
	addi a2, a2, 20
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP2
	sh a2, 2(a0)
#lh a1, 0(a0)
#addi a1, a1, 8
#sh a1, 0(a0)
LOOP_PRINT_TIRO_DOWN2: beq s3,t5,GAME_LOOP2
		la a0,POSICAO_TIRO
		lh a2, 2(a0)
		addi a2, a2, 4
		li t5,320
		mul t5,a2,t5
		add t5,s1,t5
		lh a1, 0(a0)
		add t5,a1,t5
		lb s3,0(t5)
		li t5,1
		beq s3,t5,GAME_LOOP2
		sh a2, 2(a0)
		lh a1, 0(a0)
		la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		call PRINT

		li t0, 210
		bgt a2, t0, GAME_LOOP2


j LOOP_PRINT_TIRO_DOWN2
END_TIRO_DOWN2: ret


####
TIRO_RIGHT2:
#ebreak
	la a0,POSICAO_TIRO
	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, 20
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	add t5,t5,a1
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP2
	sh a1, 0(a0)
#addi a2, a2, 8
#sh a2, 2(a0)
LOOP_PRINT_TIRO_RIGHT2:beq s3,t5,GAME_LOOP2
	la a0,POSICAO_TIRO
	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, 4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	add t5,t5,a1
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP2

	sh a1, 0(a0)
	lh a2, 2(a0)
	la a0, tiro
	xori a3, a3,1

li a4, 4
li a5, 4

call PRINT

li a0,50
li a7,132
ecall

la t0, ANTIGA_POSICAO_TIRO
sh a1,0(t0)
sh a2, 2(t0)

la a0, erase_tiro

li a4, 4
li a5, 4



call PRINT
li t0, 294
bge a1, t0, GAME_LOOP2
j LOOP_PRINT_TIRO_RIGHT2
END_TIRO_RIGHT2: ret


TIRO_LEFT2:
#ebreak
	la a0,POSICAO_TIRO
	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, -4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	#lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP2
sh a1, 0(a0)
lh a2, 2(a0)
#addi a2, a2, 8
#sh a2, 2(a0)
LOOP_PRINT_TIRO_LEFT2:beq s3,t5,GAME_LOOP2
la a0,POSICAO_TIRO

	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, -4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	#lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP2
sh a1, 0(a0)
lh a2, 2(a0)
la a0, tiro
xori a3, a3,1

li a4, 4
li a5, 4

call PRINT

li a0,50
li a7,132
ecall

la t0, ANTIGA_POSICAO_TIRO
sh a1,0(t0)
sh a2, 2(t0)

la a0, erase_tiro

li a4, 4
li a5, 4

call PRINT
li t0, 16
blt a1, t0,GAME_LOOP2


j LOOP_PRINT_TIRO_LEFT2
END_TIRO_LEFT2: ret
		
PER_ESQ2:	la t0, DIRECAO
		li t1, 'a'
		sb t1, 0(t0)
		
		la t0,PERSO_POS2			#o personagem mover a esquerda Ã© igual a diminuir o valor de x
		la t1,OLD_PERSO_POS2			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)

		
		lh s4,0(t0)
		addi s4,s4,-8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM2
		
		lb s3,8(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA2
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_ESQUERDA2	
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)

		addi s7,s7,-1
		j PRINT_SCORE2
		
		ret
		
PER_DIR2:	la t0, DIRECAO
		li t1, 'd'
		sb t1, 0(t0)
		la t0,PERSO_POS2		#o personagem mover a esquerda Ã© igual a diminuir o valor de x
		la t1,OLD_PERSO_POS2			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		lh s4,0(t0)
		addi s4,s4,8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM2
		
		#verificar se o valor na posicao é igual ao valor que representa a chave na matriz
		#se for a booleana de pegar a chave recebe 1
		#quando a booleana da chave estiver em 1 eu não printo ela 
		
		lb s3,-8(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA2
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DIREITA2
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		addi s7,s7,-1
		j PRINT_SCORE
		
		ret
		
PER_UP2:	la t0, DIRECAO
		li t1, 'w'
		sb t1, 0(t0)
		la t0, PERSO_POS2
		la t1, OLD_PERSO_POS2
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		
		lh s4,2(t0)
		addi s4,s4,-8
		li t5,320
		mul t5,s4,t5
		add s2,s1,t5
		add s2,s2,t2
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM2
		
		lb s3,-320(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA2
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_UP2
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		
		addi s7,s7,-1
		#li t6, 10
		#blt s7, t6, gambiarra
		j PRINT_SCORE2
		
		ret
		
PER_DOWN2:	la t0, DIRECAO				#recebe em t0 a DIRECAO
		li t1, 's'				#armazena em t1 a letra 's'
		sb t1, 0(t0)				#passa o valor de t1 para a label DIRECAO
		la t0, PERSO_POS2			#guarda a posicao do persongaem em t0
		la t1, OLD_PERSO_POS2		#guarda a antiga posicao do personagem em t1
		lh t2,0(t0)				#passa os valores da posicao do personagem para o t3
		lh t3, 2(t0)				#e para o t3
		
		
		lh s4,2(t0)				#passa para o s4 a posicao do personagem
		addi s4,s4,8				#adiciona o s4 +8, que é a posicao personagem, fazemos isso para mover esse sprite para baixo
		li t5,320				
		mul t5,s4,t5				#multiplica o t5 (linha) por s4 (guarda a próxima posicao do personagem) e guarda esse valor em t5
		add s2,s1,t5				#soma o valor de s1 (valor da matriz) ao t5 (atual posicao do personagem) e armazema tudo em s2
		add s2,s2,t2				#soma a posicao do personagem na matriz e no mapa (o s2) ao número de linhas e armazena novamente em s2
		lb s3,0(s2)				#passa o valor do s2 para o s3
		li t5,1
		beq s3,t5,FIM2				#compara se a posicao onde o personagem será printado é uma parede, se for ele retorna ao inicio do loop
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA2
		
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DOWN2
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
	
		addi s7,s7,-1
		j PRINT_SCORE2
		
		ret
		
		
PRINT_SCORE2:
		li t5,1230
		mv a0,t5
		li a7,101

		      	
		li a1,275		
		li a2,60		
		li a3,0x0		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, t5
		li a1,275	
		li a2,60		
		li a3,0x0		
		li a4,1			
		ecall
		
		
		mv a0, s7
		beqz s7,SETUP3
		li a7,101

		      	
		li a1,275		
		li a2,60		
		li a3,0x07		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, s7
		li a1,275	
		li a2,60		
		li a3,0x07		
		li a4,1			
		ecall
		ret
		
CHAVE_PEGA2:	
		mv s11,zero				# movendo o zero pro s11
		sh t2,0(t1) 				# passando as informações do s2 para o t1, que no caso é a antiga porição do personagem
		sh t3, 2(t1)				# passando as informações do t3 para o proximo endereço de t1
		sh s4,0(t0)
		li s11,5
		
		j EFEITO	
		ret
VERIFICAR2:     
	        la, a0,flag2			# passando as informações da flag para o a0
		li t0,1				# passsando 1 para o t0
		sb t0, 0(a0)			# passando as informações do t0 para o a0, ou seja, a flag agora vale 1
		ret				# volta para o game loop
		
CONDICAO_DIREITA2:
		li t5,5
		bne t5,s11,FIM2
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		j VERIFICAR2
		
CONDICAO_ESQUERDA2:	
		li t5,5
		bne t5,s11,FIM2
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		j VERIFICAR2
		
CONDICAO_UP2:		
		li t5,5 			# guardamos 5 no t5
		bne t5,s11,FIM2			# se t5 for diferente de s11 (isso significa que ele não tem a chave), voltamos para o início do código (GAME LOOP)
		sh t2,0(t1)			# dessa parte do código até o verificar só estamos guardando a posição correta do personagem conforme a direção que ele vá
		sh t3, 2(t1)			# assim, o código consegue detectar se ele está tentando entrar na porta por todas as direcoes, pois temos uma condicao para cada
		sh s4,2(t0)
		j VERIFICAR2
		
CONDICAO_DOWN2:		
		li t5,5
		bne t5,s11,FIM2
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		j VERIFICAR2		
		
FIM2:		
		ret				# retorna
		
SAIDA2:		
		mv a7,zero
		li a7,10
		ecall
		
###################################################
#                      FASE 3                     #
###################################################
SETUP3:		la a0,map3	#o registrador a0 vai receber o endereÃ§o do map1
		la s1,matriz3
		addi s1,s1,8
		li a1,0 			#a1 recebe 0
		li a2,0 			#a2 recebe 0
		li a3,0				#a3 recebe 0
		li a4, 320			# largura imagem
		li a5, 239			# altura da imagem
		call PRINT			#chamamos a LABEL PRINT
		li a3,1 			#a3 recebe 1
		call PRINT			#chamamos a LABEL PRINT
		
		#imprime o coracao
		la a0,coracao
		li a1,308
		li a2,100
		li a3,0
		li a4,8
		li a5,8
		call PRINT
		li a3, 1
		call PRINT
		
		
		li a7,104        
		la a0,MENU       
		li a1,268
		li a2,5 
		li a3,0x0a0
		li a4,0
		ecall
		li a7,104        
		la a0,MENU     # Imprimir a label menu
		li a1,268
		li a2,5
		li a3,0x0a0
		li a4,1
		ecall
		
		
		
		li a7,104        
		la a0,SCORE       
		li a1,268
		li a2,50 
		li a3,0x070
		li a4,0
		ecall
		li a7,104        
		la a0,SCORE     # Imprimir a label score
		li a1,268
		li a2,50
		li a3,0x070
		li a4,1
		ecall
		
		li a7,104        
		la a0,VIDAS       
		li a1,268
		li a2, 100
		li a3,0x070
		li a4,0
		ecall
		li a7,104        
		la a0,VIDAS     # Imprimir a label score
		li a1,268
		li a2,100
		li a3,0x070
		li a4,1
		ecall
		
		li s6,3
		jal PRINT_VIDAS
		
		li s7,2000
		jal PRINT_SCORE3
		#chamamos a label PRINT duas vezes pois queremos que o mapa apareca tanto se 
		#o frame for 1 quanto se o frame for 0
		
		
CHAVE3:
		la a0,new_chave
		li a1,176
		li a2,32
		li a3,0
		li a4,8 
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
PORTA3:
		la a0,porta_tentativa
		li a1,176
		li a2,208
		li a3,0
		li a4,8
		li a5,8
		call PRINT
		li a3,1
		call PRINT
		
		li s0,0
		
GAME_LOOP3:	
		call KEY4
		
		xori s0,s0,1 			#vai alternar entre 0 e 1, se o frame atual for 0 ele vai alternar e mostrar o 1	
								
		la t0,PERSO_POS3			#t0 guarda a posicao do personagem

		la a0,valk
		lh a1,0(t0)
		lh a2,2(t0) 			#Ã© 2 pq estamos usando uma half word, se fosse word seria 4
		mv a3,s0
		li a4, 8
		li a5, 8
		call PRINT
		
		la t0,OLD_PERSO_POS3		#t0 guarda a posicao antiga do personagem
	
		la a0,cinza
		lh a1,0(t0)
		lh a2,2(t0) 			#Ã© 2 pq estamos usando uma half word, se fosse word seria 4
		
		mv a3,s0
		xori a3,a3,1
		call PRINT
		
		mv zero,a0
		la a0,flag3			# vai ler a flag e colocar as informacoes no a0
		li t0,1				# t0 recebe 1
		lb t1, 0(a0)			# t1 recebe as informcoes do a0
		
		beq t1,t0,SAIDA3		# se a flag for VERDADEIRA, ou seja, ele chegou na porta e esta com a chave, o código vai fechar
	
		li t0,0xFF200604
		sw s0,0(t0)
		
		j GAME_LOOP3
		
		
KEY4:		
		li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
		lw t0,0(t1)			# Le bit de Controle Teclado
		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,FIM3  	   	# Se nao ha tecla pressionada entao vai para FIM
  		lw t2,4(t1)  			# le o valor da tecla tecla
  		
  		li t0, 'l'
		beq t2,t0,TIRO3
	
		li t0,'a' 			#carrega no registrador uma tecla aleatoria que a gente escolhe
		beq t2,t0,PER_ESQ3		#faz uma comparacao entre 0 t0 e o t2 (t2 Ã© a tecla que o  usuario clicou)
	
		li t0,'d'
		beq t2,t0,PER_DIR3
		
		li t0, 'w'
		beq t2,t0,PER_UP3
		
		li t0, 's'
		beq t2,t0,PER_DOWN3
		
		
TIRO3:
	#Atualiza posicao inicial do tiro
	la t0, PERSO_POS3
	lh t1, 0(t0)
	lh t2, 2(t0)
	la t0, POSICAO_TIRO
	sh t1, 0(t0)
	sh t2, 2(t0)
	
	la t0, DIRECAO
	lb t5, 0(t0)
	li t1, 'w'
	beq t5, t1, TIRO_UP3
	li t1, 's'
	beq t5, t1, TIRO_DOWN3
	li t1,'d'
	beq t5, t1, TIRO_RIGHT3
	li t1, 'a'
	beq t5, t1, TIRO_LEFT3
	ret
		
	


TIRO_UP3:
#ebreak

	la a0,POSICAO_TIRO
	lh a2, 2(a0)
	addi a2, a2, -4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
	sh a2, 2(a0)
	#lh a1, 0(a0)
	#addi a1, a1, 4
	#sh a1, 0(a0)
	
LOOP_PRINT_TIRO_UP3: beq s3,t5,GAME_LOOP3
	la a0,POSICAO_TIRO
	
	lh a2, 2(a0)
	addi a2, a2, -4
	
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
	
	sh a2, 2(a0)
	lh a1, 0(a0)
	
	la a0, tiro
		xori a3, a3,1
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li a0,50
		li a7,132
		ecall
		
		la t0, POSICAO_TIRO
		sh a1,0(t0)
		sh a2, 2(t0)
		
		mv t1, t0
		
		la a0, erase_tiro
		
		li a4, 4
		li a5, 4
		
		call PRINT
		
		li t0, 8
		blt a2, t0, GAME_LOOP3			#compara se a posicao onde o personagem será printado é uma parede, se for ele retorna ao inicio do loop
	
	
	j  LOOP_PRINT_TIRO_UP3
	END_TIRO_UP3: ret
	
	
	TIRO_DOWN3:
	#ebreak
	la a0,POSICAO_TIRO
	lh a2, 2(a0)
	addi a2, a2, 20
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
	sh a2, 2(a0)
	#lh a1, 0(a0)
	#addi a1, a1, 8
	#sh a1, 0(a0)
LOOP_PRINT_TIRO_DOWN3: beq s3,t5,GAME_LOOP3
	la a0,POSICAO_TIRO
	lh a2, 2(a0)
	addi a2, a2, 4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
	sh a2, 2(a0)
	lh a1, 0(a0)
	la a0, tiro
	xori a3, a3,1
	
	li a4, 4
	li a5, 4
	
	call PRINT
	
	li a0,50
	li a7,132
	ecall
	
	la t0, POSICAO_TIRO
	sh a1,0(t0)
	sh a2, 2(t0)
	
	la a0, erase_tiro
	
	li a4, 4
	li a5, 4
	
	call PRINT

	li t0, 210
	bgt a2, t0, GAME_LOOP3


j LOOP_PRINT_TIRO_DOWN3
END_TIRO_DOWN3: ret


####
TIRO_RIGHT3:
#ebreak
	la a0,POSICAO_TIRO
	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, 20
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	add t5,t5,a1
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
	sh a1, 0(a0)
#addi a2, a2, 8
#sh a2, 2(a0)
LOOP_PRINT_TIRO_RIGHT3:beq s3,t5,GAME_LOOP3
	la a0,POSICAO_TIRO
	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, 4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	add t5,t5,a1
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
	sh a1, 0(a0)
	lh a2, 2(a0)
	la a0, tiro
	xori a3, a3,1

li a4, 4
li a5, 4

call PRINT

li a0,50
li a7,132
ecall

la t0, ANTIGA_POSICAO_TIRO
sh a1,0(t0)
sh a2, 2(t0)

la a0, erase_tiro

li a4, 4
li a5, 4



call PRINT
li t0, 294
bge a1, t0, GAME_LOOP3
j LOOP_PRINT_TIRO_RIGHT3
END_TIRO_RIGHT3: ret


TIRO_LEFT3:
#ebreak
	la a0,POSICAO_TIRO
	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, -4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	#lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
sh a1, 0(a0)
lh a2, 2(a0)
#addi a2, a2, 8
#sh a2, 2(a0)
LOOP_PRINT_TIRO_LEFT3:beq s3,t5,GAME_LOOP3
la a0,POSICAO_TIRO

	lh a1, 0(a0)
	lh a2, 2(a0)
	addi a1, a1, -4
	li t5,320
	mul t5,a2,t5
	add t5,s1,t5
	#lh a1, 0(a0)
	add t5,a1,t5
	lb s3,0(t5)
	li t5,1
	beq s3,t5,GAME_LOOP3
sh a1, 0(a0)
lh a2, 2(a0)
la a0, tiro
xori a3, a3,1

li a4, 4
li a5, 4

call PRINT

li a0,50
li a7,132
ecall

la t0, ANTIGA_POSICAO_TIRO
sh a1,0(t0)
sh a2, 2(t0)

la a0, erase_tiro

li a4, 4
li a5, 4

call PRINT
li t0, 16
blt a1, t0,GAME_LOOP3


j LOOP_PRINT_TIRO_LEFT3
END_TIRO_LEFT3: ret
		
PER_ESQ3:	la t0, DIRECAO
		li t1, 'a'
		sb t1, 0(t0)
		
		la t0,PERSO_POS3			#o personagem mover a esquerda Ã© igual a diminuir o valor de x
		la t1,OLD_PERSO_POS3			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)

		
		lh s4,0(t0)
		addi s4,s4,-8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM3
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA3
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_ESQUERDA3	
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)

		addi s7,s7,-1
		j PRINT_SCORE3
		
		ret
		
PER_DIR3:	la t0, DIRECAO
		li t1, 'd'
		sb t1, 0(t0)
		la t0,PERSO_POS3		#o personagem mover a esquerda Ã© igual a diminuir o valor de x
		la t1,OLD_PERSO_POS3			#pegando a posicao atual do personagem,antes de altera-la, e guardando
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		lh s4,0(t0)
		addi s4,s4,8
		li t5,320
		mul s2,t3,t5
		add s2,s1,s2
		add s2,s2,s4
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM3
		
		#verificar se o valor na posicao é igual ao valor que representa a chave na matriz
		#se for a booleana de pegar a chave recebe 1
		#quando a booleana da chave estiver em 1 eu não printo ela 
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA3
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DIREITA3
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		addi s7,s7,-1
		j PRINT_SCORE
		
		ret
		
PER_UP3:	la t0, DIRECAO
		li t1, 'w'
		sb t1, 0(t0)
		la t0, PERSO_POS3
		la t1, OLD_PERSO_POS3
		lh t2,0(t0)				#na antiga posicao
		lh t3, 2(t0)
		
		
		lh s4,2(t0)
		addi s4,s4,-8
		li t5,320
		mul t5,s4,t5
		add s2,s1,t5
		add s2,s2,t2
		lb s3,0(s2)
		li t5,1
		beq s3,t5,FIM3
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA3
		
		mv t5,zero
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_UP3
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		
		addi s7,s7,-1
		#li t6, 10
		#blt s7, t6, gambiarra
		j PRINT_SCORE3
		
		ret
		
PER_DOWN3:	la t0, DIRECAO				#recebe em t0 a DIRECAO
		li t1, 's'				#armazena em t1 a letra 's'
		sb t1, 0(t0)				#passa o valor de t1 para a label DIRECAO
		la t0, PERSO_POS3			#guarda a posicao do persongaem em t0
		la t1, OLD_PERSO_POS3		#guarda a antiga posicao do personagem em t1
		lh t2,0(t0)				#passa os valores da posicao do personagem para o t3
		lh t3, 2(t0)				#e para o t3
		
		
		lh s4,2(t0)				#passa para o s4 a posicao do personagem
		addi s4,s4,8				#adiciona o s4 +8, que é a posicao personagem, fazemos isso para mover esse sprite para baixo
		li t5,320				
		mul t5,s4,t5				#multiplica o t5 (linha) por s4 (guarda a próxima posicao do personagem) e guarda esse valor em t5
		add s2,s1,t5				#soma o valor de s1 (valor da matriz) ao t5 (atual posicao do personagem) e armazema tudo em s2
		add s2,s2,t2				#soma a posicao do personagem na matriz e no mapa (o s2) ao número de linhas e armazena novamente em s2
		lb s3,0(s2)				#passa o valor do s2 para o s3
		li t5,1
		beq s3,t5,FIM3				#compara se a posicao onde o personagem será printado é uma parede, se for ele retorna ao inicio do loop
		
		lb s3,0(s2)
		li t5,3
		beq s3,t5,CHAVE_PEGA3
		
		lb s3,0(s2)
		li t5,4
		beq s3,t5,CONDICAO_DOWN3
		
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
	
		addi s7,s7,-1
		j PRINT_SCORE3
		
		ret
		
		
PRINT_SCORE3:
		li t5,1230
		mv a0,t5
		li a7,101

		      	
		li a1,275		
		li a2,60		
		li a3,0x0		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, t5
		li a1,275	
		li a2,60		
		li a3,0x0		
		li a4,1			
		ecall
		
		
		mv a0, s7
		beqz s7,SAIDA3
		li a7,101

		      	
		li a1,275		
		li a2,60		
		li a3,0x07		
		li a4,0		
		ecall

		li a7,101        	
		mv a0, s7
		li a1,275	
		li a2,60		
		li a3,0x07		
		li a4,1			
		ecall
		ret
		
CHAVE_PEGA3:	
		mv s11,zero				# movendo o zero pro s11
		sh t2,0(t1) 				# passando as informações do s2 para o t1, que no caso é a antiga porição do personagem
		sh t3, 2(t1)				# passando as informações do t3 para o proximo endereço de t1
		sh s4,0(t0)
		li s11,5
		
		j EFEITO	
		ret
VERIFICAR3:     
	        la, a0,flag3			# passando as informações da flag para o a0
		li t0,1				# passsando 1 para o t0
		sb t0, 0(a0)			# passando as informações do t0 para o a0, ou seja, a flag agora vale 1
		ret				# volta para o game loop
		
CONDICAO_DIREITA3:
		li t5,5
		bne t5,s11,FIM3
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		
		j VERIFICAR3
		
CONDICAO_ESQUERDA3:	
		li t5,5
		bne t5,s11,FIM3
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,0(t0)
		j VERIFICAR3
		
CONDICAO_UP3:		
		li t5,5 			# guardamos 5 no t5
		bne t5,s11,FIM3		# se t5 for diferente de s11 (isso significa que ele não tem a chave), voltamos para o início do código (GAME LOOP)
		sh t2,0(t1)			# dessa parte do código até o verificar só estamos guardando a posição correta do personagem conforme a direção que ele vá
		sh t3, 2(t1)			# assim, o código consegue detectar se ele está tentando entrar na porta por todas as direcoes, pois temos uma condicao para cada
		sh s4,2(t0)
		j VERIFICAR3
		
CONDICAO_DOWN3:		
		li t5,5
		bne t5,s11,FIM3
		sh t2,0(t1)
		sh t3, 2(t1)
		sh s4,2(t0)
		j VERIFICAR3		
		
FIM3:		
		ret				# retorna

SAIDA3:		la a0,victory	#o registrador a0 vai receber o endereÃ§o do map1
		li a1,0 			#a1 recebe 0
		li a2,0 			#a2 recebe 0
		li a3,0				#a3 recebe 0
		li a4, 320			# largura imagem
		li a5, 240			# altura da imagem
		call PRINT 			#chamamos a LABEL PRINT
		li a3,1 			#a3 recebe 1
		call PRINT 			#chamamos a LABEL PRINT

		mv a7,zero
		li a7,10
		ecall

EFEITO: li a0,100
	li a1,700
	li a2,5
	li a3,100
	li a7,33
	ecall
	
	ret



.include "SYSTEMv21.s"
