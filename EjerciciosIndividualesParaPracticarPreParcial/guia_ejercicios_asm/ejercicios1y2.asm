;Ejercicio 1 ⋆
; Escriba un programa ´unicamente en Assembler que tome un vector de 16 enteros de 32 bits y los sume
;Tip 1 Utilice una etiqueta en la secci´on data para crear el vector.
;Tip 2 Revise los defines vistos en la primer clase pr´actica (DB, DW, DQ).
;¿Cu´al es el apropiado para un vector de enteros de 32 bits?

;#include "ejercicios.h"

;uint32_t sumarElementosVector(uint32_t* vector) {
;	uint32_t result = 0;
;	for (int i = 0; i < 16; ++i) {
;		result += *vector;
;		vector++;
;	}
;	return result;
;}


;########### SECCION DE DATOS
section .data
    ;creo vector de 16 enteros de 32 bits
    vector dd 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
    ; utilizo double word pues cada entero va ocupar 4 bytes (32 bits), respeta la alineacion de memoria y la convención ABI

;########### SECCION DE TEXTO (PROGRAMA)
section .text
    
   global _start


    _start:
        ; prologo
        push rbp
        mov rbp , rsp

        ; armo registros
        mov edi, 16 ; cantidad de elementos del vector
        xor esi, esi ; indice del vector
        xor edx, edx ; acumulador de la suma
        lea ecx, dword [vector] ; direccion de memoria del vector
        .loop:
            cmp esi, edi ; comparo si llegue al final del vector
            je .end ; si llegue al final salto al final
            add edx, dword [ecx + esi*4] ; sumo el valor del vector al acumulador
            inc esi ; incremento el indice
            jmp .loop ; vuelvo a iterar
        .end:
            mov eax, edx ; guardo el resultado en eax
            ; epilogo
            mov rsp, rbp
            pop rbp
            ret
            mov eax, 1          ; syscall para exit
            mov ebx, 0          ; código de salida
            int 0x80            ; interrupción para ejecutar el syscall







;Ejercicio 2 ⋆
;Sobre el ejercicio anterior,
;a) ¿C´omo realiz´o las lecturas de los enteros desde memoria? Si utiliz´o un registro indique cuantos bits tiene.
;b) Ahora, escriba un programa en Assembler que lea los enteros en un registro de 32 bits y los sume en 64 bits
;c) ¿Qu´e ventaja encuentra en sumarlos en 64 bits?
;d) Asuma que los registros de 64bits est´an completos con unos. ¿Que pasar´ıa cuando muevan los enteros de 32 bits y
;sume en 64 bits? Escriba un c´odigo para solucionar el problema

;a) utilizo el registro esi para guardar el indice del vector y lo voy incrementando para acceder a cada elemento del vector
;b) para pasarlo a 64 bits el acumulador de la suma tendría que utilizar rdx, así que simplemente cambio los registros de 32 bits por los de 64 bits.
; c) la ventaja de sumar en 64 bits es que puedo sumar números más grandes sin tener que preocuparme por el overflow