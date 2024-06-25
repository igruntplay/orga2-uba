#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <stddef.h> // Para offsetof()
#include "ej1.h"

int main (void){
	/* Acá pueden realizar sus propias pruebas */

    printf("El tamaño de int es: %zu bytes\n", sizeof(int));
	printf("El tamaño de size_t es: %zu bytes\n", sizeof(size_t));
	printf("Offset de size_t en msg: %zu\n", offsetof(struct msg,text_len));
	printf("Offset de tag en msg: %zu\n", offsetof(struct msg,tag));

	printf("El tamaño de char es: %zu bytes\n", sizeof(char));
	return 0;    
}


