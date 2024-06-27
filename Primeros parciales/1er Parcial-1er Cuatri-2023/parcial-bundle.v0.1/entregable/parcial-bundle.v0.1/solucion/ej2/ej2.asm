global miraQueCoincidencia


section .rodata
bachaDeConstantesFlotanes: dd 0.299, 0.587, 0.114, 0
bytesMenosSignificativosDePixeles: times 4 db 0, 4, 8, 12 
;########### SECCION DE TEXTO (PROGRAMA)
section .text

;void miraQueCoincidencia( uint8_t *A, uint8_t *B, uint32_t N, uint8_t *laCoincidencia )

; rdi[*A], rsi[*B], rdx[N], rcx[*laCoincidencia]
miraQueCoincidencia:
    push rbp
    mov rbp, rsp

    ;loop = N*N    
    ;'    = rdx * rdx	

    xor rax, rax
    mov rax, rdx

    mul edx ; rax = eax * edx 
    shr rax , 2 ; rax = n * n / 4 = loop
    mov r8, rax

    xor rax, rax ; rax = iterarod = 0

    .loop:
    
        movdqu xmm0, [rdi] ; xmm0 = src1 
        movdqu xmm2, [rsi] ; xmm1 = src2

        movdqu xmm1 ,xmm0  ;'temp src`       `        	
        ;crear caso convertirEscalas y caso 255

        ;crear caso convertirEscalas
        ;extender componenets a doubles para multiplicar con floats
        ;osea, extender los primeros 4 bytes, shiftear a la derecha 4, y hacer lo mismo
        pmovzxbd xmm3, xmm1
        psrldq xmm1, 4
        pmovzxbd xmm4, xmm1
        psrldq xmm1, 4
        pmovzxbd xmm5, xmm1
        psrldq xmm1, 4
        pmovzxbd xmm6, xmm1
        ;convertir a float
        cvtps2dq xmm3, xmm3
        cvtps2dq xmm4, xmm4
        cvtps2dq xmm5, xmm5
        cvtps2dq xmm6, xmm6
        ;cargar bacha de constantes flotantes
        movdqu xmm7, [bachaDeConstantesFlotanes]
        ; multiplicar
        mulps xmm3, xmm7
        mulps xmm4, xmm7
        mulps xmm5, xmm7
        mulps xmm6, xmm7
        ;suma horizontal de a floats


        haddps xmm3, xmm3
        haddps xmm3, xmm3
        
        haddps xmm4, xmm4
        haddps xmm4, xmm4
        
        haddps xmm5, xmm5
        haddps xmm5, xmm5
        
        haddps xmm6, xmm6
        haddps xmm6, xmm6
        ;reconvertir float a int

        cvttps2dq xmm3, xmm3
        cvttps2dq xmm4, xmm4
        cvttps2dq xmm5, xmm5
        cvttps2dq xmm6, xmm6
        ;pasar de double a byte mediante sacando el byte menos signficativo del double
        movdqu xmm7, [bytesMenosSignificativosDePixeles]

        pshufb xmm3, xmm7

        pshufb xmm4, xmm7

        ;caso convertiGrises hecho

        ;caso 255
        pcmpeqb xmm6, xmm6  ;'xmm6 = todos 255
        ;caso 255 hecho

        ;crear mascara de predicado
        ;se crea mediante comparar por equal src1 con src2
        pcmpeqd xmm0, xmm2
        ; si un double de xmm0 es igual a 0xffffffff
        ; eso quiere decir que pixel de src1 es igual a pixel de src2
        ; podemos usar esta mascara con pand o pandn para filtra el caso que corresponde

        ;reacomoodar mascara para que sea de 8 bits
        pshufb xmm0, xmm7
        ;if else en forma de filtrado mediante la mascara de predicado
        ;si los pixeles son iguales, se toma la bacha de convertir a grise
        ;si los pixeles son desiguales, se toma la bacah de 255
        pand xmm1, xmm0
        pandn xmm0, xmm6

        por xmm1, xmm0

        ;en xmm1 esta ambos casos,son el uno o el otro

        ;llevarlos a destino de a double word
        movd [rcx + rax], xmm1
        add rax, 4
        
        add rsi, 16
        add rdi, 16
        dec r8

        cmp r8, 0
        jne .loop

    pop rbp
    ret