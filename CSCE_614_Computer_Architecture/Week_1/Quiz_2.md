### Question:
    Write the assembly codes for machines with four different internal storages; Stack, accumulator, Reg-Memory and Reg-Reg. A =B+C where A,B and C are memory addresses.

#### Stack Architecture
```assembly
push mem[B]
push mem[C]
add
pop mem[A]
```

#### Accumulator Architecture
```assembly
xor acc, acc    ; Clears acc
add acc, mem[B]
add acc, mem[C]
store mem[A], acc
```

#### Register-Memory Architecture
```assembly
load r1, mem[B]
add  r1, mem[C]
store mem[A], r1
```

#### Load-Store Architecture
```assembly
load r1, mem[B]
load r2, mem[C]
add r1, r2
store mem[A], r1
```