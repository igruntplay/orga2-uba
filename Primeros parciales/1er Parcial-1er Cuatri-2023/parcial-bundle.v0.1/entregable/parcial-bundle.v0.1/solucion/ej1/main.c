#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>

#include "ej1.h"
// Declaraciones de funciones
uint32_t cuantosTemplosClasicos_c(templo *temploArr, size_t temploArr_len);
templo* templosClasicos_c(templo *temploArr, size_t temploArr_len);

int main() {
    templo temploArr[] = {
        {5, 2, "Templo A"},
        {7, 3, "Templo B"},
        {6, 2, "Templo C"},
        {9, 4, "Templo D"},
        // Agrega más templos aquí si es necesario
    };
    size_t temploArr_len = sizeof(temploArr) / sizeof(temploArr[0]);

    templo *result = templosClasicos_c(temploArr, temploArr_len);
    if (result != NULL) {
        for (size_t i = 0; i < cuantosTemplosClasicos_c(temploArr, temploArr_len); i++) {
            printf("Templo %zu: colum_largo=%d, colum_corto=%d, nombre=%s\n", i, result[i].colum_largo, result[i].colum_corto, result[i].nombre);
        }
        free(result);  // Liberar la memoria cuando ya no sea necesaria
    }

    return 0;
}



