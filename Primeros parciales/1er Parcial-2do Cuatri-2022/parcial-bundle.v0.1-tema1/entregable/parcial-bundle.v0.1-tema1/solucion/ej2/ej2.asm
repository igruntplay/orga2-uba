extern malloc
global filtro

;########### SECCION DE DATOS
section .data


;########### SECCION DE TEXTO (PROGRAMA)
section .text


;int16_t* filtro (const int16_t* entrada, unsigned size)
; parametros: entrada = rdi, size = rsi
filtro:
    push rbp
    mov rbp, rsp


    mov xmm0, [rdi]

    .loop:
    ; podemos procesar de a 4 bytes
    ;







    pop rbp
    ret

