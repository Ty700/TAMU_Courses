import numpy as np
import pickle as p

def generate_ranked_matrix(rows=0, cols=0, min_val=0, max_val=0):

    while True:
        matrix = np.random.randint(min_val, max_val + 1, (rows, cols))
        if np.linalg.matrix_rank(matrix) == rows:
            return matrix

def main():
    # Min and Max Values allowed in matricies
    __MIN_VALUE = -100000
    __MAX_VALUE = 100000

    #G1 Parameters
    __G1_ROWS = 5
    __G1_COLS = 11

    #G2 Parameters
    __G2_ROWS = 6
    __G2_COLS = 11

    #File Generated Name
    __FILE_NAME = "Task1"

    G1 = generate_ranked_matrix(__G1_ROWS, __G1_COLS, __MIN_VALUE, __MAX_VALUE)
    G2 = generate_ranked_matrix(__G2_ROWS, __G2_COLS, __MIN_VALUE, __MAX_VALUE)

    generator_matrices = {
        "setting1": G1,
        "setting2": G2
    }

    # Writes generated matricies to the file
    with open(__FILE_NAME, 'wb') as file:
        p.dump(generator_matrices, file)
        # print("G1\n")
        # print(G1)
        # print('-'*50)
        # print("G2\n")
        # print(G2)
        # print('-'*50)
    print("Matrices generated and saved as 'Task1'.")

    # Test to see if file is being written correctly
    # with open(__FILE_NAME, 'rb') as file:
    #     try:
    #         task1_data = p.load(file)

    #         G1 = task1_data["setting1"]
    #         G2 = task1_data["setting2"]

    #         print("G1\n")
    #         print(np.array(G1))
    #         print('-'*50)
    #         print("G2\n")
    #         print(np.array(G2))

    #     except FileNotFoundError:
    #         print(f"'{file}' can't be found.\n")
        
    #     except Exception as e:
    #         print(f"File Found. Error Exists: {e}")


if __name__ == "__main__":
    main()