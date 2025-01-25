## Block Cipher Encryption Modes

### Key Modes:
- **Electronic Code Block (ECB)**
- **Cipher Block Chaining (CBC)** — Most popular
- Other modes (not covered):
    - Cipher Feedback (CFB)
    - Output Feedback (OFB)

---

### Analysis:
We will analyze **ECB** and **CBC**.

---

### Electronic Code Block (ECB) Mode:
- **How it works**: Although DES encrypts 64 bits (a block) at a time, it can encrypt a long message (file) in ECB mode. 
  - **Example**: Say we are sending a 128-bit file, we split it into two blocks and encrypt both using the same algorithm and key.
- **Deterministic**: If the same key is used, identical plaintext blocks map to identical ciphertext.
  - **Problem**: Encrypting the same plaintext always produces the same ciphertext—this is insecure.
- **Efficient**, but does not offer strong security.
- **Transmission errors**: If one block is corrupted during transmission, only that block is affected, not the entire file.

---

### Cipher Block Chaining (CBC) Mode:
- **Goal**: Improve upon ECB by introducing randomness so identical plaintext blocks produce different ciphertext.
- **Initialization Vector (IV)**: CBC uses a random IV for the first block of plaintext and XORs it with the plaintext before encryption.
  - Only the first IV is randomly generated and sent with the ciphertext. Subsequent IVs are derived from the ciphertext of the previous block.
- **Decryption Process**: The ciphertext is decrypted block-by-block and XORed with the previous block’s ciphertext (or the IV for the first block).
  
#### Equations:
- \( C(0) = IV \)
- \( C(i) = \text{Encrypt(Key)}(\text{Plaintext}(i) \oplus C(i-1)) \)
- \( P(i) = C(i-1) \oplus \text{Decrypt(Key)}(C(i)) \)

#### CBC Traits:
- **Randomized encryption** due to the IV.
- **IV**: A random value, not secret, and sent with the ciphertext.
- **Encryption cannot be parallelized**, so it's slower than ECB.
- **Transmission errors**: Since ciphertext from one block affects the next, transmission errors propagate.

---

### Summary:
- **ECB**: 
  - **Insecure**, especially against eavesdropping and known plaintext attacks.
  - Efficient but lacks security.
- **CBC**: 
  - **Secure against chosen plaintext attacks (CPA)**, assuming strong encryption like AES or 3DES.
  - **Not secure against chosen ciphertext attacks (CCA)**.
  - CCA security can be achieved by preventing "massaging" of ciphertext through integrity protection mechanisms such as **Message Authentication Codes (MACs)**.

#### Improving CBC Security:
- Use **MACs** alongside CBC:
  - The ciphertext is generated using CBC, and a MAC is applied to the ciphertext.
  - The recipient only decrypts if the MAC is valid.
