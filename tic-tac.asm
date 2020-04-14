;||===================================================================||
;||***************************JOGO DA VELHA***************************||
;||*******************************************************************||
;||**************************ASSEMBLY 32BITS**************************||
;||===================================================================||

;$ nasm -f elf tic-tac.asm
;$ gcc -m32 -o tic-tac tic-tac.o
;$ ./tic-tac

section .data
sai_msg_usuario			db		'VOCE GANHOU!!!',0Ah,0Ah,00h
sai_msg_cpu				db		'VOCE PERDEU!!!',0Ah,0Ah,00h
sai_msg_velha			db		'JOGO FICOU EMPATADO!!!',0Ah,0Ah,00h
digite_ler_posicao		db		'Digite a posicao que quer inserir o [X]  :Lembrando que e de 0 a 8',0Ah,00h
ler_c						db		'%c',00h
sai_c						db		'%c',0Ah,00h
ler_int						db		'%u',00h
sai_matriz					db		0Ah,'| %c | %c | %c| ',0Ah,'| %c | %c | %c| ',0Ah,'| %c | %c | %c|',0Ah,00h

section .bss
vetor		resb	9			;vetor representa a matriz do jogo da velha [3][3]
var_ler		resb	1
section .text
	extern printf,scanf
	global main
main:
		mov byte[vetor], '0'
		mov byte[vetor+1] ,'1'
		mov byte[vetor+2], '2'
		mov byte[vetor+3], '3'
		mov byte[vetor+4], '4'
		mov byte[vetor+5], '5'
		mov byte[vetor+6], '6'
		mov byte[vetor+7], '7'
		mov byte[vetor+8], '8'
		push vetor
		call function_imprimir_matriz
		push vetor
		call function_inserir_elemento_usuario
		call function_ganhou
		push vetor
		call function_imprimir_matriz
		call function_jogar_cpu
		push vetor
		call function_imprimir_matriz
		call function_ganhou
		push vetor
		call function_inserir_elemento_usuario
		call function_ganhou
		push vetor
		call function_imprimir_matriz
		call function_jogar_cpu
		push vetor
		call function_imprimir_matriz
		call function_ganhou
		push vetor
		call function_inserir_elemento_usuario
		call function_ganhou
		push vetor
		call function_imprimir_matriz
		call function_jogar_cpu
		push vetor
		call function_imprimir_matriz
		call function_ganhou
		push vetor
		call function_inserir_elemento_usuario
		call function_ganhou
		push vetor
		call function_imprimir_matriz
		call function_jogar_cpu
		push vetor
		call function_imprimir_matriz
		call function_ganhou
		push vetor
		call function_inserir_elemento_usuario
		call function_ganhou
		push vetor
		call function_imprimir_matriz
		push sai_msg_velha					;se chegou aqui porque deu velha
		call printf
		add esp,4
		jmp fim
;========================================INCIO DA FUNCAO QUE VERIFICA TODAS POSSIBILIDADES DE GANHAR======================================================
function_ganhou:							;Essa funcao serve para chamar as funcoes verificar_diagonal, verificar_linha e verifica_coluna (testando todas possibilidades)
		mov eax,0							;eax=0   
		push eax
		call function_verifica_linha		;verifica se tem 3 X ou 3 O seguidos na linha 0
		mov eax,1							;eax=1
		push eax
		call function_verifica_linha		;verifica se tem 3 X ou 3 O seguidos na linha 1
		mov eax,2							;eax=2
		push eax
		call function_verifica_linha		;verifica se tem 3 X ou 3 O seguidos na linha 2
		mov eax,0							;eax=0
		push eax	
		call function_verifica_coluna		;verifica se tem 3 X ou 3 O seguidos na coluna 0
		mov eax,1							;eax=1
		push eax	
		call function_verifica_coluna		;verifica se tem 3 X ou 3 O seguidos na coluna 1
		mov eax,2							;eax=2
		push eax
		call function_verifica_coluna		;verifica se tem 3 X ou 3 O seguidos na coluna 2
		mov eax,0							;eax=0
		push eax
		call function_verifica_diagonal	;verifica se tem 3X ou 3 O seguidos na diagonal principal([0],[4],[8])
		mov eax,2							;eax=2
		push eax
		call function_verifica_diagonal	;verifica se tem 3 X ou 3 O seguidos na diagonal secundaria([2],[4],[6]
fim_function_ganhou:	
	ret										;retorna para funcao que chamou
;==============================================FIM DA FUNCAO QUE VERIFICA TODAS AS POSSIBILIDADES DE GANHAR===============================================
;==============================================INICIO DA FUNCAO QUE FAZ A MAQUINA JOGAR===================================================================
function_jogar_cpu:		;=====INICIO========Avalia esse caso primeiro(CASO TENHA POSSIBILIDADE DE GANHAR ENTAO GANHE)===========================================
		mov eax,0							;eax=0
		push eax
		call function_verifica_linha		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,0
		cmp ecx,4							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_linha
		mov eax,1							;eax=0
		push eax
		call function_verifica_linha		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,1
		cmp ecx,4							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_linha
		mov eax,2							;eax=0
		push eax
		call function_verifica_linha		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,2
		cmp ecx,4							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_linha
		mov eax,0							;eax=0
		push eax
		call function_verifica_coluna		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,0
		cmp ecx,4							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_coluna
		mov eax,1							;eax=0
		push eax
		call function_verifica_coluna		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,1
		cmp ecx,4							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_coluna
		mov eax,2							;eax=0
		push eax
		call function_verifica_coluna		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,2
		cmp ecx,4							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_coluna
		mov eax,0
		push eax
		call function_verifica_diagonal
		mov eax,0
		cmp ecx,4
		jz function_jogar_cpu_diagonal
		mov eax,2
		push eax
		call function_verifica_diagonal
		mov eax,2
		cmp ecx,4
		jz function_jogar_cpu_diagonal
;====================================FIM========Avalia esse caso primeiro(CASO TENHA POSSIBILIDADE DE GANHAR ENTAO GANHE)=====================================
;====================================INICIO======Avalia esse caso (CASO TENHA A POSSIBILIDADE DE IMPEDIR DO USUARIO GANHAR ENTAO BLOQUEIA)=====================
		mov eax,0							;eax=0
		push eax
		call function_verifica_linha		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,0
		cmp ecx,20							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_linha
		mov eax,2							;eax=0
		push eax
		call function_verifica_linha		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,2
		cmp ecx,20							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_linha
		mov eax,0							;eax=0
		push eax
		call function_verifica_coluna		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,0
		cmp ecx,20							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_coluna
		mov eax,1							;eax=0
		push eax
		call function_verifica_coluna		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,1
		cmp ecx,20						;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_coluna
		mov eax,2							;eax=0
		push eax
		call function_verifica_coluna		;retorna em ecx o valor da soma SE tiver possibilidade ganhar ebx=4  se tiver possibilidade do usuario ganhar ecx=20
		mov eax,2
		cmp ecx,20							;se for verdadeiro entao tenho possibilidade de ganhar
		jz function_jogar_cpu_coluna
		mov eax,0
		push eax
		call function_verifica_diagonal
		mov eax,0
		cmp ecx,20
		jz function_jogar_cpu_diagonal
		mov eax,2
		push eax
		call function_verifica_diagonal
		mov eax,2
		cmp ecx,20
		jz function_jogar_cpu_diagonal
;====================================FIM======Avalia esse caso (CASO TENHA A POSSIBILIDADE DE IMPEDIR DO USUARIO GANHAR ENTAO BLOQUEIA)=====================
;=====================================INICIO====Se chegou aqui porque nao tem como nem ganhar e nem bloquear entao joga aleatorio=================================
;==============PRIMEIRO TENTA JOGAR NOS CANTOS([0],[2],[6],[8]), DEPOIS NO MEIO([4]) E POR ULTIMO NA PONTA([1],[3],[5],[7]============================================================	
		mov eax,0
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,2
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,6
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,8
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,4
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,1
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,3
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,5
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		mov eax,7
		push eax
		call function_jogar_na_posicao
		cmp ebx,1
		jz function_jogar_cpu_posicao
		jmp fim 								;se chegou aqui porque nao tem mais lugar para jogar entao encerra programa
function_jogar_cpu_posicao:
		jmp fim_function_jogar_cpu
function_jogar_cpu_diagonal:
		push eax
		call function_jogar_na_diagonal
		jmp fim_function_jogar_cpu
function_jogar_cpu_coluna:
		push eax
		call function_jogar_na_coluna
		jmp fim_function_jogar_cpu
function_jogar_cpu_linha:
		push eax
		call function_jogar_na_linha
		jmp fim_function_jogar_cpu
fim_function_jogar_cpu:
		ret
;=================================================FIM DA FUNCAO QUE FAZ A MAQUINA JOGAR=====================================================================
;=================================================INICIO DA FUNCAO QUE FAZ JOGAR NO CANTO=================================================================
function_jogar_na_posicao:
enter 0,0
	mov ebx,0			
	mov eax,dword[ebp+8]
	mov esi,vetor
	add esi,eax
	cmp byte[esi],'X'
	jz fim_jogar_no_canto
	cmp byte[esi],'O'
	jz fim_jogar_no_canto
	mov byte[esi],'O'
	mov ebx,1
fim_jogar_no_canto:
leave
	ret 4
;==============================================INICIO DA FUNCAO QUE JOGA NA DIAGONAL PEDIDA==============================================================
function_jogar_na_diagonal:			;RETORNA EM EBX SE INSERIU EBX=1 VERDADEIRO, EBX=0 FALSO(NAO INSERIU)
enter 0,0
	mov edx,0
	mov eax,dword[ebp+8]
	mov esi,vetor
	add esi,eax
	mov ebx,4
	sub ebx,eax							;para saber quanto que vai incrementar o esi
	mov eax,ebx							;eax=ebx
	cmp byte[esi],'X'
	jz next_function_jogar_na_diagonal
	cmp byte[esi],'O'
	jz next_function_jogar_na_diagonal
	mov byte[esi],'O'
	mov edx,1
	jmp fim_function_jogar_na_diagonal
next_function_jogar_na_diagonal:
	add esi,eax
	cmp byte[esi],'X'
	jz next_next_function_jogar_na_diagonal
	cmp byte[esi],'O'
	jz next_next_function_jogar_na_diagonal
	mov byte[esi],'O'
	mov edx,1
	jmp fim_function_jogar_na_diagonal
next_next_function_jogar_na_diagonal:
	add esi,eax
	cmp byte[esi],'X'
	jz fim_function_jogar_na_diagonal
	cmp byte[esi],'O'
	jz fim_function_jogar_na_diagonal
	mov byte[esi],'O'
	mov edx,1
fim_function_jogar_na_diagonal:
leave
	ret 4
;==============================================FIM DA FUNCAO QUE JOGA NA DIAGONAL PEDIDA=================================================================
;==============================================INICIO DA FUNCAO QUE JOGA NA COLUNA PEDIDA=================================================================
function_jogar_na_coluna:						;RETORNA EM EBX SE INSERIU EBX=1 VERDADEIRO, EBX=0 FALSO(NAO INSERIU)
enter 0,0
	mov edx,0
	mov eax, dword[ebp+8]
	mov esi,vetor
	add esi,eax
	cmp byte[esi],'X'
	jz next_jogar_na_coluna
	cmp byte[esi],'O'
	jz next_jogar_na_coluna
	mov byte[esi],'O'
	mov edx,1
	jmp fim_function_jogar_na_coluna
next_jogar_na_coluna:
	add esi,3
	cmp byte[esi],'X'
	jz next_next_jogar_na_coluna
	cmp byte[esi],'O'
	jz next_next_jogar_na_coluna
	mov byte[esi],'O'
	mov edx,1
	jmp fim_function_jogar_na_coluna
next_next_jogar_na_coluna:
	add esi,3
	cmp byte[esi],'X'
	jz fim_function_jogar_na_coluna
	cmp byte[esi],'O'
	jz fim_function_jogar_na_coluna
	mov byte[esi],'O'
	mov edx,1
fim_function_jogar_na_coluna:
leave
	ret 4
;==============================================FIM DA FUNCAO QUE JOGA NA COLUNA PEDIDA===================================================================
;=============================================INICIO DA FUNCA QUE JOGA NA LINHA PEDIDA==========================================================================
function_jogar_na_linha:					;essa funcao recebe parametro por pilha em qual linha deve jogar
enter 0,0									;RETORNA EM EBX SE INSERIU EBX=1 VERDADEIRO, EBX=0 FALSO(NAO INSERIU)
	mov eax,dword[ebp+8]				;e a linha em que deve jogar
	mov esi,vetor	
	mov edx,3
	mul edx								;eax=eax*3
	add esi,eax
	cmp byte[esi],'X'
	jz next_function_jogar_na_linha
	cmp byte[esi],'O'
	jz next_function_jogar_na_linha
	mov byte[esi],'O'						;SE CHEGOU AQUI PORQUE NA POSICAO APONTADO POR ESI NAO TEM NEM 'X' NEM 'O' ENTAO A POSICAO ESTA VAZIA E PODE SER JOGADA
	mov edx,1
	jmp fim_function_jogar_na_linha
next_function_jogar_na_linha:			;SE CHEGOU AQUI PORQUE A POSICAO [ESI] ESTA OCUPADA
	add esi,1
	cmp byte[esi],'X'
	jz next_next_function_jogar_na_linha
	cmp byte[esi],'O'
	jz next_next_function_jogar_na_linha
	mov byte[esi],'O'
	mov edx,1
	jmp fim_function_jogar_na_linha
next_next_function_jogar_na_linha:		
	add esi,1
	cmp byte[esi],'X'
	jz fim_function_jogar_na_linha
	cmp byte[esi],'O'
	jz fim_function_jogar_na_linha
	mov byte[esi],'O'
	mov edx,1
fim_function_jogar_na_linha:
leave	
	ret 4
;=====================================================FIM DA FUNCAO QUE JOGA NA LINHA PEDIDA==============================================================
;========================================INICIO DA FUNCAO QUE VERIFICA SE ALGUMA DIAGONAL TEVE GANHADOR==================================================
function_verifica_diagonal:				;E  passado por parametro(eax) qual a diagonal SE EAX=0(entao e a diagonal principal ) SE EAX=2(entao e a diagonal secundaria)
enter 0,0
	xor ecx,ecx							;zera o registrador ecx
	mov eax,dword[ebp+8]				;eax=0(diagonal principal) ou eax=2(diagonal secundaria)
	mov esi,vetor
	add esi,eax
	mov ebx,4
	sub ebx,eax							;ebx serve para saber quanto vai incrementar o esi				
	mov eax,ebx							;eax=ebx	
	push esi
	call function_jogo_constante		;funcao jogo_constante retorna em ebx um valor e ele me interessa por isso passei o valor de ebx para eax acima
	add ecx,ebx				
	add esi,eax
	push esi
	call function_jogo_constante
	add ecx,ebx
	add esi,eax
	push esi
	call function_jogo_constante
	add ecx,ebx
	cmp ecx,30							;se for verdadeiro O USUARIO GANHOU NESSA DIAGONAL 
	jnz function_verifica_diagonal_cpu
	push sai_msg_usuario				;SE CHEGOU AQUI PORQUE USUARIO GANHOU
	call printf
	add esp,4
	jmp fim
function_verifica_diagonal_cpu:
	cmp ecx,6								;SE FOR VERDADEIRO O USUARIO PERDEU
	jnz fim_function_verifica_diagonal
	push sai_msg_cpu
	call printf
	add esp,4
	jmp fim
fim_function_verifica_diagonal:			;SE CHEGOU AQUI PORQUE NINGUEM GANHOU NA DIAGONAL
leave
	ret 4
;========================================FIM DA FUNCAO QUE VERIFICA SE ALGUMA DIAGONAL TEVE GANHADOR====================================================
;========================================INICIO DA FUNCAO QUE VERIFICA SE ALGUMA COLUNA TEVE GANHADOR====================================================
function_verifica_coluna:				;Funcao que verifica se alguma coluna ganhou tem como parametro o registrador eax						
enter 0,0
	xor ecx,ecx
	mov eax, dword[ebp+8]	
	mov esi,vetor
	add esi,eax
	push esi							
	call function_jogo_constante	;retorna em ebx=10 se [esi]='X' , ebx=2 se [esi]='O' ou ebx=0 se [esi] for diferente de um dos dois
	add ecx,ebx
	add esi,3
	push esi						
	call function_jogo_constante	;retorna em ebx=10 se [esi]='X' , ebx=2 se [esi]='O' ou ebx=0 se [esi] for diferente de um dos dois
	add ecx,ebx
	add esi,3
	push esi						
	call function_jogo_constante	;retorna em ebx=10 se [esi]='X' , ebx=2 se [esi]='O' ou ebx=0 se [esi] for diferente de um dos dois
	add ecx,ebx
	cmp ecx,30
		jnz function_verifica_coluna_cpu
	push sai_msg_usuario			;SE CHEGOU AQUI PORQUE USUARIO GANHOU
	call printf
	add esp,4
	jmp fim	
function_verifica_coluna_cpu:
	cmp ecx,6							;SE FOR VERDADEIRO ENTAO COMPUTADOR GANHOU	
	jnz fim_function_verifica_coluna
	push sai_msg_cpu
	call printf
	add esp,4
	jmp fim
fim_function_verifica_coluna:
leave 
	ret 4
;-============================================FIM DA FUNCAO QUE VERIFICA SE ALGUMA COLUNA GANHOU=========================================================
;============================================INICIO DA FUNCAO QUE PEGA UMA CONSTANTE E ATRIBUI A EBX INT====================================================
function_jogo_constante:					;tem como parametro por pilha a posicao do vetor
enter 0,0
	mov esi,dword[ebp+8]
	mov ebx,0
	cmp byte[esi],'X'
	jnz function_jogo_constante_cpu
	mov ebx,10
	jmp fim_function_jogo_constante
function_jogo_constante_cpu:
	cmp byte[esi],'O'
	jnz fim_function_jogo_constante
	mov ebx,2
fim_function_jogo_constante:
leave
	ret 4
;==============================================FIM DA FUNCAO QUE PEGA UMA CONSTANTE E ATRIBUI A EBX INT=====================================================
;=============================================INICIO DA FUNCAO QUE VERIFICA SE ALGUMA LINHA GANHOU========================================================
function_verifica_linha:				;Funcao que verifica se alguma linha ganhou	tem como parametro por pilha qual linha que quer verificar
enter 0,0
	xor ecx,ecx	
	mov eax,dword[ebp+8]
	mov esi,vetor
	mov edx,3							;E a quantidade de colunas edx=3
	mul edx							;eax=eax*edx
	add esi,eax						;esi=esi+eax   =   vetor+linha*3
	push esi							
	call function_jogo_constante	;retorna em ebx=10 se [esi]='X' , ebx=2 se [esi]='O' ou ebx=0 se [esi] for diferente de um dos dois
	add ecx,ebx
	add esi,1
	push esi						
	call function_jogo_constante	;retorna em ebx=10 se [esi]='X' , ebx=2 se [esi]='O' ou ebx=0 se [esi] for diferente de um dos dois
	add ecx,ebx
	add esi,1
	push esi						
	call function_jogo_constante	;retorna em ebx=10 se [esi]='X' , ebx=2 se [esi]='O' ou ebx=0 se [esi] for diferente de um dos dois
	add ecx,ebx
	cmp ecx,30						;SE FOR VERDADEIIRO ENTAO USUARIO GANHOU
		jnz function_verifica_linha_cpu
	push sai_msg_usuario			;SE CHEGOU AQUI PORQUE USUARIO GANHOU
	call printf
	add esp,4
	jmp fim				
function_verifica_linha_cpu:
	cmp ecx,6							;SE FOR VERDADEIRO ENTAO COMPUTADOR GANHOU	
	jnz fim_function_verifica_linha
	push sai_msg_cpu
	call printf
	add esp,4
	jmp fim
fim_function_verifica_linha:
	leave
	ret 4
;=================================================FIM DA FUNCAO QUE VERIFICA SE ALGUMA LINHA TEVE GANHADOR===============================================
;=================================================INICIO DA FUNCAO INSERIR ELEMENTO USUARIO================================================================
function_inserir_elemento_usuario: 	;Funcao para inserir o elemento na matriz
	enter 0,0	
		mov esi,dword[ebp+8]			; Pega a primeira posicao para onde vetor aponta	
		push digite_ler_posicao			;Imprimi a mensagem para o usuario digitar o elemento
		call  printf
		add esp,4							;Como cada push tem tamanho de 4 bytes entao incrementa o esp em 4
		push var_ler						;Empilha a variavel que vai armazenar o valor lido para a posicao
		push ler_int
		call scanf
		add esp,8
		xor ebx,ebx
		mov ebx,[var_ler]
		add esi,ebx
		mov byte[esi],'X'						;USUARIO VAI JOGAR COM A POSICAO X
leave
ret	4								;Retorn para a funcao principal
;============================================FIM DA FUNCAO INSERIR ELEMENTO USUARIO========================================================================
;============================================INICIO DA FUNCAO QUE IMPRIME A MATRIZ [3][3]=====================================================================
function_imprimir_matriz:			;Funcao para imprimir a matriz
	enter 0,0							;Serve para criar Frame da pilha = (push ebp, ebp = esp )
		mov esi,[ebp+8]   				; Pega a primeira posicao para onde vetor aponta
		add esi,8		    				 ; como vamos jogar na pilha entao vai imprimir da ordem inversa por isso comeco da ultima posicao
		mov eax,[esi]
		push eax		 				 ; [vetor+8]
		dec esi
		mov eax,[esi]					;[vetor+7]
		push eax
		dec esi
		mov eax,[esi]					;[vetor+6]
		push eax
		dec esi
		mov eax,[esi]					;[vetor+5]
		push eax
		dec esi
		mov eax,[esi]					;[vetor+4]
		push eax
		dec esi
		mov eax,[esi]					;[vetor+3]
		push eax
		dec esi
		mov eax,[esi]					;[vetor+2]
		push eax
		dec esi	
		mov eax,[esi]					;[vetor+1]
		push eax
		dec esi
		mov eax,[esi]					;[vetor+0]
		push eax
		push sai_matriz
		call printf
		add esp,40					;Como cada push tem tamanho de 4bytes e temos 9push =36bytes
	leave								;Destroi a Frame da pilha ebp volta a ser o valor anterior de ebp
ret 	4									;ret 4 serve para quando no main for colocado na pilha o vetor e for chamado o imprimir_matriz quando voltar o ret nao precisar add esp,4 no main
;===========================================FIM DA FUNCAO QUE IMPRIME A MATRIZ[3][3]==========================================================================
;===========================================ENCERRA O PROGRAMA=============================================================================================
fim:
	mov eax,1
	mov ebx,0
	int 0x80
	ret
