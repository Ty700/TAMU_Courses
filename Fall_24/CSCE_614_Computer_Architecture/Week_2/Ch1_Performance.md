# Chapter 1: Fundamentals of Quantitative Design and Analysis

## Performance

### Defining Computer Architecture

- **"Old" view of computer architecture:**
  - Instruction Set Architecture (ISA) design
  - Example:
    - Decisions regarding:
      - Registers, memory addressing, addressing modes, instruction operands
      - Available operations, control flow instructions, instruction encoding

- **"Real" computer architecture:**
  - Specific requirements of the target machine
  - Design to maximize performance within constraints:
    - Cost
    - Power
    - Availability
  - Includes ISA, microarchitecture, and inside the hardware

- **Conclusion:** Computer Architecture is an integrated approach
  - What really matters is the functioning of the complete system:
    - Hardware, runtime system, compiler, operating system, and application
  - In networking, this is called the "End to End argument."

- **Summary:** Computer architecture is not just about transistors, individual instructions, or particular implementations... rather the whole system.

## Computer Architecture is Design and Analysis

- **Architecture is an iterative process:**
  - Searching the space of possible designs
  - At all levels of computer systems
  - Brainstorm, create ideas, test, and filter out the bad ideas

## Measuring Performance

### How do you know if an idea is good or bad?

- **Typical performance metrics:**
  - Response time
  - Throughput

- **Speedup of X relative to Y:**
  - Execution time (Y) / Execution Time (X)

- **Execution Time:**
  - **Wall clock time:**
    - Includes all system overhead
  - **CPU Time:**
    - Only computation time

- **Benchmarks:**
  - Kernel (Matrix multiply)
  - Toy programs (Example: Sorting)
  - Synthetic Benchmarks
  - Benchmark suites

## Trends in Technology

### Integrated circuit technology (Moore's Law)

- Transistor density: +35%/year
- Die Size: Smaller by 10 - 20% per year
- Integration overall: +40-55%/year

### DRAM

- Capacity: +25-40%/year (Slowing)
  - 8GB (2014) -> 16GB (2019) -> 32GB (2024)

### Flash

- Capacity: +50-60%/year
- 8-10x cheaper than DRAM

### Hard Disk Drive

- Capacity: Recently slowed to 5%/year
- 8-10x cheaper than Flash
- 200-300x cheaper than DRAM

## Bandwidth and Latency

### Bandwidth or Throughput

- Total work done in a given time
- 32,000 to 40,000x improvement for processors
- 300 to 1200x improvement for memory and disks
- Easily increased
  - If you have one system that does 1000 computations per second and want to increase Bandwidth, just add another system
  - Thus Bandwidth is now 2x what it was before

### Latency

- Time between start and completion of an event
  - Most important for end user
- 50 to 90x improvement for processors
- 6 to 8x improvement for memory and disks
- Not easily increased
  - To have better latency, much more has to go into the design than bandwidth
  - Processors need to be more efficient, thus better overall design and architecture

- **Example:**
  - Hiring one really efficient person vs. hiring two slower people to complete the same task.
  - One person takes 10s per customer:
    - 1/10 -> Throughput
  - Two people take 17s per customer:
    - 1/17 + 1/17 -> Throughput
    - 2/17 -> Throughput
  - So with two people, the throughput is higher, but the latency per person is slower.

## Transistors and Wires

### Feature Size

- Minimum size of transistor or wire in x or y dimensions
- 10 microns in 1971 to 0.011 microns in 2017
- Transistor performance scales linearly
  - Wire delay does not improve with feature size
- Integration density scales quadratically

## Principles of Computer Design

### The Processor Performance Equation

- **CPU Time = CPU clock cycles for a program * clock cycle time**

- Many times we don't have clock cycle time, rather clock rate... then:

- **CPU Time = CPU clock cycles for a program / clock rate**

- **CPI = CPU clock cycles for a program / Instruction count**

- **CPU Time = Instruction count * Cycles per instruction * clock cycle time**

- **(Instruction / Program) * (Clock cycle / Instruction) * (Seconds / Clock Cycles) = Seconds / Program = CPU Time**

- **Different instruction types have different CPIs:**
  - **CPU Clock cycles = Sum of IC * CPI**
  - **CPU Time = CPU Clock Cycles * Clock cycle time**

### 3 Principles of Design for our own research

1. **Take advantage of Parallelism**
   - Example:
     - Multiple processors, disks, memory banks, pipelining, multiple functional units

2. **Principle of Locality**
   - Reuse of data and instructions

3. **Focus on the Common Case**
   - **Amdahl's Law**
     - If you put effort into making the floating point unit more efficient, do you see performance in the integer unit? No.
     - Thus the upper bound of the performance is defined by the unit you didn't work on.
     - **Execution Time (New) = Execution Time (Old) * ([1 - Fraction(enhanced)] + [Fraction(enhanced) / Speedup(enhanced)])**
