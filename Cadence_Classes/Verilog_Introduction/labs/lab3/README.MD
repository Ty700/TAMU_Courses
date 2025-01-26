
Modeling an Address Multiplexor 
	- Use basic Verilog constructs to describe a simple design


RESULT

Recompiling... reason: file './multiplexor_test.v' is newer than expected.
        expected: Fri Dec 15 04:32:58 2023
        actual:   Sat Jan 25 20:53:40 2025
file: multiplexor_test.v
        module worklib.multiplexor_test:v
                errors: 0, warnings: 0
                Caching library 'worklib' ....... Done
        Elaborating the design hierarchy:
    .WIDTH ( WIDTH )
         |
xmelab: *W,CUVUKP (./multiplexor_test.v,12|9): The name 'WIDTH' is not declared in the instantiated module (defined at ./multiplexor.v,1).
        Top level design units:
                multiplexor_test
        Building instance overlay tables: .................... Done
        Generating native compiled code:
                worklib.mux5:v <0x6bdc49e5>
                        streams:   1, words:   224
                worklib.multiplexor_test:v <0x22fa81d4>
                        streams:   5, words:  6759
        Building instance specific data structures.
        Loading native compiled code:     .................... Done
        Design hierarchy summary:
                             Instances  Unique
                Modules:             2       2
                Registers:           4       4
                Scalar wires:        1       -
                Vectored wires:      3       -
                Initial blocks:      1       1
                Cont. assignments:   1       1
                Pseudo assignments:  3       3
        Writing initial simulation snapshot: worklib.multiplexor_test:v
Loading snapshot worklib.multiplexor_test:v .................... Done
xcelium> source /opt/coe/cadence/XCELIUM/tools/xcelium/files/xmsimrc
xcelium> run
At time 1 sel=0 in0=10101 in1=00000, mux_out=10101
At time 2 sel=0 in0=01010 in1=00000, mux_out=01010
At time 3 sel=1 in0=00000 in1=10101, mux_out=10101
At time 4 sel=1 in0=00000 in1=01010, mux_out=01010
TEST PASSED
Simulation complete via $finish(1) at time 4 NS + 0
./multiplexor_test.v:43     $finish;

