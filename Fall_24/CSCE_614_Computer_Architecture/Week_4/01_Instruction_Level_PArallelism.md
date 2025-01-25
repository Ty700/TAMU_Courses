# Introduction
Pipelining became a universal technique in 1985 
- Overlaps execution of instructions 
- Exploits "Instruction Level Parallelism"

Beyond this, there are two main approaches:
- Hardware-based dynamic approaches 
  - Used in server and desktop processors 
  - Not used as extensively in PMP processors 
- Compiler-based static approaches
  - Not as successful outside of scientific applications 

When exploiting instruction-level parallelism, the goal is to maximize CPI 
- Pipeline CPI =  
  Ideal pipeline CPI + Structural stalls + Data hazard stalls + Control stalls 
  - Goal is to reduce the number of stalls via hazards 

- Parallelism within a basic block is limited 
  - Typical size of basic block = 3 to 6 instructions 
  - Must optimize across branches

## Data Dependency
- **Data Hazards** 
  - Read after write (RAW) - True Data Dependency
  - Write after write (WAW) - Output Dependency
  - Write after read (WAR) - Antidependency 
- WAW and WAR -> Name Dependency 

- In RISC-V integer operations, we saw RAW can be eliminated through forwarding 
  - WAW and WAR won't happen

- From now on, we are talking about a very general architecture 
  - Not just five-stage integer operations
  - General architecture where each unit can take more than 1 CC 
  - We will revisit all hazards 

To tackle data dependency, we take advantage of:
- **Loop-Level Parallelism**
  - Unroll loop statically or dynamically 
  - Use SIMD (vector processors and GPUs)

### Challenges Faced:
- **Data Dependency**   
  - Instruction j is data-dependent on instruction i if:
    - Instruction i produces a result that may be used by instruction j 
    - or 
    - Instruction j is data-dependent on instruction k and instruction k is data-dependent on instruction i 
- Dependent instructions cannot be executed simultaneously 
  - They must be sequential 

- Dependencies are a property of programs 
- Pipeline organization determines if dependence is detected and if it causes a stall 

- **Data dependence** conveys:
  - Possibility of a hazard 
  - Order in which results must be calculated 
  - Upper bound on exploitable instruction-level parallelism

- Dependencies that flow through memory locations are difficult to detect 

## Name Dependencies
- Two instructions use the same name but no flow of information 
  - Not a true data dependence, but is a problem when reordering instructions 
  - **Antidependence**: 
    - Instruction j writes a register or memory location that i reads 
      - Initial ordering (i before j) must be preserved 
  - **Output dependence**: 
    - Instruction i and instruction j write the same register or memory location 
      - Ordering must be preserved

- To resolve, use register renaming techniques

## Other Factors
- **Data Hazards** 
  - RAW 
  - WAW 
  - WAR 

- **Control Dependence** 
  - Ordering of instruction i with respect to a branch instruction 
    - Instruction control-dependent on a branch can't be moved before the branch so that its execution is no longer controlled by the branch 
    - An instruction not control-dependent on a branch cannot be moved after the branch so that its execution is controlled by the branch 

### Example:
```assembly
add x1, x2, x3 
beq x4, x0, L 
sub x1, x1, x6 
...
...
...
L:  
or x7, x1, x8 
```

#### Explanation:

x1 add has two dependencies:
    sub x1, x1, x6
    and
    or x7, x1, x8

This dependency graph is not static because it will be determined if either sub or 'or' executes depending on the beq instruction.

### Another Example:

```assembly
add x1, x2, x3
beq x12, x0, skip 
sub x4, x5, x6 
add x5, x4, x9  -> Read after write 
skip: 
or x7, x8, x9 
```

#### Explanation:

- Updating x4's value @ sub x4, x5, x6
- Reading value @ add x5, x4, x9

- However, if x4 never appears after skip, then we can move the beq instruction down to allow the x4 register to be updated in time for the add instruction to read the updated value.

- Currently, as it stands, the add instruction will read a value that is not updated since the instruction hasn't finished executing.