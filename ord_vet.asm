   ;Ordenação de um vetor de n posições
   .MODEL small
   .STACK 100h
   .DATA
	vet DB 1,3,4,5
	vet_length DW $-vet
   .CODE
   .startup
prog:
inicio:   
	MOV AX,@DATA
	MOV DS,AX       ;set DS to point to the data segment
	MOV CX,0
	MOV SI, 0
	MOV DI, 0	; Limpando CX, SI e DI

organizar:
	MOV SI, CX	;contador
	MOV BL, vet[SI]	; set o primeiro elemento do vetor em BL
	MOV DI, SI 	; mover o valor de SI para DI


comparar:
	INC DI			;incrementa DI
	CMP DI,vet_length	; compara DI com o tamanho do vetor
	JGE nao_percorrer	; pular se DI for maior ou igual ao tamanho do vetor
analisar:
	CMP BL, vet[DI]
	JG alterar		;se BL for maior que o elemento do vetor, ir para o 'alterar'
	JMP nao_percorrer	;se não, vá para nao_percorrer
alterar:
	XCHG BL, vet[DI]	;troca de posição o BL e o elemento do vetor
	MOV BL, vet[SI]		; set BL no vetor
nao_percorrer: 
	; vazio
	
CMP DI,vet_length	; compara DI com o tamanho do vetor novamente
JL comparar		; se DI ainda é menor que o tamanho do vetor, voltar para 'comparar'

;Resetando os registradores

MOV CX,0
MOV SI, 0
MOV DI, 0	; Limpando CX, SI e DI
MOV SI, CX	;contador
MOV BL, vet[SI]	; set o primeiro elemento do vetor em BL
MOV DI, SI 	; mover o valor de SI para DI

imprimir:
	MOV AH, 02h	; função para exibir caractere
	MOV SI, CX 	; inicia o contador
	MOV DL, vet[SI]	;adiciona o caractere que se deseja exibir
	ADD DL, 48	;adiciona '48' para exibir o número correto
	INT 21h		;imprimi na tela
	INC CX		;incrementa o contador
	CMP CX, vet_length
	JL imprimir	;repetir o laço para imprimir se CX for menor que o tamanho do vetor
	MOV CX,0	;limpar CX
	MOV SI,0	;limpar SI
encerrar:
	MOV AH, 4Ch	; finalizar 
	INT 21h
END prog
