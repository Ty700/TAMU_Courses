# RISC-V ISA Overview

We will discuss what is RISC-V ISA, which will be used throughout the remainder of the semester.

## Review: Load/Store Architectures

- No memory reference per ALU instruction
  - 3 address general-purpose registers (GPR)
- Register to register arithmetic
- Load and store with simple addressing modes (reg + immediate)
- Simple conditionals
  - Compare ops -> if true, branch
  - Compare & branch
  - Condition code + branch on condition
- Simple fixed-format encoding

### Jump:
    op | offset

### Immediate:
    op | r | r | immediate value 

### Forgot:
    op | r | r | blank

## Instruction Set Architecture (ISA)

- **Class of ISA:**
  - The most critical feature of instruction set architecture is the internal storage.
  - General-purpose registers.
  - Register-memory vs load-store (register-register).

### RISC-V Registers

- 32 GPRs and 32 FP registers.

### RISC-V Register Table

| Register | Name | Usage | Saver |
|----------|------|-------|-------|
| x0 | Zero | Constant 0 | N/A |
| x1 | ra | Return address | Caller |
| x2 | sp | Stack pointer | Callee |
| x3 | gp | Global pointer | N/A |
| x4 | tp | Thread pointer | N/A |
| x5-x7 | t0-t2 | Temps | Caller |
| x8 | s0/fp | Saved/frame pointer | Callee |
| x9 | s1 | Saved | Callee |
| x10-x17 | a0-a7 | Arguments | Caller |
| x18-x27 | s2-s11 | Saved | Callee |
| x28-x31 | t3-t6 | Temps | Caller |
| f0-f7 | ft0-ft7 | FP temps | Caller |
| f8-f9 | fs0-fs1 | FP saved | Callee |
| f10-f17 | fa0-fa7 | FP arguments | Callee |
| f18-f27 | fs2-fs21 | FP saved | Callee |
| fs28-fs31 | ft8-ft11 | FP temps | Caller |

*Note: FP = Floating Point register*

### Register

- The 'x' indicates it's a register.
- `x0` translates to `00000`.
  - The need for 5 bits is due to 32 registers requiring a 5-bit address.

### Name

- For ASM code and human readability.

### Memory Addressing

- **RISC-V:** Byte Addressed.
  - Aligned, thus faster access time.
  - Example: `addr + 1` → `addr + 1 byte`

### Addressing Modes

- **RISC-V:** Register, immediate, displacement (base + offset).
- Other examples: autoincrement, indexed, PC-relative.

### Types and Size of Operands

- **RISC-V:** 8-bit, 32-bit, 64-bit.

### Operations for RISC-V

1. Data transfer
2. Arithmetic
3. Logical
4. Control
5. FP

(Refer to Fig 1.5 in the textbook)

### Control Flow Instructions

- Use content of registers (RISC-V) vs Status Bits (x86, ARMv7, ARMv8).
- Return address in register (RISC-V, ARMv7, ARMv8) vs on stack (x86).

### Encoding

- **Fixed:** (RISC-V, ARMv7/v8 except compact instruction set) vs **Variable Length** (x86).

---

# RISC-V Instruction Layout *IMPORTANT*

## R-Type:
    +31-----------25|24-----20|19-----15|14--12|11-----7|6-----0+
    |    func7      |   rs2   |   rs1   |funct3|   rd  | opcode |
    +-----------------------------------------------------------+

### Primary Use:
- Register-Register
- ALU Instructions

### Fields:
- **rd:** Destination (Output register).
- **rs1:** Source 1 Register (Operand 1).
- **rs2:** Source 2 Register (Operand 2).
- **Immediate:** N/A

## I-Type:
    +31---------------------20|19-----15|14--12|11-----7|6-----0+
    |       imm[11:0]         |   rs1   |funct3|   rd  | opcode |
    +-----------------------------------------------------------+

### Primary Use:
- ALU Immediates
- Load

### Fields:
- **rd:** Destination (Output register).
- **rs1:** First source (Base source).
  - Register that holds the value to which the immediate will be added/subtracted.
- **rs2:** N/A
- **Immediate:** Value displacement (e.g., 4, 100, etc.).

## S-Type:
    +31------------25|24----20|19-----15|14--12|11-----7|6-----0+
    |   imm[11:5]    |  rs2   |   rs1   |funct3|imm[4:0]| opcode|
    +-----------------------------------------------------------+

### Primary Use:
- Store
- Compare and Branch

### Fields:
- **rd:** N/A
- **rs1:** Base register, first source.
- **rs2:** Data source to store, second source.
- **Immediate:** Displacement offset.

## U-Type:
    +31--------------------------------------12|11-----7|6-----0+
    |               imm[31:12]                 |   rd  | opcode |
    +-----------------------------------------------------------+

### Primary Use:
- Jump and link.
- Jump and link register.

### Fields:
- **rd:** Register destination for return PC.
- **rs1:** Target address for jump and link register.
- **rs2:** N/A
- **Immediate:** Target address for jump and link.

## Notes on the 4 types:

### OPCode (first 7 bits)
- Tells what type the instruction belongs to.
- Then, depending on the type, the CPU knows how to chop the remaining bits.

### I-Type
- Operands are immediate data.
- Destination is 5 bits for a register.
- `Funct3` will tell ALU which operation to perform: Add/Subtract/Multiply/Divide.
- `RS1`: Value you are manipulating.
- `RS2`: Value that does the manipulating.

### S-Type
- Branch will belong to this type.
- First 7 bits (opcode) will tell it that it's a store.
- Storing register value to memory.
- Base address (`RS1`) + displacement address (immediate).
- `RS2` register value will be sent to `RS1` + immediate address value.

### U-Type
- Just a jump.
    - **How is branch different from jump?**
        - Branch = Condition.
        - Jump = No condition.
- The immediate value will be added to the current PC and then will jump to that address to fetch more instructions.

## Load/Store Instructions in RISC-V *IMPORTANT*
| Example Instruction   | Instruction Name    | Meaning                                                             |
|-----------------------|---------------------|----------------------------------------------------------------------|
| `ld x1,80(x2)`        | Load Doubleword     | `Regs[x1] <- Mem[80 + Regs[x2]]`                                     |
| `lw x1,60(x2)`        | Load word           | `Regs[x1] <- 64(Mem[60 + Regs[x2]])^32`                              |
| `lwu x1,60(x2)`       | Load word unsigned  | `Regs[x1] <- [63:33] = 0s [32:0]Mem[60 + Regs[x2]]`                  |
| `lb x1,40(x3)`        | Load byte           | `Regs[x1] <- [63:56] = (Mem[40 + Regs[x3]]) and [55:0] = 0s`         |
| `lbu x1,40(x3)`       | Load byte unsigned  | `Regs[x1] <- Mem[40 + Regs[x3]]`                                     |
| `lh x1,40(x3)`        | Load halfword       | `Regs[x1] <- (Mem[40 + Regs[x3]])`                                   |
| `flw f0,50(x3)`       | Load FP single      | `Regs[f0] <- (Mem[50] + Regs[x3])`                                   |
| `fld f0,50(x2)`       | Load FP double      | `Regs[f0] <- (Mem[50 + Regs[x2]])`                                   |
| `sd x2,400(x3)`       | Store double        | `Mem[400 + Regs[x3]] <- (Regs[x2])`                                  |
| `sw x3,500(x4)`       | Store word          | `Mem[500 + Regs[x3]] <- (Regs[x3])`                                  |
| `fsw f0,40(x3)`       | Store FP single     | `Mem[40 + Regs[x3]] <- (Regs[f0])`                                   |
| `fsd f0,40(x3)`       | Store FP double     | `Mem[40 + Regs[x3]] <- Regs[f0]`                                     |
| `sh x3,502(x2)`       | Store half          | `[63:48] of Mem[40 + Regs[x3]] <- Lower 16 bits of Regs[x3]`         |
| `sb x2,41(x3)`        | Store byte          | `[63:56] of Mem[41 + Regs[x3]] <- Lower 8 bits of Regs[x2]`          |

## ALU Instructions in RISC-V (R & I Type)
| Example    | Instruction Name     | Meaning                                                       |
|------------|----------------------|----------------------------------------------------------------|
| `add x1,x2,x3` | Add                   | `Regs[x1] <- Regs[x2] + Regs[x3]`                                 |
| `addi x1,x2,3` | Add immediate         | `Regs[x1] <- Regs[x2] + 3`                                        |
| `lui x1,42`    | Load Upper immediate  | `Regs[x1] <- Upper bits of 42 will be loaded`                     |
| `sll x1,x2,5`  | Shift left logical    | `Regs[x1] <- Regs[x2]<<5`                                         |
| `slt x1,x2,x3` | Set less than         | `if (Regs[x2] < Regs[x3]) then: Regs[x1] <- 1 else Regs[x0] <- 0` |

## Control Flow instructions in RISC-V
### S-Type (Branch) vs U-Type (Jump and link)
| Example            | Instruction Name       | Meaning                                                                |
|--------------------|------------------------|-------------------------------------------------------------------------|
| `jal x1, offset`   | Jump and link          | `Regs[x1] <- PC + 4; PC <- PC + (offset<<1)`                            |
| `jalr x1,x2,offset`| Jump and link register | `Regs[x1] <- PC + 4; PC <- Regs[x2]+offset`                             |
| `beq x3,x4,offset` | Branch equal Zero      | `if (Regs[x3] == Regs[x4]) PC <- PC + (offset<<1)`                      |
| `bgt x4,x4,name`   | Branch not equal zero  | `if (Regs[x3] > Regs[x4]) PC <- PC + (offset<<1)`                       |

## Execution Cycle
```
+-----------+
|           |
|           |
|           V
|    +---------------+
|    | Instruction   | 
|    |   Fetch       |
|    +---------------+
|            |
|            | Obtain instruction from program storage
|            |
|            V 
|    +---------------+
|    | Instruction   | 
|    |   Decode      |
|    +---------------+
|            |
|            | Determine required actions and instruction size 
|            |
|            V 
|    +---------------+
|    |   Operand     | 
|    |   Fetch       |
|    +---------------+
|            |
|            | Locate and obtain operand data
|            |
|            V 
|    +---------------+
|    |   Execute     |
|    +---------------+
|            |
|            | Compute result value or status
|            |
|            V
|    +---------------+
|    |   Result      | 
|    |     Store     |
|    +---------------+
|            |
|            | Deposit reslts in storage for later use
|            |
|            V
|    +---------------+
|    | Next          | 
|    |   Instruction |
|    +---------------+
|            |
|            | Determine successor instruction
|            |
+------------+
```