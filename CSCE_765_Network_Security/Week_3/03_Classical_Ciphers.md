# Classical Ciphers

Classical ciphers can be categorized into two types:

1. **Substitution Ciphers**:
   - In this type, each letter of the plaintext is substituted with another letter.
   
2. **Transposition Ciphers**:
   - The plaintext letters are rearranged or transposed to create a cipher.

### Examples:
- **Caesar's Cipher**
- **Vigenère Cipher**

> **Note**: All classical ciphers are **insecure** due to the ability to perform language characteristic analysis on them.

---

# One-Time Pad or Vernam Cipher

- In this cipher, the **plaintext** is represented as a binary string, and the **key** is a binary string of the same length.
- Encryption is performed using a simple **XOR** operation.

### Example:

| Plaintext | 01010000010001010011 |
| --------- | -------------------- |
| Key       | 11010101001001100111 |
| Ciphertext| 10000101011000110100 |

### Perfect Secrecy
- If the key is **random** and **never reused**, the system offers **unconditional security** – also known as **perfect secrecy**.
    - The ciphertext gives **no clues** about the original plaintext.

- **Intuitive Explanation of Perfect Secrecy**:
    - Given any pair of plaintext and ciphertext, there exists a key that maps the selected plaintext to the selected ciphertext. This means that, given a ciphertext, we gain no information about what key or plaintext could have been used.

### Challenges:
- **Random Bit-Strings**: How do we obtain random bit-strings for shared secret keys as long as the messages and ensure they are never reused?

### Practical Issues:
- **Key Size**:
    - If you're sending a 2GB file, you need a 2GB key.
    - If you send another file, you need a **new** 2GB key.

- **Non-Reusable Key**: The key cannot be reused for another message, making the system impractical for large-scale use.

