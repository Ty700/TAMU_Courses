# Dynamic Programming

## Let's recall "Divide and Conquer" first 

- **Big Problem** is split into subproblems.
    - Subproblems are split into more subproblems if the solution is not clear.
        - Continue until we decompose the big problem into smaller problems so the solution is easier to see.
- Once we get to a level of a problem where the solution is "simple," we can then combine solutions up the tree.

### Visualization:

               Big Problem
             /              \  
            /                \
        Subproblem             Subproblem
        /         \           /          \
       /           \         /            \
    Subproblem  Subproblem Subproblem   Subproblem

- Going down the tree: Decomposing the problem.
- Going back up the tree: Combining the solutions of each subproblem to solve the big problem.

### Question:
- What happens if a subproblem has the same solution?

### Answer:
- In Divide and Conquer, we'd still have to compute it, as there is no memorization aspect of previous solutions.

## Dynamic Programming

### Difference: 
- The solution to a smaller problem can be used more than once by bigger problems.
- Dynamic Programming (DP) involves memorizing all the smaller solutions and reusing them if needed.
- This prevents computing the same answer twice, saving time and space complexity.

As a result, dynamic programming can be more efficient than "divide and conquer."

### Rod Cutting Problem 

**Input:**
- A rod of length `n`.
  - For `i = 1, 2, 3, ... n`, a rod of length `i` has price `P(i) >= 0`.

**Output:**
- How to cut the rod to maximize the total price?

- Which price is maximized? `P(1)`? `P(2)`? `P(3)`?

**Example:**

        n = 4 

        i | 1 | 2 | 3 | 4
        ------------------
      P(i)| 1 | 5 | 8 | 9

**Solution:**
- Cut it in half such that you have 2 rods of length 2, which can be sold for $5 each, resulting in $10.
- Leave it whole? $9.
- Cut it 3 and 1? $9.
- Cut it in half? 2 and 2? $10.

**Should we use exhaustive search?**
- No, the time complexity is too high: O(2^(n-1)).

### Rod Cutting Problem with DP 

- `R(i)` -> Maximum price for cutting a rod of length `i`. 

- No matter how you cut the rod, there must be a leftmost cut.

**Why is the left side `P(i)`?**
- We are not making any more cuts to it.
- Thus, it is assumed to be `P(i)`.
- However, for `R(i)`, we are either going to make more cuts, or not.

**Total Price = `P(i)` + `R(n-i)`**

**Question:**
- We do not know where the leftmost cut is.
- The leftmost piece might have length 1, 2, 3, 4, .... `n`.
  - Note: `n` being we don't cut it at all.

- Thus, we have to test each of these conditions and then pick the best one.

**Recursion:**
- `R(n) = max{P(i) + R(n-i)}` for `1 <= i <= n`. 

- `R(n)` -> Bigger Problem.
- `max{P(i) + R(n-1)}` -> Smaller Problem.

- The "Smaller solution" will be reused multiple times.

### Computing the Solution to the Rod Cutting Problem

- `R(0) = 0`
- `R(1) = P(1)`
- `R(2) = max{P(1) + R(1), P(2) + R(0)}`
- `R(3) = max{P(1) + R(2), P(2) + R(1), P(3) + R(0)}`
- `R(4) = max{P(1) + R(3), P(2) + R(2), P(3) + R(1), P(4) + R(0)}`
- `.`
- `.`
- `.`
- `R(n) = max{P(1) + R(n-1), P(2) + R(n-2), + P(3) + R(n-3), ... + P(n) + R(0)}`


- **NOTE:** See how we are using `P(1)`, `P(2)`, `P(3)`, `R(1)`, `R(2)`, `R(3)` again and again?
  - We don't want to recompute this every time; instead, we will memorize the solution to the problem so it's a plug-in from memory rather than computation.

- `R(n)` will be the maximum profit that can be made off a rod with length `n`.

- However, `R(n)` is not our entire solution... we need to know where to cut the rod.

**Example:**
- `R(10) = P(3) + R(7)` 
  - Then the leftmost cut is at length 3.

### Time Complexity of the Rod Cutting Problem 

**Review:**
- Time Complexity of an Algorithm:
  - How long it takes to run the algorithm as a function of the input size: `n`.
  - In addition to the input size, `n`, we have to always assume the worst case.

- Simplification:
  1. Every basic operation has a complexity of 1. 
  2. We consider only the order of the total number of basic operations.
    - This removes the factor of hardware.
    - One computer might be faster than the other.
  3. Worst case of input size `n`.

**Explanation of 2:**
- `n + 3n^2` -> `O(n^2)`
- `nlog(n) + n^3` -> `O(n^3)`
- `2^n + 100^(99)*n^2` -> `O(2^n)`

  - Why? As `n` -> +∞, the biggest order will majorly overrule the others.

### Time Complexity of the Rod Cutting Problem

- We can easily see that `R(n)` is the most complex problem in the worst case.
    
    `R(n) = max{P(1) + R(n-1), P(2) + R(n-2), + P(3) + R(n-3), ... + P(n) + R(0)}`


- Both of these values we have already computed already:
  - `P(1)` -> 1
  - `R(n-1)` -> 1
  - `P(1) + R(n-1)` -> 1

  - `P(2)` -> 1
  - `R(n-2)` -> 1
  - `P(2) + R(n-2)` -> 1

  - Pattern of 3 operations for each computation in `R(n)` to then compare them.

  - **Time Complexity:** `O(n^2)`

## Four Essential Steps for Presenting an Algorithm

1. **Explain the idea of your algorithm**
  - *Help us understand the main idea*.

2. **Pseudo-code of the algorithm**
  - *Show us exactly how computing is done*.

3. **Prove the correctness of your algorithm**
  - *Prove rigorously it always finds the right solution*.
    - Being a rigorous proof:
      1. Consider all possible cases.
        - The algorithm has to work in all possible cases, not just a few select cases.
      2. When going from step 1 -> step 2, there aren't any huge jumps.
        - The explanation needs to be easily followed.

4. **Analyze the time complexity of the algorithm**
  - *Show us it is efficient*.
