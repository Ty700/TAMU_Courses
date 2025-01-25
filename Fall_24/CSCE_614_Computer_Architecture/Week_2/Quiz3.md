### Question:
Show the contents of registers and memory after executing the following assembly code:

```assembly
lw x1, 0x4(x2)
sw x2, 0x0(x1)
add x2, x1, x2
```

### Initial Register and Memory values:

    Registers:              Memory:
    +----------+-------+    +---------+-------+
    | Register | Value |    | Address | Value |
    |----------|-------|    |---------|-------|
    | x0       | 0x0000|    | 0x0000  | a     |
    | x1       | 0xF008|    | 0xF000  | b     |
    | x2       | 0xF000|    | 0xF004  | c     |
    | x3       | ...   |    | 0xF008  | d     |
    +----------+-------+    +---------+-------+


### After "lw x1, 0x4(x2)"
    Registers:              Memory:
    +----------+-------+    +---------+-------+
    | Register | Value |    | Address | Value |
    |----------|-------|    |---------|-------|
    | x0       | 0x0000|    | 0x0000  | a     |
    | x1       | b     |    | 0xF000  | b     |
    | x2       | 0xF000|    | 0xF004  | c     |
    | x3       | ...   |    | 0xF008  | d     |
    +----------+-------+    +---------+-------+

### After "sw x2, 0x0(x1)"
    Registers:              Memory:
    +----------+-------+    +---------+-------+
    | Register | Value |    | Address | Value |
    |----------|-------|    |---------|-------|
    | x0       | 0x0000|    | 0x0000  | a     |
    | x1       | b     |    | 0xF000  | b     |
    | x2       | 0xF000|    | 0xF004  | c     |
    | x3       | ...   |    | 0xF008  | d     |
    +----------+-------+    | 0x000b  | 0xF000|
                            +---------+-------+

# After: "add x2, x1, x2"
    Registers:                  Memory:
    +----------+-----------+    +---------+-------+
    | Register | Value     |    | Address | Value |
    |----------|-----------|    |---------|-------|
    | x0       | 0x0000    |    | 0x0000  | a     |
    | x1       | b         |    | 0xF000  | b     |
    | x2       | b + 0xF000|    | 0xF004  | c     |
    | x3       | ...       |    | 0xF008  | d     |
    +----------+-----------+    | 0x000b  | 0xF000|
                                +---------+-------+
    
