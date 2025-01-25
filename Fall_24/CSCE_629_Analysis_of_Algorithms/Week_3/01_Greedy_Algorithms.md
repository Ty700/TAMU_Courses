## Greedy Algorithms

### 1. Definition:
- **Greedy Algorithm**: A technique where at each step, a locally optimal choice (greedy choice) is made with the hope that these choices will lead to a globally optimal solution.
  
### Comparison between "Dynamic Programming" and "Greedy Programming":

#### Dynamic Programming:
- **Decompose** a big problem into smaller problems.
- **Bottom-up** approach: solve subproblems first, then combine them for the overall solution.

#### Greedy Algorithms:
- **Make a sequence of greedy (locally optimal) choices** to reach a solution.
- Typically, more **efficient** than dynamic programming.

---

### 2. Understanding "Greedy Algorithm" by solving the "Activity Selection Problem":

#### 2.1 Definition: The "Activity Selection Problem"
- **Input**: A set of `n` activities \( A_1, A_2, \dots, A_n \), each with a start time \( S_i \) and a finish time \( F_i \).
- **Output**: A maximum subset of activities that are compatible in time (i.e., no two selected activities overlap).

- **Example**: 
  - Suppose we have one classroom and multiple people want to use it for various time slots.
  - The goal is to schedule the maximum number of non-overlapping activities.

#### Compatible in time:
- Mathematically, the time interval for activity \( A_i \) is \( [S_i, F_i) \) where:
  - The start time \( S_i \) is inclusive.
  - The finish time \( F_i \) is exclusive.

#### Assumption:
- The activities are **sorted by their finish time**: 
  \[
  F_1 \leq F_2 \leq \dots \leq F_n
  \]
- If the activities aren't sorted, sorting them by finish time will take \( O(n\log n) \) time.

---

#### 2.2 Greedy Algorithm for Activity Selection

**The Idea**:
1. **Pick the activity that finishes first**.
   - In the example, we pick \( A_1 \) because it finishes at time 4.
   
2. **Pick as many compatible activities as possible** with the chosen activity.
   - In this case, after selecting \( A_1 \), look for activities that start after \( A_1 \) finishes.

#### Features of the Greedy Algorithm:
1. **Greedy choice property**: By selecting an activity, the problem size reduces.
2. **Optimal substructure**: Once a greedy choice is made, the remaining problem is similar in structure.

#### Example:
For the activities with start and finish times:

| i | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 11 |
|---|---|---|---|---|---|---|---|---|---|----|----|
| \( S_i \) | 1 | 3 | 0 | 5 | 3 | 5 | 6 | 8 | 8 | 2 | 12 |
| \( F_i \) | 4 | 5 | 6 | 7 | 9 | 9 | 10 | 11 | 12 | 14 | 16 |

- **Subset of size 3**: One solution could be \( A_1, A_4, A_8 \).
- **Optimal solution**: The largest subset of compatible activities is 4, such as \( A_1, A_4, A_8, A_{11} \).

#### 2.3 Greedy Algorithm Psuedo-code:
```plaintext
        - We have to be careful to avoid a time complexity of n^2 
        - Since we are selecting one activity, then going over a smaller subset of activities, selecting one, then going over the smaller subset again until subset size is 0...
            - This is O(n^2)
        - This complexity is unreasonably high, since there is a way we can do this in O(n)

        Psuedocode:
            (This Psuedocode only scans every element once, thus O(n))

            Greedy-Activity-Selector(s,f,n):
                A = {A1}
                k = 1 -> Here k is the index of the last selected (right most) activity 
                for m = 2 to n 
                    if Sm >= Fk -> If the start of the mth element is greater than or equal to the finish of the last selected activity 
                        A = A U {Am} -> Add the mth activity to the result set (A)
                        k = m   -> Now, update k to be the m. Thus we won't have to repeat elements. We will start at the m + 1 element and check the start times 
                return A 

        Using the example from earlier:
            The algorithm will select A1 first. 

            A2: 
                - Then it will compare A1 end time with the start time of A2
                    - A2 start time is not >= A1's finish time
                        - Thus it goes to A3 

            A3: 
                - Then it will compare A1's end time with the start of A3 
                    - A3's start time is not >= A1's finish time
                        - Thus it will go to A4 

            A4:
                - A4's start time is in fact greater than A1's finish time...
                    - A4 will be added to the result A 
                    - K is updated to be 4 
                        - 
                - Then it will compare A1's end time with the start of A3 
                    - A3's start time is not >= A1's finish time
                        - Thus it will go to A4 

            A4:
                - A4's start time is in fact greater than A1's finish time...
                    - A4 will be added to the result A 
                    - K is updated to be 4 
                        - Thus it will check the end time of 4 (A4)
                    - It goes to A5 

                    Final result looks like: {A1, A4} as of now

                    We might think:
                        Wait a minute, after A1 is choosen, we want to look at the other activites and choose the activity that is compatible with A1 AND ends first

                        Thus, we need to remember we are assuming this list is already sorted by finish times. And A1 will finish sooner or at the same time as A2.

                        Thus, A5 WILL BE the FIRST activity that is compatible with A1 AND the activity that finishes first 
            A5:
                - A5's start time is not compatible with A4's end time 
            
            A6:
                - A6's start time is not compatible with A4's end time 

            A7: 
                - A7's start time is not compatible with A4's end time 

            A8:
                - A4's end time is >= A8's start time
                    - A8 is added to final result subset:
                        A = {A1, A4, A8}
                - k is now updated to 8
                
            A9:
                - A9's start time is not compatible with A8's end time 
            
            A10:
                - A10's start time is not compatible with A9's end time 
        
            A11:
                - A8's end time is >= A11's start time 
                - A11 is added to the final result subset:
                    A = {A1, A4, A8, A11}
                - k is now 11 

            A11 is the last in the list, thus it will return A 
```

#### Time Complexity 
```plaintext

        Greedy-Activity-Selection(s,f,n):
            A = {A1}                 -> O(1)
            k = 1                    -> O(1)
            for m = 2 to n:          -> O(n)
                if Sm >= Fk: <-----+
                    A = A U {Am}   | -> O(1)
                    k = m    <-----+
            
            Return A 

            Thus, this algorithm is O(n)
                - Makes sense since we have to scan over entire set to determine whether we add them to the result or not
```