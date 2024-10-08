
# Understanding DP by solving the "Longest Common Subsequence Problem"

### 5.1 Define the "Longest Common Subsequence Problem"
```plaintext
    Consider two DNA sequences:
        S1 = ACCGGTCGAGTGCGCGGAAGCCGGCCGAA
        S2 = GTCGTTCGGAATGCCGTTGCTCTGTAAA

    How similar are they? How to define "similarity"?

    Similarity 
        A few possible ways to define similarity

        1. S1 and S2 have a common Subsequence
                                0123456789ABCDEFGHIJ
            S1 and S2 both have GTCGTCGGAAGCCGGCCGAA    
            
                      0123    4   56    789ABCDEFGHIJ
            S1 = ACCG GTCG AG T G CG CG GAAGCCGGCCGAA
            
                 01234   56789   ABCD    EF   G   H   IJ
            S2 = GTCGT T CGGAA T GCCG TT GC T C T G T AA A

        The longer a common subsequence they have, the more "similar" they are.

    Definition of "Subsequence":
        - A subsequence of a given sequence is just the given sequence with 0 or more elements removed.

        Example:
                   0 1   2   3
            X = {A,B,C,B,D,A,B}
                 0 1 2 3
            Z = {B,C,D,B}

            Z is a subsequence of X b/c BCDB shows us in X in the same order
            
    Definition of "Common Subsequence"
        - Given two subsequences X and Y, we say that a sequence Z is a common subsequence of X and Y if Z is a subsequence of both X and Y.
               3 2 1   0
        X = {A,B,C,B,D,A,B}
               0 1     2

        Y = {B,D,C,A,B,A}

        See the numbering?

        Common subsequence: {B,C,A} 
        Is this the longest? No. 

        There is another common subsequence: {B,C,B,A}

        Longest Common Subsequence (LCS) 
            {B,D,A,B} and {B,C,B,A} are these sequences LCS 
```
### LCS Problem
```plaintext
    Input: Two sequences X = {X1, X2, ..., Xn} and Y = {Y1, Y2, ..., Ym}

    Output: A LCS of X and Y -> {Z1, Z2, ..., Zk} 

    Exhaustive search would take exponential time beacuse X has 2^n and Y has 2^m subsequences

    Let's consider how to decompose the big problem into smaller problems 
        - Longer sequences -> Bigger problem 
        - Smaller sequences -> Smaller problem 

    Question: Can we find the longest common subsequences for long sequences by utilizing a longest common subsequence for shorter subsequences

    Definition of "Prefix":
        Given a sequence X = (x1, x2, ..., xm), we define the i-th prefix of X to be 1, 2, ..., m 

        Example:
            X = {A,B,C,B,D,A,B}

            then:
                X0 = {}
                X1 = {A}
                X2 = {A, B}
                X3 = {A,B,C}
                X4 = {A,B,C,B}
                X5 = {A,B,C,B,D}
                X6 = {A,B,C,B,D,A}
                X7 = {A,B,C,B,D,A,B}

    Theorm: (Optimal substructure of an LCS)
        Let X = (X1, X2, ..., Xm) and Y = (Y1, Y2, ..., Yn) be sequences, and let Z = (Z1, Z2, ..., Zk) be any LCS of X and Y 
        
        Then the following properties must hold:
            1. If Xn = Ym, then Zk = Xn = Ym and Zk-1 is an LCS of Xm-1 and Yn-1
                In other words, if last element in X is the same as element of Y, then Xn/Ym must be the last element in the subsequence 
                and Z(k-1) is an LCS of X(m-1) and Y(n-1)

                Proof by contradiction: 
                        X:  X1, X2, ..., Xi, ..., Xi,2, ..., Xi,k, ... Xm-1, Xm 
                                         / \       / \        / \
                                          |         |          |
                        Z:               Z1,       Z2,  ...,  Zk
                                          |         |          |
                                          V         V          V
                        Y:  Y1, Y2, ..., Yj,1, ..., Yj,2 ..., Yj,k, ..., Yn-1, Yn
                    Xm = Yn 

                    Since Zk does not equal Xm and Yn, then there must be another subsequence that is of size k + 1 

                    X:  X1, X2, ..., Xi, ..., Xi,2, ..., Xi,k, ... Xm-1, Xm 
                                        / \       / \        / \         / \
                                        |         |          |            |
                    Z:               Z1,       Z2,  ...,  Zk,           Zk+1
                                        |         |          |            |
                                        V         V          V            V
                    Y:  Y1, Y2, ..., Yj,1, ..., Yj,2 ..., Yj,k, ..., Yn-1, Yn

                    It's a contradiction since we said Zk is the LCS... but clearly Zk+1 exists.

                    Thus Zk has to be the same as Xn and Ym if Ym = Xn
            
                Since we know the first part is true... let's look at the second part: 
                    "Zk-1 is an LCS of Xm-1 and Yn-1"


                    X:  X1, X2, ..., Xi, ..., Xi,2, ...,   Xi,k, ... Xm-1, Xm 
                                        / \       / \       / \         / \
                                        |         |          |            |
                    Z:               Z1,       Z2,  ...,  Zk-1,          Zk
                                        |         |          |            |
                                        V         V          V            V
                    Y:  Y1, Y2, ..., Yj,1, ..., Yj,2 ..., Yj,k, ..., Yn-1, Yn

                    So: Zk-1 is an LCS of Xm-1 and Yn-1
            
            2. If Xm != Yn and Zk != Xm, then Z is an LCS of Xm-1 and Y
                If Zk != Xm and Xm != Yn, then Zk must equal 


                X:  X1, X2, ..., Xi, ..., Xi,2, ...,   Xi,k, ... Xm-1, Xm 
                                    / \       / \       / \         
                                    |         |          |            
                Z:               Z1,       Z2,  ...,    Zk
                                    |         |          |            
                                    V         V          V            
                Y:  Y1, Y2, ..., Yj,1, ..., Yj,2 ..., Yj,k, ..., Yn-1, Yn

            3. If Xm != Yn and Zk != Yn, then Z is an LCS of X and Yn-1
                - Proved by symmetry with 2.

            Define the optimal cost of a sub-problem:
                Let's define c[i,j] to be the length of an LCS of the sequence Xi and Yj 

                1 <= i <= n 
                1 <= j <= j

            If we take subsequences of length i from X, and j from Y, then that subsequence will have c[i,j] elements 
                - c[i,j] = length of the LCS 
            
                        {  
                            0,              if i = 0 or j = 0
                            c[i-1, j-1] + 1, if i,j > 0 and x = y -> 1.
            c[i,j] =        max{c[i,j-1], c[i-1,j]} if i, j > 0 and Xi != Yj -> 2. and 3.
                        }
                        Our goal: compute c[m,n]

This professor makes absoulte no sense in the explanations... Watching the lecture multiple times without understanding. Going to try and just read the textbook to understand :/
```