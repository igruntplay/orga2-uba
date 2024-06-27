global templosClasicos
global cuantosTemplosClasicos
extern calloc
extern malloc
extern free
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


; *temploArr = rdi, temploArr_len = rsi
cuantosTemplosClasicos:
push rbp
mov rbp, rsp

; ahora quiero recorrer el arreglo de templos
xor rdx, rdx
xor rcx, rcx
xor rax, rax
	;for (size_t i = 0; i < temploArr_len; i++)
	.loop:
		cmp rcx, rsi
		je .fin
		; uint8_t M = temploArr[i].colum_largo;
		mov r9, [rdi + rdx + OFFSET_COLUM_LARGO] ; r9 = M 
		; uint8_t N = temploArr[i].colum_corto;
		mov r10, [rdi + rdx + OFFSET_COLUM_CORTO] ; r10 = N
		; if (M == 2*N + 1)
		xor r11, r11
		; primero calculo 2N + 1
		add r11, r10
		add r11, r10
		inc r11
		cmp r11, r9
		jne .noEsClasico
		; si es clasico incremento el contador
		inc rax
		.noEsClasico:
		inc rcx
		add rdx, STRUCT_TEMPLO_SIZE
		jmp .loop
	.fin:
		pop rbp
		ret

;templo* templosClasicos(templo *temploArr, size_t temploArr_len)
; rdi = temploArr, rsi = temploArr_len

templosClasicos:
	push rbp
	mov rbp, rsp
; voy a querer guardarme los parametros originales
	push r14
	push r15

	mov r14, rdi ; r14 = temploArr
	mov r15, rsi; r15 = temploArr_len

; ahora rdi = temploArr, rsi = temploArr_len
	call cuantosTemplosClasicos
	; rax = num_clasicos
	mov rdi, rax ; rdi = num_clasicos
	mov rsi, STRUCT_TEMPLO_SIZE ; rsi = sizeof(templo)
	; ahora tengo que reservar memoria para los templos clasicos
	call calloc
; rax = puntero a memoria reservada
; ahora me guardo rax en r10

; ahora tengo que recorrer el arreglo de templos y copiar los clasicos
	xor rdx, rdx ; a rdx lo voy a usar para recorrer el arreglo de templos
	xor rcx, rcx; rcx lo voy a usar para recorrer el arreglo de templos clasicos
	.loop:
		cmp rdx, r15
		je .fin
		; uint8_t M = temploArr[i].colum_largo;
		mov r9, [r14 + rdx + OFFSET_COLUM_LARGO] ; r9 = M
		; uint8_t N = temploArr[i].colum_corto;
		mov r10, [r14 + rdx + OFFSET_COLUM_CORTO] ; r10 = N
		; if (M == 2*N + 1)
		xor r11, r11
		; para calcular 2n + 1 hago un add de n y n y luego incremento
		add r11, r10
		add r11, r10
		inc r11
		; ahora comparo si M == 2N + 1
		cmp r11, r9
		jne .noEsClasico

		;poner clasico en array destino
		;esto implica copiar los 24 bytes que ocupa
		;el struct al array y luego iterar
		;tenemos que mediante un loop de 3
		;çopiar a 8 bytes, iterar 8, hasta copiar todo
		; luego iterar el array de templos parametro

		mov r9, [r14 + rdx] ; r9 = puntero a templo clasico
		mov [rax + rcx], r9
		add rcx, STRUCT_TEMPLO_SIZE	

		.noEsClasico:
		add rdx, STRUCT_TEMPLO_SIZE
		dec r15
		cmp r15, 0
		jne .loop
; Sí es clasico tengo que guardarme el templo mediante un bucle 




	pop rbp
	ret