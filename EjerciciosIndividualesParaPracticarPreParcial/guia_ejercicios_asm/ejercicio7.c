#include <stdio.h>
#include <stdlib.h>
#include <string.h>


// Escribir un programa en C, que dados dos strings: determina la longitud de su prefijo común más largo.

char prefijo_comun_mas_largo(char* s1, char* s2) {
    int i = 0;
    while (s1[i] == s2[i]) {
        i++;
    }
    return i;
}

char* quitar_prefijo(char* s1, char* s2) {
  
    int longitud_prefijo = prefijo_comun_mas_largo(s1, s2);
    int longitud = strlen(s2) - longitud_prefijo;
    // asignar memoria para el resultado
    char* resultado = malloc(longitud + 1);
    // copiar el contenido de s1 a resultado
    strcpy(resultado, s2 + longitud_prefijo);
    // destiny , source
    return resultado;
}




int main() {
    char* resultado;

    resultado = quitar_prefijo("Astro", "Astrologia");
    printf("quitar_prefijo(\"Astro\", \"Astrologia\") = \"%s\"\n", resultado);
    free(resultado); // Libera la memoria asignada
    return 0;
}
