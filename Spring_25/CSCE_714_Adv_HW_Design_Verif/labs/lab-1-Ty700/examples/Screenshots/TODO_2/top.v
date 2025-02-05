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

   // PART 1: Contains Parameter and variable declarations and assignments

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
   wire [DBUS_WIDTH-1:0]    prdata;    // Slave read data output
   wire                     pready;    // Slave ready output
   wire                     pslverr;   // Slave slave error output
   reg                      sys_ready_i;     // System Transfer ready for Master
   reg  [ABUS_WIDTH-1:0]    sys_addr_i;      // System Transfer address for Master
   reg  [DBUS_WIDTH-1:0]    sys_data_i;      // System Transfer data for Master write data or read compare data
   reg                      sys_write_i;     // System Transfer type (1=Write 0=Read
   
   
   assign pready  = psel && !sys_ready_i;
   assign prdata  = (pready && !pwrite) ? sys_data_i : 32'h00000000;

   // TO-DO 2 Write your code here to fix the assertion

	
   assign pslverr = !(psel && penable && pready) ? 1'b0 : 1'b1;
	

   // END PART 1


   // PART 2: Contains all the module instantiations, e.g. apb_master and apb3_monitor instantiations

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
       .psel_o(psel),
       .pslverr_i(pslverr)
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

   // END PART 2

   // PART 3: Contains the block to generate clk and controls simulation data

   // Clock Modeling
   initial begin
        pclk      = 1'b1;
        forever
            #5 pclk = ~pclk;
    end

   initial begin
     presetn     = 1'b0;
     sys_ready_i = 1'b0;
     sys_addr_i  = 32'h00000000;
     sys_data_i  = 32'h00000000;
     sys_write_i = 1'b0;

#15  presetn     = 1'b1;
     sys_ready_i = 1'b0;
     sys_addr_i  = 32'h00000000;
     sys_data_i  = 32'h00000000;
     sys_write_i = 1'b0;

#20  sys_ready_i = 1'b1;         // write A:0x12345678 D:0x9ABCDEF0
     sys_addr_i  = 32'h12345678;
     sys_data_i  = 32'h9ABCDEF0;
     sys_write_i = 1'b1;

#20  sys_ready_i = 1'b0;

#20  sys_ready_i = 1'b1;         // write A:0x9ABCDEF0 D:0x12345678
     sys_addr_i  = 32'h9ABCDEF0;
     sys_data_i  = 32'h12345678;
     sys_write_i = 1'b1;

#20  sys_ready_i = 1'b0;

   // TO-DO 1: Write your 2 Read test cases below following the same timing as used for the write operations


#20  sys_ready_i = 1'b1;         // Read A:0x12345678
     sys_addr_i  = 32'h12345678;
     sys_data_i  = 32'h9ABCDEF0;
     sys_write_i = 1'b0;

#20  sys_ready_i = 1'b0;

#20  sys_ready_i = 1'b1;         // Read A:0x9ABCDEF0
     sys_addr_i  = 32'h9ABCDEF0;
     sys_data_i  = 32'h12345678;
     sys_write_i = 1'b0;
     
#20  sys_ready_i = 1'b0;


   // TO-DO 3: Write the necessary code below so that the coverpoint tran_access_wait is covered.






#20  sys_ready_i = 1'b0;
     sys_addr_i  = 32'h00000000;
     sys_data_i  = 32'h00000000;
     sys_write_i = 1'b0;
   end


   // END PART 3

endmodule
