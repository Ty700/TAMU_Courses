# Private Key Encryption Functions

1. **KeyGen**: `K = KeyGen(I)` 
    - `I` is a security parameter (e.g., the length of the key).
    - Random: Each time this is run, a new key is generated.

2. **Enc**: `C = Enc(K, M)`
    - `M` = Message
    - `K` = Key generated from earlier.
    - Output is a garbage message that a sender will send out.
    - **Enc** needs to be random. Even if the inputs are the same (`K` and `M`), a different ciphertext will be generated.

3. **Dec**: `M = Dec(K, C)`
    - `C` = Ciphertext.
    - `K` = Key generated from earlier.
    - **Not random**: When given the same parameters (`K` and `C`), it will always result in the same message.

### Correctness Property
- The encryption scheme has a **Correctness Property** if, when you encrypt a message `M` with key `K` to produce ciphertext `C`, you can decrypt `C` with the same key `K` to recover the original message `M`.

---

## Goals of the Attacker

1. **Learn the plaintext** corresponding to a given ciphertext – One-Way Security.
2. **Extract the key** – Key Recovery Security.
3. **Learn some information** about the plaintext corresponding to a given ciphertext – Semantic Security.
   - **Example**:
     - FBI eavesdropping on a conversation.
     - Terrorists say they are going to bomb the FBI.
     - FBI wants to know when, so they target that information rather than the entire message.

> **Note**: Key recovery security and one-way security are essential for an encryption scheme. Semantic security is ideal.

---

## Capabilities of the Attacker

1. **No information**:
   - The attacker only knows the algorithm.
   - Blindly trying to break the encryption.

2. **Ciphertext Only**:
   - The adversary knows only the ciphertext.
   - This can be easily obtained through eavesdropping on a network.

3. **Known Plaintext Attack**:
   - The adversary knows a set of plaintext-ciphertext pairs (`P, C`).
   - They try to use these pairs to break the encryption.
     - **Example**: The FBI eavesdrop on terrorists' communications. Later, the FBI can deduce that the messages they intercepted discuss plans for bombings after the event happens.

4. **Chosen (and adaptively chosen) Plaintext Attack (CPA attack)**:
   - The adversary selects plaintexts and obtains the corresponding ciphertexts.
   - The attacker has access to the encryption machine but cannot extract the key.
   - They can feed plaintext into the machine as many times as they want to gain information for breaking the encryption.

5. **Chosen (and adaptively chosen) Ciphertext Attack (CCA attack)**:
   - The adversary selects ciphertexts and obtains the corresponding plaintexts.
   - The attacker doesn’t have access to the encryption machine but does have access to the decryption machine.
   - They can submit ciphertexts and receive the corresponding plaintexts.
   - The attacker does not know the key or scheme but can use the ciphertext-to-plaintext process to break the encryption.

> **Note**: 
> - 1 = least attacker capability, 5 = most attacker capability.

## Security Model
```
    Least Attacker capability           Most attacker capability
                        1 < 2 < 3 < 4 < 5
    Weakest Cryptosystem                Strongest Cryptosystem
```
- A cryptosystem secure against attack level 5 is the **strongest**.
- A cryptosystem secure against attack level 1 is the **weakest**.
- A system secure against 5 is automatically secure against 4, 3, 2, and 1.

---

## Brute Force Attacks

- Since the key space is finite, given a pair (or more) of plaintext and ciphertext, a cryptanalyst can attempt every possible key.
- For this attack to be infeasible, the key space should be large.

  - **How large?**:
    - At least **80 bits** – this would take an extremely long time to decipher.
    - Ideally **128 bits minimum** – this would take tens of years to decipher.

