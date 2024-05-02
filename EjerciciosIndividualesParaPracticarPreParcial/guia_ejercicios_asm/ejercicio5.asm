;Ejercicio 5 ⋆⋆
;a) Escriba un programa que tenga dos funciones: llamadora e invocada. Desde llamadora debe llamar a la funci´on invocada.
;invocada recibe un entero entre 1 y 10, y debe retorna la direcci´on de memoria a ejecutar cuando resuma la llamadora m´as ese entero.
;b) Utilice GDB para debuguear y verificar que la direccion de memoria retornada es correcta.
;c) ¿C´omo puede encontrar las direcciones que corresponden a la pila en cada funci´on?
;d) Realice un seguimiento del uso de la pila, esto significa, haga un gr´afico en lapiz y papel de la pila, indique direcciones,
;y contenido. Puede explorarla usando GDB.

section .text
    global _start

    _start:
    call llamadora
    mov rax, 60
    xor rdi, rdi
    syscall


    llamadora:
        ; acá va la función llamadora que llama a invocada
        ;prologo
        push rbp
        mov rbp, rsp
        
        sub rsp, 8

        mov rdi , 5
        call invocada    
        add rsp, 8
        pop rbp
        ret
    invocada:
        push rbp
        mov rbp, rsp
        ; calculo la dirección de retorno
        mov rax, rdi
        add rax, [rbp+8]
        mov [rbp+8], rax
        ;epilogo
        mov rsp, rbp
        pop rbp
        ret
    