global acumuladoPorCliente_asm
global en_blacklist_asm
global blacklistComercios_asm


;<<<REMOVE>>>
extern malloc
extern free
extern strcmp
extern acumuladoPorCliente
extern en_blacklist
extern blacklistComercios

;; Definir offsets:
;typedef struct pago {
  ;uint8_t monto; 
  ;char* comercio; 
  ;uint8_t cliente; 
 ; uint8_t aprobado; 
;} pago_t; 

%define OFFSET_MONTO	0
%define OFFSET_COMERCIO	8
%define OFFSET_CLIENTE	16
%define OFFSET_APROBADO	24
%define TAMANIO_ENTERO_32 4
;########### SECCION DE TEXTO (PROGRAMA)
section .text

; Mapeo de parámetros a registros:
; Signatura de la función: uint32_t* acumuladoPorCliente_asm(uint8_t cantidadDePagos, pago_t* arr_pagos);
; cantidadDePagos[RDI], arr_pagos[RSI]

acumuladoPorCliente_asm:
    push rbp
    mov rbp, rsp
	push r15
	push r14
	push r13
	sub rsp, 8 ; alineo la pila

    mov r15, 10
    mov r14, TAMANIO_ENTERO_32

    ; Calcular el tamaño de memoria a pedir
    mov rax, r15
    mul r14
    mov rdi, rax
    call malloc
    mov r13, rax ; r13 = res

    xor rcx, rcx ; rcx se usará como contador

    .ciclo:
        cmp rcx, rdi ; si rcx >= cantidadDePagos, termino
        jge .fin

        ; Si pago_i.aprobado == 1, entonces res[arr_pagos[i].cliente] += arr_pagos[i].monto
        cmp byte [rsi + OFFSET_APROBADO], 1
        jne .siguiente

        movzx rax, byte [rsi + OFFSET_CLIENTE] ; eax = arr_pagos[i].cliente
        movzx rdx, byte [rsi + OFFSET_MONTO]   ; edx = arr_pagos[i].monto
        add dword [r13 + 4*rax], edx           ; res[arr_pagos[i].cliente] += arr_pagos[i].monto

    .siguiente:
        inc rcx
        add rsi, TAMANIO_ENTERO_32
        jmp .ciclo

    .fin:
        mov rax, r13 ; Devolver el puntero al arreglo res
        pop rbp
		pop r15
		pop r14
		pop r13
        ret


en_blacklist_asm:
;<<<REMOVE>>>
    jmp en_blacklist
;<<<REMOVE END>>>
	ret

blacklistComercios_asm:
;<<<REMOVE>>>
    jmp blacklistComercios
;<<<REMOVE END>>>
	ret
