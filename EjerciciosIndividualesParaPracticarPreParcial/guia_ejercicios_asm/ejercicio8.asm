section .data
    extern cliente_t
        ; Definir los offsets de la estructura
        offset_nombre equ 0
        offset_apellido equ 21
        offset_compra equ 48
        offset_dni equ 56
        elementos_total equ 10


section .text
    .global seleccionar_cliente_aleatorio

;extern void seleccionar_cliente_aleatorio(cliente_t *cliente, cliente_t *clientes, int num_clientes);
; cliente *cliente = rdi
; cliente *clientes = rsi
; int num_clientes = rdx

seleccionar_cliente_aleatorio:
    ; epilogo
    push rbp
    mov rbp, rsp


    call rand
    mov rbx , rax ; agarro el valor random y lo guardo en rdi

    imul rbx, 64 ; multiplico el indice random por el tamaño de cada elemento cliente_t
    mov rsi, [cliente_t] ; Asigna la dirección base del arreglo cliente_t a rsi
    add rbx, rsi ; Suma el offset al puntero base

    ; ahora voy a devolver cliente_t[rbx]
    mov rax, [rbx + offset_nombre]
    mov [rdi], rax
    mov rax, [rbx + offset_apellido]
    mov [rdi + offset_apellido], rax
    mov rax, [rbx + offset_compra]
    mov [rdi + offset_compra], rax
    mov rax, [rbx + offset_dni]
    mov [rdi + offset_dni], rax

    ; prologo
    mov rsp, rbp
    pop rbp
    ret
