import numpy as np
import pickle

def m_height(vector):
    return np.sum(np.abs(vector))

def find_codeword_with_max_m_height(G, k):
    possible_vectors = np.array([list(map(int, f"{i:0{k}b}")) for i in range(2**k)])

    # Find the vector that produces the highest m-height
    max_m_height = -np.inf
    best_vector = None

    for vector in possible_vectors:
        codeword = np.dot(vector, G)
        height = m_height(codeword)

        # Check for valid numerical values
        if not np.any(np.isnan(codeword)) and not np.any(np.isinf(codeword)):
            if height > max_m_height:
                max_m_height = height
                best_vector = vector

    return best_vector

def clean_codeword(codeword):
    codeword = np.nan_to_num(codeword, nan=0.0, posinf=1e6, neginf=-1e6)
    return np.clip(codeword, -1e6, 1e6)

def main():
    with open("Task4GeneratorMatrices.pkl", "rb") as file:
        generator_matrices = pickle.load(file)

    task4_data = {}
    for key, value in generator_matrices.items():
        G = value["GeneratorMatrix"]
        k = value["k"]

        x = find_codeword_with_max_m_height(G, k)

        print(x)

        if x is not None:
            x = clean_codeword(x)
            task4_data[key] = x
        else:
            print(f"Warning: No valid codeword found for {key}. Setting as None.")
            task4_data[key] = None

    with open("Task4", "wb") as file:
        pickle.dump(task4_data, file)

    print("Task 4 completed successfully.")

if __name__ == "__main__":
    main()