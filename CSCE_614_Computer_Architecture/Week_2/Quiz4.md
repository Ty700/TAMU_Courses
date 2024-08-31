**Question**: Assume that we make two enhancement modes to a computer, A and B. Mode A provides a speedup of 10 and mode B provides a speedup of 100. While using the enhancements, 50% of the time is spent in enhancement A (only A is applied), 25% is spent in enhancement B (only B is applied), and 10% of the time is spent in BOTH enhancements A and B (both A and B are applied, gaining a speedup of 1000 for that part of the code). What is the overall speedup of using the enhancements?

**Overall Speedup**:
\[
\text{Speedup}_{\text{overall}} = \frac{1}{(1 - 0.85) + \left(\frac{0.5}{10}\right) + \left(\frac{0.25}{100}\right) + \left(\frac{0.1}{1000}\right)}
\]
\[
\text{Speedup}_{\text{overall}} = 4.93583
\]
