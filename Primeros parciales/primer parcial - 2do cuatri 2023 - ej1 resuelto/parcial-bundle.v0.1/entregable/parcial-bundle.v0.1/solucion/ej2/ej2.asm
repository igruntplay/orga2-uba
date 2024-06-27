global mezclarColores

;########### SECCION DE DATOS (VARIABLES)
section .data 



;########### SECCION DE TEXTO (PROGRAMA)
section .text

;void mezclarColores( uint8_t *X, uint8_t *Y, uint32_t width, uint32_t height);
mezclarColores:


; si R > G > B => El pixel resultante (B,R,G)
; si R < G < B => El pixel resultante (G,B,R)
; caso contrario => El pixel resultante (R,G,B) o sea, se mantiene igual

