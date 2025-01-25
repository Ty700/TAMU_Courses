import numpy as np
import pickle

def m_height(codeword, m):
    """
    Calculate the m-height of a codeword.
    Args:
        codeword (np.ndarray): The codeword to process.
        m (int): Parameter for m-height calculation.
    Returns:
        float: The calculated m-height.
    """
    sorted_vals = np.sort(codeword)
    return sorted_vals[-m] - sorted_vals[m-1]

def find_optimal_x(generator_matrix, m, iterations=5000, bounds=(-10, 10)):
    """
    Find the vector x that maximizes the m-height of the codeword.
    Args:
        generator_matrix (np.ndarray): The generator matrix (k x n).
        m (int): Parameter for m-height calculation.
        iterations (int): Number of random samples to try.
        bounds (tuple): Range for generating random x values.
    Returns:
        np.ndarray: The vector x that maximizes m-height.
    """
    k, n = generator_matrix.shape
    best_x = None
    max_m_height = -np.inf

    for _ in range(iterations):
        x = np.random.uniform(bounds[0], bounds[1], size=k)
        c = np.dot(x, generator_matrix)
        height = m_height(c, m)

        if height > max_m_height:
            max_m_height = height
            best_x = x

    return best_x

def main():
    # File paths
    input_file = "Task2GeneratorMatrices.pkl"
    output_file = "Task2Results.pkl"

    # Load data
    try:
        with open(input_file, "rb") as file:
            data = pickle.load(file)
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")
        return

    results = {}

    # Process each generator matrix
    for key, value in data.items():
        n = value["n"]
        k = value["k"]
        m = value["m"]
        G = value["GeneratorMatrix"]

        # Validate generator matrix
        if not isinstance(G, np.ndarray) or G.ndim != 2 or G.shape != (k, n):
            print(f"Skipping {key}: Invalid generator matrix.")
            continue

        formatted_key = str(key).zfill(3)
        print(f"Processing Matrix {formatted_key}: n={n}, k={k}, m={m} | ", end="")

        # Find the optimal x
        try:
            x_optimal = find_optimal_x(G, m)
            results[key] = x_optimal
            print(f"x_optimal={x_optimal}")
        except Exception as e:
            print(f"Error processing {formatted_key}: {e}")
            continue

    # Save results
    with open(output_file, "wb") as file:
        pickle.dump(results, file)

    print(f"Task 2 completed. Results saved to '{output_file}'.")

if __name__ == "__main__":
    main()
