import pickle
import numpy as np 

with open("Task4", "rb") as file:
    generator_matrices = pickle.load(file)

    for key, value in generator_matrices.items():
        print(f'Matrix {key} | Codeword: {value}')