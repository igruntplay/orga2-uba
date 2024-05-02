// cliente.h
#ifndef CLIENTE_H
#define CLIENTE_H

#include <stdint.h>  // Incluir para tipos de datos uint32_t, uint64_t

#define NAME_LEN 21

typedef struct cliente_str {
    char nombre[NAME_LEN];
    char apellido[NAME_LEN];
    uint64_t compra;
    uint32_t dni;
} cliente_t;

#endif // CLIENTE_H
