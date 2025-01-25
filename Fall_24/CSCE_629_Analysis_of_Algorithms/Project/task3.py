import numpy as np
import pickle as p

def generate_ranked_matrix(rows=0, cols=0, min_val=0, max_val=0):
    """
    Generate a matrix of specified dimensions with the given rank.
    """
    while True:
        matrix = np.random.randint(min_val, max_val + 1, (rows, cols))
        if np.linalg.matrix_rank(matrix) == rows:
            return matrix

def main():
    # Min and Max Values allowed in matrices
    __MIN_VALUE = -100000
    __MAX_VALUE = 100000

    # G*1 Parameters
    __G_STAR_1_ROWS = 5
    __G_STAR_1_COLS = 11

    # G*2 Parameters
    __G_STAR_2_ROWS = 6
    __G_STAR_2_COLS = 11

    # File Generated Name
    __FILE_NAME = "Task3"

    # Generate matrices G*1 and G*2
    G_star_1 = generate_ranked_matrix(__G_STAR_1_ROWS, __G_STAR_1_COLS, __MIN_VALUE, __MAX_VALUE)
    G_star_2 = generate_ranked_matrix(__G_STAR_2_ROWS, __G_STAR_2_COLS, __MIN_VALUE, __MAX_VALUE)

    # Store matrices in a dictionary
    generator_matrices = {
        "setting1": G_star_1,
        "setting2": G_star_2
    }

    with open(__FILE_NAME, 'wb') as file:
        p.dump(generator_matrices, file)

    print("Matrices generated and saved as 'Task3'.")
    
    # with open(__FILE_NAME, 'rb') as file:
    #     task3_data = p.load(file)
    #     print("G*1:\n", task3_data["setting1"])
    #     print("G*2:\n", task3_data["setting2"])

if __name__ == "__main__":
    main()