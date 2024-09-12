# Math Background
This is necessary to understand public key encryption

## Definition: Group
- Where G is a set and `.`: GxG -> G is said to be a group if the following properties are satisfied:
  1. **Closure**:
     - For any a, b are in the set G, then `a.b` is in G
  2. **Associativity**:
     - For any a, b, c in G `a.(b.c) = (a.b).c`
  3. **Identity**:
     - There is an identity element such that `a.e = e.a` for any a in G
  4. **Inverse**:
     - There exists an element `a^-1` for every a in G, such that `a.a^-1 = a^-1.a = e`

### Example:
- Set of all integers with respect to addition: (Z,+)
  - All four properties are satisfied:
    - **Closure**: a + b will equal another integer
    - **Associativity**: `(a+b)+c = a+(b+c)`
    - **Identity**: `A + 0 = A`
    - **Inverse**:

- Set of all integers with respect to multiplication (Z,*) - **not a group**
  - Doesn't satisfy **Inverse**:
    - Inverse: `A != A^(-3)`
      - A = 1
      - `1/3` is not an integer

- Set of all real numbers with respect to multiplication (R,*)
  - Satisfies all properties
    - Essentially covers the inverse since all real numbers

- Set of all integers with modulo m with respect to modular addition (Zm, "modular addition")
  - Modulo can only result in integers, thus is a valid set

### Multiplicative Inverses in Zm:
- 1 is the multiplicative identity in Zm
  - `x * 1 = x(mod(m)) = 1 * x(mod(x))`

- **Multiplicative Inverse** (`x * x^-1 = 1 mod(m)`)
  - Some, but not ALL elements have unique multiplicative inverses
  - In Z9: `3 * 0 = 0`, `3 * 1 = 3`, `3 * 2 = 6`, `3 * 3 = 0`, `3 * 4 = 3`, `3 * 5 = 6`, ..., so 3 does not have a multiplicative inverse (mod 9)
  - On the other hand, `4 * 2 = 8`, `4 * 3 = 3`, `4 * 4 = 7`, `4 * 5 = 2`, `4 * 6 = 1`, `4 * 7 = 1`, so `4^-1 = 7` (mod 9)

### Which numbers have inverses?
- In Zm, x has a multiplicative inverse **if and only if** x and m are relatively prime or `gcd(x,m) = 1`
  - Example: 4 in Z9

  - **Efficient algorithm** to compute inverses

## Modular Exponentiation
- Usual approach to computing `x^c mod n` is inefficient when c is really large
- **Efficient algorithm**: Square and multiply

## Euler's Totient Function
- Given positive integer n, Euler's totient function is the number of positive numbers less than n that are relatively prime to n
- **Fact**:
  - If p is prime then:
    - `{1,2,3,...,p-1}` are relatively prime to p
- **Fact**:
  - If p and q are prime and `n=pq` then:
    - Euler's totient = `(p-1)(q-1)`
  
  - Each number that is not divisible by p or by q is relatively prime to pq
    - **Example**:
      - p = 5 and q = 7
        - `{1,2,3,4,6,8,9,11,12,13,16,17,18,19,22}...`

## Euler's Theorem and Fermat's Theorem
- If a is relatively prime to n then:
  - `a^(Euler's totient) = 1 mod n`

- If a is relatively prime to p then:
  - `a^(p-1) = 1 mod p`
