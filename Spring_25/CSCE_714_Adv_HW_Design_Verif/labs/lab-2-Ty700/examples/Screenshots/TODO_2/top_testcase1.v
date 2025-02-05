/*****************************************************************************
� 2005 Cadence Design Systems, Inc. All rights reserved. 
This work may not be copied, modified, re-published, uploaded, executed, or
distributed in any way, in any medium, whether in whole or in part, without
prior written permission from Cadence Design Systems, Inc.
*****************************************************************************/

/*********************************************************/
// MODULE:      APB Example Top-Level
//
// FILE NAME:   top.v
// VERSION:     1.0
// DATE:        Dec 1, 2011
// AUTHOR:      Cadence Design Systems, Inc.
// 
// CODE TYPE:   RTL
//
// DESCRIPTION: APB Master-Slave verification
//
/*********************************************************/

module top ();

   // PART 1 - Contains the parameter and variable declarations

   parameter ABUS_WIDTH = 32;
   parameter DBUS_WIDTH = 32;
   parameter MAX_WAIT_CYCLES_ON = 0;

   reg                      pclk;      // Clock
   reg                      presetn;   // Reset
   wire                     psel;      // Master select line
   wire                     penable;   // Master enable signal
   wire [ABUS_WIDTH-1:0]    paddr;     // Master address
   wire                     pwrite;    // Master write request
   wire [DBUS_WIDTH-1:0]    pwdata;    // Master write data
   wire [DBUS_WIDTH-1:0]    prdata;    // Slave read data
   reg                      sys_ready_i;     // System Transfer ready for Master
   reg  [ABUS_WIDTH-1:0]    sys_addr_i;      // System Transfer address for Master
   reg  [DBUS_WIDTH-1:0]    sys_data_i;      // System Transfer data for Master write data or read compare data
   reg                      sys_write_i;     // System Transfer type (1=Write 0=Read
   
   // END PART 1



   // PART 2 - Contains the module instantiations, e.g. apb_master, apb3_slave and apb3_monitor instantiations
   
   // Instance of the APB master ; Users can instantiate their own Master RTL design
   apb_master # (
     
   .ABUS_WIDTH(ABUS_WIDTH),
   .DBUS_WIDTH(DBUS_WIDTH)
   )
   apbMaster (
       .pclk_i(pclk),
       .presetn_i(presetn),
       .sys_ready_i(sys_ready_i),
       .sys_addr_i(sys_addr_i),
       .sys_data_i(sys_data_i),
       .sys_write_i(sys_write_i),
       .prdata_i(prdata),
       .pready_i(pready),
       .paddr_o(paddr),
       .pwrite_o(pwrite),
       .pwdata_o(pwdata),
       .penable_o(penable),
       .pslverr_i(pslverr),
       .psel_o(psel)
   );

   
   // Instance of the APB ABVIP Monitor
   apb3_monitor #(
   
   .ABUS_WIDTH(ABUS_WIDTH),
   .DBUS_WIDTH(DBUS_WIDTH),
   .MAX_WAIT_CYCLES_ON(MAX_WAIT_CYCLES_ON),
   .COVERAGE_ON(1),
   .COVERGROUPS_ON(1),
   .RST_CHECKS_ON(0),
   .RECM_CHECKS_ON(1),
   .XCHECKS_ON(0)

   )
   apb_checker ( 
   
   .pclk(pclk),
   .presetn(presetn),
   .paddr(paddr),
   .psel(psel),
   .penable(penable),
   .pwrite(pwrite),
   .pwdata(pwdata),
   .pready(pready),
   .prdata(prdata),
   .pslverr(pslverr)
   );

   // Instance of the APB ABVIP Slave (Memory)
   apb3_slave #(

   .ABUS_WIDTH(ABUS_WIDTH),
   .DBUS_WIDTH(DBUS_WIDTH)

   )
   apb_memory (

   .pclk(pclk),
   .presetn(presetn),
   .paddr(paddr),
   .psel(psel),
   .penable(penable),
   .pwrite(pwrite),
   .pwdata(pwdata),
   .pready(pready),
   .prdata(prdata),
   .pslverr(pslverr)
   );



   // END PART 2
   



   // PART 3 - Contains the different write, read and drive task definitions


   // Write task used to do write operations - write_read = 1'b1 = sys_write_i
   task automatic master_slave_write(reg sys_ready_task, reg [ABUS_WIDTH-1 : 0]addr_task, reg [DBUS_WIDTH-1 : 0]data_task, reg write_read );

            #20  sys_ready_i <= sys_ready_task;
                 sys_addr_i  <= addr_task;
                 sys_data_i  <= data_task;
                 sys_write_i <= write_read;
	    
		`ifdef DEBUG
        		$display("DEBUG: Master Write - Addr: 0x%h, Data: 0x%h", addr_task, data_task);
    		`endif

            #20  sys_ready_i <= 1'b0;

   endtask


   // Read task used to do read oeprations - write_read = 1'b0
   // TO-DO: 1 Write a Read Task similar to the write task which takes 4 clk cycles to complete the operation which is same as the write task
   

   task automatic master_slave_read(
	   input reg 				sys_ready_task,
	   input reg [ABUS_WIDTH - 1 : 0] 	addr_task,
	   output reg [DBUS_WIDTH - 1 : 0] 	data_task,
	   input reg 				write_read
   );
	
   	#20 sys_ready_i <= sys_ready_task;
	    sys_addr_i  <= addr_task;
	    sys_write_i <= write_read;
	
	wait(pready);

	`ifdef DEBUG
		$display("DEBUG: Slave is ready. Pready = %b", pready);		
		$display("READ ADDRESS: 0x%h", addr_task);
	`endif /* DEBUG */

	#20; data_task = prdata;

	`ifdef DEBUG 
		$display("Data at 0x%h = 0x%h", addr_task, data_task);
	`endif

	#10 sys_ready_i <= 1'b0;
   endtask 

   //


   // Write task that can cover the tran_access_setup coverpoint
   // TO-DO: 2.2 Delay sys_ready for Write op to cover access_setup state.
   






   //


   // Clock Modeling
   initial begin
       pclk      = 1'b1;
       forever
           #5 pclk = ~pclk;
   end


   // Checker that checks whether the data read is the correct data
   // TO-DO: 3 Checker for verifying the read data
   initial begin
      






   end

   //

   initial begin
         drive();
   end


   // Drive task is the task where we provide stimulus to the write and read tasks
   task drive();
	  reg [DBUS_WIDTH - 1: 0]prdata1, prdata2;
          
	  presetn     <= 1'b0;
          sys_ready_i <= 1'b0;
          sys_addr_i  <= 32'h0;
          sys_data_i  <= 32'h0;
          sys_write_i <= 1'b0;
	
      #15 presetn     <= 1'b1;

      // This test does 2 write operations
      // A: 0x12345678, D: 0x9abcdef0
      // A: 0x9abcdef0, A: 0x12345678
      `ifdef TEST1

        master_slave_write(1'b1, 32'h12345678, 32'h9abcdef0, 1'b1);
        master_slave_write(1'b1, 32'h9abcdef0, 32'h12345678, 1'b1);

        $display("LAB2: PART1: Test Case 1 finished at time %t", $time());

      `endif
	
      
      // TO-DO: 2.1 - Write test cases to do two Read operations
      `ifdef TEST2
        
        master_slave_write(1'b1, 32'h12345678, 32'h9abcdef0, 1'b1);
	
	#40;

        master_slave_read(1'b1, 32'h12345678, prdata1, 1'b0);
	$display("Read 1 - Expected: 0x9ABCDEF0, Actual: %h", prdata1);

	master_slave_write(1'b1, 32'h9abcdef0, 32'h12345678, 1'b1);
	
	#40;

	master_slave_read(1'b1, 32'h9abcdef0, prdata2, 1'b0);
    	$display("Read 2 - Expected: 0x12345678, Actual: %h", prdata2);

	$display("LAB2: TO-DO 2.1: Test Case 2 finished at time %t", $time());

      `endif

      //

      // TO-DO: 2.2 Write test cases to Test access_setup state with Write and read operations.
      `ifdef TEST3

        



        $display("LAB2: TO-DO 2.2: Test Case 3 finished at time %t", $time());

      `endif

      //
	  
      // TO-DO: 3 - Write test cases to test the checkers change the data in read operation
      `ifdef TEST4

        


        
        $display("LAB2: TO-DO 3: Test Case 4 finished at time%t", $time());
        
      `endif

      //

      #20 sys_ready_i <= 1'b0;
          sys_addr_i  <= 32'h0;
          sys_data_i  <= 32'h0;
          sys_write_i <= 1'b0;

   endtask

   // END PART 3

endmodule
