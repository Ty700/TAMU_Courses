# Public Key Crypto Overview
## Private Key:
- Sender and receiver share a common (private) key
  - Encryption and Decryption are done using the private key  
  - Also known as:
    - Symmetric Key
    - Shared Key
    - Single-key
  
- **Good**: Quite efficient  
- **Bad**: Key distribution and management is a serious problem

## Public Key:
- Every user has a private key and a public key
  - Encryption is done using the public key and Decryption is done using the private key
  - Also known as:
    - Asymmetric Key
    - Two-key
  
- **Good**: Key management problem potentially simpler  
- **Bad**: Much slower than private key crypto

# Public Key Encryption
## Two Keys:
- Public encryption key: `e`
- Private decryption key: `d`
  
- Encryption easy when `e` is known  
- Decryption easy when `d` is known  
- Decryption hard when `d` is **NOT KNOWN**

## Security Notions
- Very similar to what we studied for private key encryption  
  - **What's the difference?**
    - Adversary has access to the public key
    - Adversary can create encryptions on its own
      - Can't decrypt since they don't have a private key
      - Want to protect against CPA since attacker can generate ciphers from known plaintexts
