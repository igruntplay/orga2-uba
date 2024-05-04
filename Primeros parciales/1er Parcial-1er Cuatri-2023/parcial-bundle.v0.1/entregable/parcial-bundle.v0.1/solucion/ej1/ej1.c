#include "ej1.h"

uint32_t cuantosTemplosClasicos_c(templo *temploArr, size_t temploArr_len){
    //; La misma devuelve la cantidad de templos que son del periodo clasico, es decir cumplen con la condición M = 2n+1 y la otra de n = (M-1)/2
    uint32_t count = 0;
    for (size_t i = 0; i < temploArr_len; i++)
    {
        uint8_t M = temploArr[i].colum_largo;
        uint8_t N = temploArr[i].colum_corto;
        if(M == 2*N+1){
            count++;
        }
    }
    return count;
}
  
templo* templosClasicos_c(templo *temploArr, size_t temploArr_len){
    //; La misma devuelve un puntero a un arreglo de templos que son del periodo clasico, es decir cumplen con la condición M = 2n+1 y la otra de n = (M-1)/2
    templo *templosClasicos = malloc(temploArr_len * sizeof(templo));
    if(templosClasicos == NULL){
        return NULL;
    }
    uint32_t count = 0;
    for (size_t i = 0; i < temploArr_len; i++)
    {
        uint8_t M = temploArr[i].colum_largo;
        uint8_t N = temploArr[i].colum_corto;
        if(M == 2*N+1){
            templosClasicos[count] = temploArr[i];
            count++;
        }
    }
    return templosClasicos;
}



/*


Funciones de testing interno

void imprimirTemplo(templo t) {
    printf("Templo: colum_largo = %d, colum_corto = %d\n", t.colum_largo, t.colum_corto);
}

void imprimirArregloTemplos(templo *arr, size_t len) {
    for (size_t i = 0; i < len; i++) {
        imprimirTemplo(arr[i]);
    }
}

int compararArreglosTemplos(templo *arr1, templo *arr2, size_t len) {
    for (size_t i = 0; i < len; i++) {
        if (arr1[i].colum_largo != arr2[i].colum_largo || arr1[i].colum_corto != arr2[i].colum_corto) {
            return 0;
        }
    }
    return 1;
}

void realizarPrueba(templo *temploArr, size_t len, templo *expected, size_t expectedLen) {
    templo *result = templosClasicos_c(temploArr, len);
    printf("Expected:\n");
    imprimirArregloTemplos(expected, expectedLen);
    printf("Result:\n");
    imprimirArregloTemplos(result, expectedLen);
    if (compararArreglosTemplos(result, expected, expectedLen)) {
        printf("Prueba exitosa\n");
    } else {
        printf("Prueba fallida\n");
    }
    free(result);
}

int main() {
    // Prueba 1: Arreglo vacío
    templo *temploArr1 = NULL;
    size_t len1 = 0;
    templo expected1[] = {};
    size_t expectedLen1 = 0;
    printf("Prueba 1 - Arreglo vacío:\n");
    realizarPrueba(temploArr1, len1, expected1, expectedLen1);

    // Prueba 2: Arreglo con un templo clásico
    templo temploArr2[] = {{9, "Templo1", 4}};
    size_t len2 = sizeof(temploArr2) / sizeof(temploArr2[0]);
    templo expected2[] = {{9, "Templo1", 4}};
    size_t expectedLen2 = sizeof(expected2) / sizeof(expected2[0]);
    printf("\nPrueba 2 - Arreglo con un templo clásico:\n");
    realizarPrueba(temploArr2, len2, expected2, expectedLen2);

    // Prueba 3: Arreglo con un templo no clásico
    templo temploArr3[] = {{10, "Templo2", 4}};
    size_t len3 = sizeof(temploArr3) / sizeof(temploArr3[0]);
    templo expected3[] = {};
    size_t expectedLen3 = 0;
    printf("\nPrueba 3 - Arreglo con un templo no clásico:\n");
    realizarPrueba(temploArr3, len3, expected3, expectedLen3);

    // Prueba 4: Arreglo con varios templos clásicos y no clásicos
    templo temploArr4[] = {
        {9, "Templo3", 4},
        {10, "Templo4", 4},
        {7, "Templo5", 3},
        {8, "Templo6", 3}
    };
    size_t len4 = sizeof(temploArr4) / sizeof(temploArr4[0]);
    templo expected4[] = {
        {9, "Templo3", 4},
        {7, "Templo5", 3}
    };
    size_t expectedLen4 = sizeof(expected4) / sizeof(expected4[0]);
    printf("\nPrueba 4 - Arreglo con varios templos clásicos y no clásicos:\n");
    realizarPrueba(temploArr4, len4, expected4, expectedLen4);

    return 0;
}

*/