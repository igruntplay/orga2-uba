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

section .data
espacio_10 resd 10
TAMANIO_PAGO_T equ 24

; Estructura de datos para representar un pago
; typedef struct pago {
;   uint8_t monto;      // 0
;   char* comercio;     // 8
;   uint8_t cliente;    // 16
;   uint8_t aprobado;   // 17
; } pago_t;             // padding desde 18 hasta 23 para alineacion de 8 bytes

%define OFFSET_MONTO	0
%define OFFSET_COMERCIO	8
%define OFFSET_CLIENTE	16
%define OFFSET_APROBADO	17
%define TAMANIO_ENTERO_32 4
;########### SECCION DE TEXTO (PROGRAMA)
section .text

; Mapeo de parámetros a registros:
; Signatura de la función: uint32_t* acumuladoPorCliente_asm(uint8_t cantidadDePagos, pago_t* arr_pagos);
; cantidadDePagos[RDI], arr_pagos[RSI]

acumuladoPorCliente_asm:
    push rbp
    mov rbp, rsp
    push rdi     ; Guarda rdi (cantidadDePagos)
    push rsi     ; Guarda rsi (arr_pagos)
    push rbx     ; Usado más adelante para índices
    push r12     ; Guarda el puntero a los resultados

	sub rsp, 32 ; Reserva espacio para variables locales

    mov r15, espacio_10
    mov r14, TAMANIO_ENTERO_32

    ; Calcular el tamaño de memoria a pedir
   
    mov rdi, 10 * TAMANIO_ENTERO_32 ; Prepara el argumento para malloc (10 * 4 bytes)
    call malloc
    mov r12, rax ; r12 = puntero al array de resultados
    xor rax, rax ; Zero rax para usar en la inicialización

    ; inicializar el array de resultados en 0
    mov rcx, 10
    .cero_ciclo:
        mov [r12 + 4*rcx], rax
        loop .cero_ciclo
        pop rsi      ; Recupera rsi (arr_pagos)
        pop rdi      ; Recupera rdi (cantidadDePagos)
        xor rbx, rbx ; rbx será el índice para arr_pagos


    .ciclo:
        cmp rcx, rdi ; si rcx >= cantidadDePagos, termino
        jge .fin

        ; Si pago_i.aprobado == 1, entonces res[arr_pagos[i].cliente] += arr_pagos[i].monto
        cmp byte [rsi + rbx*TAMANIO_PAGO_T + OFFSET_APROBADO], 1
        jne .siguiente

        movzx rax, byte [rsi + OFFSET_CLIENTE] ; eax = arr_pagos[i].cliente
        movzx rdx, byte [rsi + OFFSET_MONTO]   ; edx = arr_pagos[i].monto
        add [r12 + rax*4], edx ; res[arr_pagos[i].cliente] += arr_pagos[i].monto

    .siguiente:
        inc rcx
        add rsi, TAMANIO_ENTERO_32
        jmp .ciclo

    .fin:
            mov rax, r12      ; Prepara el resultado para retorno
    add rsp, 32       ; Limpia el stack de los registros guardados
    pop r12
    pop rbx
    pop rsi
    pop rdi
    pop rbp
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
