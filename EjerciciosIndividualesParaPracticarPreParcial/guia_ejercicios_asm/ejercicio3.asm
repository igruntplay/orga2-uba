;Ejercicio 3 ⋆
;a) Escriba un ejercicio en Assembler que lea los enteros desde memoria y gu´ardelos en registros distintos antes de sumarlos.
;b) ¿Deber´ıa armar el stackframe? ¿Qu´e registros tuvo que preservar? ¿Alcanzaron los registros? Si no: ¿C´omo lo resolvi´o?
;Tip Explore la clase pr´actica n´umero 3 sobre armado de stackframe y preservaci´on de registros en 64 bits.
;########### SECCION DE DATOS
section .data
entero1 dd 10
entero2 dd 20

 
;########### SECCION DE TEXTO (PROGRAMA)
section .text
    
   global _start
;   a) Escriba un ejercicio en Assembler que lea los enteros desde memoria y gu´ardelos en registros distintos antes de sumarlos.
    ; Para leer los enterios desde memoria, tenemos que pushear los valores al stack frame


    _start:
        ; prologo
        push rbp
        mov rbp , rsp
        push rsi
        push rdi
        sub rsp, 16 ; Reservamos espacio para las variables locales
        ; Cargamos los valores de memoria a los registros
        mov rsi, [entero1] 
        mov rdi, [entero2]
        ; Sumamos los valores
        add rsi, rdi ; rsi = rsi + rdi
        ; Mostramos el resultado
        mov rax, rdi 
        ; poppeo registros
        pop rdi
        pop rsi
        ; epilogo
        mov rsp, rbp
        pop rbp

    ; Salir del programa usando syscall
    mov eax, 60         ; syscall número para 'exit'
    xor edi, edi        ; código de salida 0
    syscall             ; realizar la llamada al sistema


; b) siempre tengo que armar el stack frame, en este caso pusheo los dos registros que quiero reservar, si alcanzan porque solo necesito dos registros.
; en el caso que no alcancen los registros, se puede utilizar la pila para guardar los valores de los registros que no se estan utilizando en ese momento, y si todavía no alcanzan recién ahí puedo empezar a utilizar la memoria principal.
