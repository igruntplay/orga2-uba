; Ejercicio 4 ⋆
; a) Repita una vez m´as el ejercicio pero guardando todos los enteros en la pila, sacarlos de la pila e irlos sumando.
; Volver a guardar el resultado en la pila. Trabaje los n´umeros en 32 bits.
; b) ¿Deber´ıa armar el stackframe?
; c) ¿Cu´al es el tama˜no en bytes del ancho de la pila? ¿C´omo quedar´ıa organizada? Pruebe pusheando con registros de
; 32 y 64 bits


section .data
entero1 dd 10
entero2 dd 20

 
;########### SECCION DE TEXTO (PROGRAMA)
section .text
    
   global _start


    _start:
        ;prologo
        push rbp
        mov rbp, rsp
                
        mov eax , dword [entero1] 
        mov ebx , dword [entero2]

        ; Cargamos los valores de memoria a la pila
        push rax
        push rbx
        ; poppeo valores
        ; como la pila es lifo, primero saco el ultimo valor en entrar, que es el entero 2
        pop rax 
        pop rbx

        ; Sumamos los valores
        add eax, ebx


        ; Epilogo
        mov rsp, rbp
        pop rbp
        ret


; b) debería armar el stack frame? Si, ya que estamos utilizando la pila
; c) El ancho de la pila es de 8 bytes. La pila se organiza de la siguiente manera:
; 0x00: entero1
; 0x04: entero2
; 0x08: return address
; 0x0C: rbp
; 0x10: rsp
; 0x14: espacio reservado para variables locales
; 0x18: espacio reservado para variables locales
;  ...
