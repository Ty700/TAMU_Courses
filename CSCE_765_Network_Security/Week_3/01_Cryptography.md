# Cryptography

## Etymology
- Secret (Crypt) Writing (Graphy)
- Study of mathematical techniques to achieve various goals in information security, such as confidentiality, authentication, integrity, non-repudiation, etc.
- Not the only means of providing network security, rather a subset of techniques.
- Quite an old field.

## Cast of Characters

### Communications parties:
- **Alice (A)** and **Bob (B)** - Honest communicators.

### Eavesdropping (Passive adversary):
- **Eve (E)**

### Man-in-the-Middle (Active adversary):
- **Mallory (M)**

### Trusted Third Party (TTP):
- **Trent (T)**

## Private Key/Public Key Cryptography

### Private Key:
- Sender and receiver share a common (private) key.
  - Encryption and Decryption are done using the private key.
  - Also called: conventional/shared-key/single-key/symmetric-key cryptography.

#### Example:
- Bob and Alice will have the same key. They will use this key to encrypt a message to send, and once received, they will use the same key to decrypt.

### Public Key:
- Every user has a private key and a public key.
  - Encryption is done using the public key, and Decryption using the private key.
  - Also called two-key/asymmetric-key cryptography.

## Common Terminologies

- **Plaintext**: The message(s) the parties are trying to exchange with each other.
- **Key**: Shared (Public key) or Private key.
- **Encrypt (Encipher)**: The action of making the plaintext become Ciphertext.
- **Ciphertext**: The result after working the plaintext through the encryption function with a key.
- **Decrypt**: The action of making Ciphertext back into plaintext.
- **Cipher**: The algorithm in which the encryption and decryption will use.
- **Cryptosystem**: Fundamental mathematical principle used to build a cipher.
- **Cryptanalysis**: The process of breaking the cipher.
- **Cryptology**: Combination of Cryptography and Cryptanalysis.

## Private Key Model

```plaintext
                            Secret Key shared                        Secret key shared
Plaintext                   by sender and recipient                  by sender and recipient
+========+                  +===============+                        +===============+
|  Hello | ------->         |               | ---> +============+ -> |               | --------> +==========+
+========+                  |               |      | *dXArrckQE |    |               |            |  Hello   |
                            |               |      | _%!SCAw    |    |               |            +==========+
                            +===============+      +============+    +===============+

Input                   Encryption algorithm   Transmitted         Decryption algorithm      Plaintext output
                        Example: DES             Ciphertext         (reverse of encryption 
                                                                      algorithm)
```

## Open vs Closed Design

Closed Design:

- Followed by military communication during the World Wars.
- Keep the cipher secret (sometimes referred to as "proprietary design").
- Bad practice: The adversary doesn’t know the algorithm used to encode the plaintext but may eventually find out.

Open Design:

- Kerckhoff’s Principle: Keep everything public except the key.
- Good practice: This is what is followed today.
- We can let attackers know how the algorithms work, but they don't have the key.
- Secrecy is maintained by keeping the key private.

Difference?

- Open vs closed source analogy: Open source tends to be more secure since there are more eyes on the algorithm.
- If the algorithm in a closed design is found, a new system must be made.
- In open design, if keys are leaked, parties can refresh the keys and continue using the same algorithm.
- Open design requires new keys for new people (e.g., a web server talking to billions of end-users), while a closed system may require an entirely new system.