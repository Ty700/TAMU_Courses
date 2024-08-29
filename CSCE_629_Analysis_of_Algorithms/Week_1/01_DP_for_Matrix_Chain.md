### Understanding Dynamic Programming (DP) through the "Matrix Chain Multiplication Problem"

#### 4.1 Define the "Matrix Chain Multiplication Problem"

##### Review of Matrix Multiplication
Consider two matrices:

Matrix \( M_1 \) (2x3):
\[
\begin{bmatrix}
1 & 2 & 3 \\
4 & 5 & 6 
\end{bmatrix}
\]

Matrix \( M_2 \) (3x4):
\[
\begin{bmatrix}
0 & 1 & 2 & 1 \\
3 & 5 & 1 & 2 \\
6 & 2 & 8 & 0 
\end{bmatrix}
\]

Since the number of columns in \( M_1 \) equals the number of rows in \( M_2 \), they can be multiplied. The result will be a 2x4 matrix:

\[
\begin{bmatrix}
24 & 17 & 28 & 5 \\
51 & 41 & 61 & 14 
\end{bmatrix}
\]

##### Cost of Multiplying Two Matrices
The cost of multiplying two matrices depends on their dimensions:

- Let \( p \) be the number of rows in \( M_1 \).
- Let \( q \) be the number of columns in \( M_1 \) (which is also the number of rows in \( M_2 \)).
- Let \( r \) be the number of columns in \( M_2 \).

The time complexity for computing the multiplication is \( O(p \times q \times r) \).

###### Example:
- \( A \) is a 10x100 matrix.
- \( B \) is a 100x5 matrix.
- \( C \) is a 5x50 matrix.

Two possible multiplication orders:

1. \( (A \times B) \times C \):
   - \( A \times B \) costs \( 10 \times 100 \times 5 = 5000 \) operations.
   - Result is a 10x5 matrix.
   - \( D \times C \) costs \( 10 \times 5 \times 50 = 2500 \) operations.
   - Total: 7,500 operations.

2. \( A \times (B \times C) \):
   - \( B \times C \) costs \( 100 \times 5 \times 50 = 25,000 \) operations.
   - Result is a 100x50 matrix.
   - \( A \times D \) costs \( 10 \times 100 \times 50 = 50,000 \) operations.
   - Total: 75,000 operations.

Clearly, the first approach is 10x less expensive.

##### Matrix Chain Multiplication
Given a chain of \( n \) matrices \( A_1, A_2, \ldots, A_n \), each matrix \( A_i \) has dimensions \( p_{i-1} \times p_i \). The problem is to find the optimal way to parenthesize the matrix chain to minimize the total multiplication cost.

###### Example Chain:
- \( A_1: 0 \times 1 \)
- \( A_2: 1 \times 2 \)
- \( A_3: 2 \times 3 \)
- \( \ldots \)
- \( A_n: (n-1) \times n \)

Exhaustive search would be computationally expensive, leading to \( 2^{(n/3)} \) computations. Thus, a better approach is needed.

#### 4.2 Use Recursion to Decompose the Problem
For \( 1 \leq i \leq j \leq n \), let \( m[i,j] \) represent the minimum cost of computing the sub-chain \( A_i A_{i+1} \ldots A_j \).

No matter the order of multiplication, the final step will always involve multiplying two matrices. The total cost for multiplying two sub-chains is:

\[
\text{Total cost} = m[i,k] + m[k+1,j] + (p_{i-1} \times p_k \times p_j)
\]

The recursive equation for the minimum cost is:

\[
m[i,j] = 
\begin{cases} 
0 & \text{if } i = j \\
\min_{i \leq k < j} \{ m[i,k] + m[k+1,j] + (p_{i-1} \times p_k \times p_j) \} & \text{if } i < j 
\end{cases}
\]

#### 4.3 Use Recursion to Compute the Result
In dynamic programming (DP), we decompose the big problem into smaller ones (top-down), and then compute the solutions from smaller to larger problems (bottom-up).

##### Example:
- Sub-chains of length 1: \( m[1,1], m[2,2], \ldots, m[n,n] \) require 0 computations.
- Sub-chains of length 2: \( m[1,2], m[2,3], \ldots, m[n-1,n] \).
- Sub-chains of length 3: \( m[1,3], m[2,4], \ldots, m[n-2,n] \).

Continue until you reach sub-chains of length \( n \), i.e., \( m[1,n] \).

#### 4.4 Time Complexity of this Algorithm
The main part of the algorithm involves computing the recursion:

\[
\min_{i \leq k < j} \{ m[i,k] + m[k+1,j] + (p_{i-1} \times p_k \times p_j) \}
\]

The time complexity for computing each \( m[i,j] \) is \( O(n) \), and there are \( O(n^2) \) such \( m[i,j] \), resulting in a total time complexity of \( O(n^3) \).
