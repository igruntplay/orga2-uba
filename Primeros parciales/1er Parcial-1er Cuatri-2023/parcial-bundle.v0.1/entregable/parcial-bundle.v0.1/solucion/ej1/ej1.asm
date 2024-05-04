global templosClasicos
global cuantosTemplosClasicos
extern calloc
extern malloc

; La relación entre la cantidad de columnas es 2N+1=M, con M el lado largo y N el lado corto
; Entonces M = 2N + 1, y N = (M - 1)/2
section .data

%define STRUCT_TEMPLO_SIZE 24
%define OFFSET_COLUM_LARGO 0
%define NOMBRE 8
%define OFFSET_COLUM_CORTO 16

;########### SECCION DE TEXTO (PROGRAMA)
section .text


; Signatura de la función:
; uint32_t cuantosTemplosClasicos(templo *temploArr, size_t temploArr_len);

; La misma devuelve la cantidad de templos que son del periodo clasico, es decir cumplen con la condición M = 2n+1 y la otra de n = (M-1)/2

; Mapeo de parámetros a registros: 
; rdi[temploArr], rsi[temploArr_len]

; Idea de la implementación:
; Lo que tengo que hacer es agarrar el templo, calcular la cantidad de columnas largo y ancho y comparar
; Como no voy a llamar ninguna función en el medio no me interesa lo de los registros no volátiles

cuantosTemplosClasicos:
	; prólogo 
	push rbp
	mov rbp, rsp
	push r11
	push r12
	push r13
	push r14
	push r15

	; cuerpo
	xor r12, r12 ; r12 = 0 ; r12 es el contador de templos clásicos
	xor rcx , rcx ; rcx = 0 ; rcx es el contador de iteraciones
	mov r13, rdi ; r13 = temploArr
	mov r14, rsi ; r14 = temploArr_len
	.loop:
		cmp rcx , r14 ; si rcx >= r14, termino
		jge .fin

		movzx rax, byte [r13 + OFFSET_COLUM_LARGO] ; rax = temploArr[rcx].colum_largo (M)
		movzx rbx, byte [r13 + OFFSET_COLUM_CORTO] ; rbx = temploArr[rcx].colum_corto (N)
		imul rbx, rbx, 2 ; rbx = 2N
		; Si M = 2N + 1, entonces es un templo clásico
		; if (rax == 2*rbx + 1) => r12++
		lea r11, [rbx+1]
		cmp rax, r11
		jne .siguiente

		inc rcx  
		inc r12 ; r12++
	.siguiente:
		add r13, STRUCT_TEMPLO_SIZE
		inc rcx
		jmp .loop

	.fin:
	; epílogo
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop rbp
	ret  

; Signatura de la función:
; templo* templosClasicos(templo *temploArr, size_t temploArr_len);

; Mapeo de parámetros a registros:
; rdi[temploArr], rsi[temploArr_len]

; Idea de la implementación:
; Primero tengo que pedir memoria para el arreglo de templos clásicos,
; Para esto necesito usar la función del ítem a para saber cuántos templos de la lista son clásicos
; y así llamo calloc(#templosClásicos, size_struct_templo = 24 bytes)

templosClasicos:
	; prólogo 
	push rbp
	mov rbp, rsp
	push r12
	push r13
	push r14
	push r15

	; cuerpo
	; Primero me guardo los parámetros originales en registros no volátiles, para no perderlos al llamar calloc
	mov r15, rdi ; r15 = temploArr
	mov r14, rsi ; r14 = temploArr_len

	push rdi
	push rsi
	call cuantosTemplosClasicos
	pop rsi
	pop rdi
	mov rdi, rax ; rdi = #templosClásicos


	mov rsi, STRUCT_TEMPLO_SIZE ; rsi = 24
	call calloc ; rax = calloc(#templosClásicos, 24 bytes)
	; voy a saltearme el if templosClasicos == NULL, porque no lo pide el enunciado
	; voy a usar r12 como contador de templos clásicos
	xor r12, r12 ; r12 = 0
	xor rcx, rcx ; rcx = 0
	.loop:
		cmp rcx, r14 ; si rcx >= r14, termino
		jge .fin

		movzx rax, byte [r15 + OFFSET_COLUM_LARGO] ; rax = temploArr[rcx].colum_largo (M)
		movzx rbx, byte [r15 + OFFSET_COLUM_CORTO] ; rbx = temploArr[rcx].colum_corto (N)
		imul rbx, rbx, 2 ; rbx = 2N
		; Si M = 2N + 1, entonces es un templo clásico
		; if (rax == 2*rbx + 1) => r12++
		lea r13, [rbx+1]
		cmp rax, r13
		jne .avanzar

		; Hay que guardar el templo clasico en templosClasicos[r12]
		; Copiar el templo clasico al nuevo arreglo
		mov rdi, r13 ; destino : nuevo arreglo
		mov rsi, r15 ; origen : temploArr
		imul r12, STRUCT_TEMPLO_SIZE ; r12 = r12 * 24
		imul rcx, STRUCT_TEMPLO_SIZE ; rcx = rcx * 24
		add rdi, r12 ; destino
		add rsi, rcx ; origen
		mov rcx , STRUCT_TEMPLO_SIZE ; rcx = 24
		rep movsb ; copio el templo
		inc r12 ; r12++ ; incremento el contador de templos clásicos


		.avanzar:
			;templosClasicos[r12] = temploArr[rcx];
			add r15, STRUCT_TEMPLO_SIZE ; avanzo en temploArr
			inc rcx ; rcx++
			jmp .loop

	.fin:
	; epílogo
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbp
	ret


