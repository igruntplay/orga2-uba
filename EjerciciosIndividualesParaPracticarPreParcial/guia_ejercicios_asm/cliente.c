// cliente.c
#include "cliente.h"
#include <stdio.h>
#include <stddef.h>

#define NUM_CLIENTES 10
// Declaración de la función en ensamblador
extern void seleccionar_cliente_aleatorio(cliente_t *cliente, cliente_t *clientes, int num_clientes);


int main() {
    cliente_t clientes[NUM_CLIENTES] = {
        {"Nombre1", "Apellido1", 100, 12345678},
        {"Nombre2", "Apellido2", 200, 23456789},
        {"Nombre3", "Apellido3", 300, 34567890},
        {"Nombre4", "Apellido4", 400, 45678901},
        {"Nombre5", "Apellido5", 500, 56789012},
        {"Nombre6", "Apellido6", 600, 67890123},
        {"Nombre7", "Apellido7", 700, 78901234},
        {"Nombre8", "Apellido8", 800, 89012345},
        {"Nombre9", "Apellido9", 900, 90123456},
        {"Nombre10", "Apellido10", 1000, 1234567}
    };

    cliente_t cliente_seleccionado;

    seleccionar_cliente_aleatorio(&cliente_seleccionado, clientes, NUM_CLIENTES);

    printf("Cliente seleccionado:\n");
    printf("Nombre: %s\n", cliente_seleccionado.nombre);
    printf("Apellido: %s\n", cliente_seleccionado.apellido);
    printf("Compra: %lu\n", cliente_seleccionado.compra);
    printf("DNI: %u\n", cliente_seleccionado.dni);




    return 0;
}
