## Fundamentals of Quantitative Design and Analysis

### Outline
- Where are we?
- Computer architecture vs Instruction Set architecture
- How would you like your CSCE 614?
- What computer architecture brings to the table

### Computer Technology

#### Performance Improvements

**Improvements in semiconductor technology:**
- Feature size, clock speed 

**Improvements in computer architectures:**
- Enabled by HLL compilers, UNIX
    - HLL -> "High level language"
- Lead to RISC architecture

**Together have enabled:**
- Lightweight computers 
- Productivity-based managed/interpreted programming languages 

#### Trend over Single Processor Performance

- **From 1978 -> 1986:**
  - 25% increase per year in performance 

- **From 1986 -> 2003:**
  - 52% increase per year in performance
    - "Golden times"
    - At this time, all the concepts we learn were discovered here
        - Examples:
            - Cache
            - Pipelining
            - Instruction-level Parallelism

- **From 2003 -> 2011:**
  - 23% increase per year in performance
  - Prior to these years, smaller feature sizes.
      - Bigger chip area
          - Bigger chip area -> Further from memory
      - Problems:
          - Power
          - Data from one point to another
  - **What happened?**
      - Big movement from single processor to CMP
          - CMP -> "Chip Multicore Processor"
          - 2, 4, 6 cores emerged in this era

- **From 2011 -> 2015:**
  - 12% increase per year in performance

- **From 2015 -> 2024:**
  - 3.5% increase per year in performance

### Current Trends in Architecture
- **Cannot continue to leverage Instruction-Level Parallelism (ILP):**
  - Single processor performance improvement ended in 2003

- **New models for performance:**
  - Data-Level Parallelism (DLP) -> Mainly exploited in GPU architecture
  - Thread-Level Parallelism (TLP) -> Mainly exploited in CPU architecture
  - Request-Level Parallelism (RLP)

- **These require explicit restructuring of the application:**
  - That is why these ideas were proposed many years ago, but not needed.

### Classes of Computers

1. **Personal Mobile Device (PMD)**
    - Smartphones, tablets
    - Emphasis on energy efficiency and real-time 

2. **Desktop Computer**
    - Emphasis on price-performance

3. **Servers**
    - Emphasis on availability, scalability, and throughput

4. **Clusters / Warehouse Scale Computers**
    - Used for "Software as a Service" (SaaS)
    - Emphasis on availability and price-performance
    - **Sub-class:** Supercomputers
        - Emphasis: Floating-point performance and fast internal networks 

5. **Internet of Things/Embedded Computers**
    - Emphasis: Price and energy 
    - **Example:** Security cameras

### Parallelism

**Classes of parallelism in applications:**
- Data-Level Parallelism (DLP)
- Task-Level Parallelism (TLP)

**Classes of architectural parallelism:**
- Instruction-Level Parallelism (ILP)
- Vector architectures/Graphics Processor Units (GPU)
- Thread-Level Parallelism (TLP)
- Request-Level Parallelism (RLP)

### Flynn's Taxonomy
- **Single Instruction Stream, Single Data Stream (SISD)**

- **Single Instruction Stream, Multiple Data Streams (SIMD)**
    - Vector architecture
    - Multimedia extensions
    - GPUs

- **Multiple Instruction Streams, Single Data Stream (MISD)**
    - No commercial implementation 

- **Multiple Instruction Streams, Multiple Data Streams (MIMD)**
    - Tightly-coupled MIMD
    - Loosely-coupled MIMD
