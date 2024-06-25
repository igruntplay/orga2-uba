global agrupar

; preguntar porque no me toma el programa en C


;########### SECCION DE DATOS
section .data
;struct msg
%define OFFSET_TEXT 0
%define OFFSET_TEXT_LEN 4
%define OFFSET_TAG 16
%define MAX_TAGS 4

; seccion de bss para reservar memoria
section .bss
tamañoAReservarPorTag resq MAX_TAGS ; Reservar espacio para el arreglo


;########### SECCION DE TEXTO (PROGRAMA)
section .text

global agrupar

extern calloc

; acá voy a hacer la función agrupar
; tengo que reservar memoria para el arreglo a devolver, este arreglo tendrá MAX_TAGS elementos
; los elementos van a tener un tamaño de 8 bytes pues son punteros a un char.

;char** agrupar_c(msg_t* msgArr, size_t msgArr_len){
; parametros: rdi = msgArr, rsi = msgArr_len
agrupar:
    ; preparo pila
    push rbp
    mov rbp, rsp
    ; voy a pushear los parametros a la pila
    push rdi
    push rsi
    ; Preguntar como manejar esto
    sub rsp, 16
    mov [rbp-8], rdi
    mov [rbp-16], rsi

    ; reservo memoria para el arreglo de punteros
    ;     char** result = calloc(MAX_TAGS, 8);

    mov rdi, MAX_TAGS
    mov rsi, 8
    call calloc

;    char** copyResult = result;
    mov rax, tamañoAReservarPorTag

    mov rdi, [rbp-8] ; msgArr
    mov rsi, [rbp-16] ; msgArr_len
    ; ^^ Preguntar si se puede hacer esto

    ; quiero inicializar el arreglo en cero
    xor rdx, rdx ; rdx = 0
    mov rbx, rax ; rbx = copyResult

    xor rcx, rcx
    ;     for (size_t i = 0; i < msgArr_len; i++)
       ;     {
       ; tamañoAReservarPorTag[msgArr[i].tag] += msgArr[i].text_len + 1; // le sumo 1 porque el tamaño no cuenta el caracter nulo
       ;     }
    .loop1:
            cmp rcx, rsi
            jge .endLoop1
            ; tamañoAReservarPorTag[msgArr[i].tag] += msgArr[i].text_len + 1; // le sumo 1 porque el tamaño no cuenta el caracter nulo
            mov rax, [rdi + rcx*16 + OFFSET_TAG] ; rax = msgArr[i].tag
            ; a rax le paso rdi + i x 16 + OFFSET_TAG
            mov rbx, [rdi + rcx*16 + OFFSET_TEXT_LEN + 1]
            inc rcx
            jmp .loop1

    .endLoop1:
    ;     for (size_t i = 0; i < MAX_TAGS; i++) {
    ;    // Pido memoria para cada uno de los arreglos que voy a formar con la concatenación de los text  de igual tag, y guardo los punteros en el arreglo a devolver
    ;        char* pointer = calloc(tamañoAReservarPorTag[i], 1);
;             result[0] = pointer;

            xor rcx, rcx
            .loop2:
                cmp rcx, MAX_TAGS
                jge .endLoop2
                mov rdi, [tamañoAReservarPorTag + rcx*8]
                mov rsi, 1
                call calloc
                mov [rbx + rcx*8], rax ; result[0] = pointer;
                inc rcx
                jmp .loop2

    .endLoop2:
    ;     // Ahora tengo que concatenar los strings en la posición de memoria correspondiente
    ;     for (size_t i = 0; i < msgArr_len; i++)
        xor rcx, rcx
            .loop3:
                cmp rcx, rsi
                jge .endLoop3
                ; char* pointer = result[msgArr[i].tag];
        ; result[msgArr[i].tag] += msgArr[i].text_len + 1; // le sumo 1 porque el tamaño no cuenta el caracter nulo
                mov rax, [rdi + rcx*16 + OFFSET_TAG] ; rax = msgArr[i].tag
                mov rbx, [rdi + rcx*16 + OFFSET_TEXT_LEN + 1]
                inc rcx
                jmp .loop3
    .endLoop3:
    .fin:
          pop rbp
          pop rsi
          pop rdi
            ret