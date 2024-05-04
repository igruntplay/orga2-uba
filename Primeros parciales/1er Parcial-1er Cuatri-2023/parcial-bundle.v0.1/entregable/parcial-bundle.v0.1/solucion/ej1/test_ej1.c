#include <stdio.h>
#include "ej1.h"

void test_cuantosTemplosClasicos_c() {
    // Test case 1: No classic temples
    templo temples[] = {
        {4, 2}, // M = 4, N = 2
        {6, 3}, // M = 6, N = 3
        {8, 4}  // M = 8, N = 4
    };
    size_t numTemples = sizeof(temples) / sizeof(temples[0]);
    uint32_t result = cuantosTemplosClasicos_c(temples, numTemples);
    printf("Test case 1: %u\n", result); // Expected output: 0

    // Test case 2: Some classic temples
    templo temples2[] = {
        {3, 1}, // M = 3, N = 1
        {5, 2}, // M = 5, N = 2
        {7, 3}  // M = 7, N = 3
    };
    size_t numTemples2 = sizeof(temples2) / sizeof(temples2[0]);
    uint32_t result2 = cuantosTemplosClasicos_c(temples2, numTemples2);
    printf("Test case 2: %u\n", result2); // Expected output: 3

    // Test case 3: All classic temples
    templo temples3[] = {
        {1, 0}, // M = 1, N = 0
        {3, 1}, // M = 3, N = 1
        {5, 2}  // M = 5, N = 2
    };
    size_t numTemples3 = sizeof(temples3) / sizeof(temples3[0]);
    uint32_t result3 = cuantosTemplosClasicos_c(temples3, numTemples3);
    printf("Test case 3: %u\n", result3); // Expected output: 3
}

int main() {
    test_cuantosTemplosClasicos_c();
    return 0;
}