# Datos originales intercalados
data = [
    'R0_high', 'R0_low', 'L0_high', 'L0_low', 
    'R1_high', 'R1_low', 'L1_high', 'L1_low', 
    'R2_high', 'R2_low', 'L2_high', 'L2_low', 
    'R3_high', 'R3_low', 'L3_high', 'L3_low'
]

# Máscara de permutación alternativa
shuffle_mask = [2, 3, 6, 7, 10, 11, 14, 15, 0, 1, 4, 5, 8, 9, 12, 13]

# Aplicar la máscara de permutación
permuted_data = [data[i] for i in shuffle_mask]

# Mostrar los datos permutados
print("Datos originales:", data)
print("Datos permutados:", permuted_data)

