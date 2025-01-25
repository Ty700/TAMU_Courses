### Instruction Set Architecture: Critical Interface

#### Properties of a Good Abstraction:
- **Portability:** Lasts through many generations, allowing code to work across different hardware versions.
- **Generality:** Used in various ways, ensuring that a good instruction set remains relevant across multiple applications.
- **Convenience:** Provides functionality that is frequently used at higher levels, such as basic operations like addition.
- **Efficiency:** Permits an efficient implementation at lower levels.

The Instruction set describes what the hardware can do for the software:
- It's a critical interface.
- The instruction set abstracts what the hardware does.
  - We get the functionality from the hardware and don't care how the functions are provided.

#### Levels of Representation:
    Levels of Representation 
        +============================+
        |High Level Language Program |           
        +============================+
        | Example:
        |       temp = v[k];
        |        v[k] = v[k+1];
        |        v[k+1] = temp;
        |    
        V Compiler
        +============================+
        | Assembly Language Program  |
        +============================+
        | Example:
        |   lw x1, 0(x2)
        |   lw x6, 4(x2)
        |   sw x6, 0(x2)
        |   sw x1, 4(x2)
        |
        V Assembler
        +============================+
        | Machine Language Program   |
        +============================+
        | Example:
        |   0000 1001 1100 0110 1010 1111 0101 1000
        |   1010 1111 0101 1000 0000 1001 1100 0110
        |   1100 0110 1010 1111 0101 1000 0000 1001
        |   0101 1000 0000 1001 1100 0110 1010 1111
        |
        V Machine Interpretation
        +===========================+
        | Control Signal Specifical |
        +===========================+
         Example:
            ALUOP[0:3] <= InstReg[9:11] & MASK 

### Instruction Set Architecture

**It Should Include:**
- **Organization of Programmable Storage**
- **Data Types and Data Structures:** Encodings and Representation
- **Instruction Formats**
- **Instruction (or Operation Code) Sets**
- **Modes of Addressing and Accessing Data Items and Instructions**
- **Exceptional Conditions**

### Organization
To provide functionality through the Instruction Set Architecture, the machine needs to be organized in a specific way:

**Capabilities and Performance Characteristics of Principal Functional Units:**
- Number of registers
- ALU
- Shifters
- Logic Units
- etc...

- **Ways in which these components are interconnected**
- **Information flows between components**
- **Logic and means by which such information flow is controlled**
- **Choreography of FUs to realize the ISA**
- **Register Transfer Level Description**

### Types of Internal Storage
The most critical factor in defining ISA is the type of internal storage the computer uses:

**Note:**
- **Inputs** -> Going into ALU
- **Outputs** -> Leaving from ALU

1. **Stack:**
    - **2 Inputs:**
        1. Popped from stack
        2. Popped from stack
    - **1 Output:**
        1. Pushed to the top of the stack  
    - **Example:**
        - `TOS <- TOS + next`
            - TOS -> TOP OF STACK 

2. **Accumulator:**
    - **2 Inputs:**
        1. Accumulator itself as it holds the sum of all the previous accumulated values
        2. Value from memory 
    - **1 Output:**
        1. Added to the accumulator register
    - **Example:**
        - `acc <- acc + mem[A]`
        - `acc <- acc + mem[A + next]`
        - The accumulator will continue to be added to/subtracted from.

3. **Register-Memory:**
    - **2 Inputs:**
        1. Register
        2. Memory
    - **1 Output:**
        1. Register
    - **Example:**
        - `EA(A) <- EA(A) + EA(B)`
        - `A` -> Register 1 Name
        - `B` -> Register 2 Name
        - The value of `EA(B)` is added to the `EA(A)` value, then read back into register `EA(A)`.

4. **Register-Register/Load-Store:**
    - **Focus more on this type**
    - **2 Inputs:**
        1. Register
        2. Register
    - **1 Output:**
        - Back into a register
    - **Example:**
        - `load Ra Rb          Ra <- mem[Rb]`
        - `store Ra Rb         mem[Rb] <- Ra`
        - **Load** -> Reading value from memory location `Rb` and writing it to register `Ra`.
        - **Store** -> Writing value of `Ra` into the memory location of `Rb`.

### Instruction Formats
**Variable vs Fixed Length Instruction Sets:**

- **Variable Length:**
    - Since we have a program counter that tells the start of the instruction, if we use variable length, we need to carry the length of the current instruction the PC is at.
    - When the PC is done fetching the current instruction, it will add the carried length to its current value, then go to the new address in the PC.
    - **Example:** Intel uses a variable-length instruction set.
    - Carrying instruction length is challenging.

- **Fixed Length:**
    - Simpler. The instruction will always be `X` bits in length, so there's no need to carry the length in the instruction.
    - Always add `X` bits to the PC, hop to that address after the PC is done fetching the instruction.
    - **Advantages/Disadvantages:**
        - Variable length is more complex.
        - Some instructions don't need all 32/64 bits. For example, a simple immediate add might only be 16 bits in size. We would have to fill in the other 16 bits with NO-OPs, wasting clock cycles.
        - However, fixed-length performance is better than variable as we won't waste time or make mistakes in reading and calculating the next PC address.
            - Fixed length is simple decoding with predictable operations.
