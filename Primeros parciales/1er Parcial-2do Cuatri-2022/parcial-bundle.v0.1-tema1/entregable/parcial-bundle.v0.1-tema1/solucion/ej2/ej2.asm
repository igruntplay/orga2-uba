extern malloc
global filtro

;########### SECCION DE DATOS
section .data
align 16
mascara: db 2, 3, 6, 7, 10, 11, 14, 15, 0, 1, 4, 5, 8, 9, 12, 13


;########### SECCION DE TEXTO (PROGRAMA)
section .text


;int16_t* filtro (const int16_t* entrada, unsigned size)
; parametros: entrada = rdi, size = rsi
filtro:
    push rbp
    mov rbp, rsp
    ;salvar paramteros\
    sub rsp, 0x10
    mov [rbp-0x8], rdi  ;guardar entrada
    mov byte [rbp-0x10], sil    ;guardar size

    ; Guardo memoria de tamaño size para el resultado
    sub rsi, 3  ; Restamos los 3 elementos del final.
    sal rsi, 2  ; Multiplicamos por 4 bytes de cada elemento (canales L+R).
    mov rdi, rsi
    call malloc     ;rax = *dst

    ; poner puntero dst a rcx
    ; y usar rax como contador de iteraciones
    xor rsi, rsi
    mov sil, byte [rbp-0x10] ; size
    mov sil, 7



    mov rdi, [rbp-0x8]	; entrada

    xor rcx, rcx
    xor r8, r8
    
    ; considerando que cada xmm de src contiene 4 lefts channels y 4 right channeles (ambos de 16 words)
    ; el destino tiene que tomar ambos conjuntos de valores , sumararlos horizontamente de forma saturada (es un filtro de audio)
    ; y devolver la suma horizontal saturada de los 4 right channels (16 bits) y los 4 left channels (16 bits)
    ; un xmm0 en src 128 bits se traduce a un xmm0 en dst de 32 bits
    ; entonces el tamaño de dst es size * 4 bytes 



    .loop:
    movdqu xmm0, [rdi + rcx] ; xmm0 = !L0 !R0 !L1 !R1 !L2 !R2 !L3 !R3
    
    movdqa xmm7, [mascara] ; xmm7 = 2 3 6 7 10 11 14 15 0 1 4 5 8 9 12 13\

    pshufb xmm0, xmm7 ; ahora queda los de la izquierda por un lado y los de la derecha por otro lado xmm0: !L0 !L1 !L2 !L3 !R0 !R1 !R2 !R3

    phaddsw xmm0, xmm0 ; suma horizontal saturada de los 4 left channels y los 4 right channels

    phaddsw xmm0, xmm0 ; suma horizontal saturada de los 4 left channels y los 4 right channels

    ; ahora quiero dividir por 4 con un shift

    psraw xmm0, 2 ; ahora tengo los 4 left channels en los 16 bits menos significativos y los 4 right channels en los 16 bits mas significativos
    


    movd [rax + rcx], xmm0

    add rcx, 4
    inc r8
    cmp r8, rsi
    jne .loop


    add rsp, 0x10
    pop rbp
    ret

