/*************************************************************************
* This work is (c) 2012 Cadence Design Systems, Inc. All rights reserved. 
* Licensed Material - Property of Cadence Design Systems 
* This Licensed Material is made available for INTERNAL USE ONLY to end
* users who have executed an end user license agreement with Cadence
* Design Systems (License Agreement).  You agree not to use, copy, modify,
* sell, or transfer this Licensed Material or any copy, in whole or in
* part, except as expressly provided for in the License Agreement. 
*
* YOU ARE PROHIBITED FROM USING THE LICENSED MATERIAL OR ANY DERIVATIVE
* WORK FOR ANY PURPOSE OTHER THAN WHAT IS PERMITTED IN THE LICENSE
* AGREEMENT, INCLUDING, WITHOUT LIMITATION, DEVELOPING A COMMERCIALLY
* AVAILABLE DESIGN TOOL OR RELATED SOFTWARE/MATERIALS. 
*
* Any copies or derivative works based upon this Licensed Material must
* retain a copy of these notices and are subject to the terms of the
* License Agreement.
*
* TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT SHALL CADENCE OR
* ANYONE ELSE INVOLVED IN THE CREATION, PRODUCTION, DELIVERY, OR LICENSING
* OF THE PRODUCT BE LIABLE TO YOU OR ANY THIRD PARTY FOR ANY INCIDENTAL,
* INDIRECT, SPECIAL OR CONSEQUENTIAL DAMAGES, OR ANY OTHER DAMAGES
* WHATSOEVER (INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF BUSINESS
* PROFITS, BUSINESS INTERRUPTION, LOSS OF BUSINESS INFORMATION, OR OTHER
* PECUNIARY LOSS) ARISING OUT OF THE USE OR INABILITY TO USE THIS PRODUCT,
* WHETHER OR NOT THE POSSIBILITY OR CAUSE OF SUCH DAMAGES WAS KNOWN TO
* CADENCE.
**************************************************************************/

    //___________________________________________________________________
    //
    // MODULE:      AMBA APB 3 assertion monitor
    // FILE NAME:   apb3_monitor.sv
    // AUTHOR:      Cadence Design Systems, Inc
    // DATE:        30 September, 2011
    // CODE TYPE:   RTL
    // DESCRIPTION: SVA based monitor for APB 3
    //___________________________________________________________________
    // lint_checking ALL OFF

    //______________________________________________________APB 3 CONFIGURATION 
    // {{{

    // Configure as MASTER (drive master interface signals, check slave interface signals)
    //`ifdef CDNS_APB3_MASTER
    //    `define CDNS_APPLY_MASTER assume
    //    `define CDNS_APPLY_SLAVE  assert
    //    `define CDNS_MODULE_NAME  apb3_master
         
    // Configure as SLAVE (drive slave interface signals, check master interface signals)
    //`elsif CDNS_APB3_SLAVE
    //    `define CDNS_APPLY_MASTER assert
    //    `define CDNS_APPLY_SLAVE  assume
    //    `define CDNS_MODULE_NAME  apb3_slave
         
    // Configure as CHECKER (check master and slave interface signals)
    //`else
    //    `define CDNS_APPLY_MASTER assert
    //    `define CDNS_APPLY_SLAVE  assert
    //    `define CDNS_MODULE_NAME  apb3_monitor
    //`endif
//__RTL_GEN_CODE_1__
    `ifdef CDNS_OLD_ABVIP_STYLE
        `define CDNS_MODULE_NAME apb3_monitor
    `else
        `define CDNS_MODULE_NAME cdn_abvip_apb3_monitor
    `endif

    // }}} APB 3 CONFIGURATION ENDS HERE

module apb3_monitor

     // INTERFACE {{{

     #(parameter

    //______________________________________________________APB 3 USER DEFINED PARAMS

      int ABUS_WIDTH           = 32,  // Size of Address field
      int DBUS_WIDTH           = 32,  // Size of Data field
      int PSEL_N               = 1,   // Number of slaves present, i.e. width of psel signal;
                                      // When configured as master (verifying a slave), leave PSEL_N as default of 1.
                                      // When configured as slave (verifying a master), set PSEL_N to the number of slaves connected to the bus;

    //______________________________________________________APB 3 PARAMS

      int PROT_WIDTH           = 3,

    //______________________________________________________APB 3 AIP PARAMS

      bit COVERAGE_ON          = 1,   // Set to 1: Enable functional covers
      bit COVERGROUPS_ON       = 1,   // Set to 1: Enable covergroups. Use -extract_covergroups in elaborate command to extract coverpoints.
      bit MAX_WAIT_CYCLES_ON   = 0,   // Set to 1: Enable checking of PREADY within a fixed N cycles
      int MAX_WAIT_CYCLES      = 2,   // Maximum wait cycles when PREADY goes high after PENABLE & PSEL;
                                      // Value of 0 means no wait states, i.e. PREADY is always high
      bit RST_CHECKS_ON        = 0,   // Set to 1: Enable reset checks. Use "reset -formal -bound 1 reset_expression" which this is set to 1.
      bit RECM_CHECKS_ON       = 1,   // Set to 1: Enable APB 3 recommended checks
      bit XCHECKS_ON           = 0,   // Set to 1: Enable APB 3 X-checks
      bit PERMIT_RD_X          = 0,   // Set to 1: When verifying masters that do not support pslverr, allow X's on prdata
      bit CONFIG_CSR_INTERFACE = 0,   // Set to 1: Enable ABVIP to connect with CSR-PA checker
      bit CONFIG_CSR_ADDR_ALIGN       = 0, // Set to 1: Enable ABVIP to generate address aligned with CSR width 
      bit CONFIG_CSR_DISCARD_ON_ERROR = 1  // Tune internal CSR logic behavior to handle the error response pslverr scenarios,
                                             // 0: Erroneous read/write data will be send to CSR checker  
                                             // 1: read/write transfer with pslverr will be discarded

      ) (

    //______________________________________________________APB 3 SIGNALS

      input  wire                      pclk,      // Clock
      input  wire                      presetn,   // Reset
      input  wire  [PSEL_N-1:0]        psel,      // Master: slave select line
      input  wire                      penable,   // Master: enable signal
                                                  //    When connected to a slave (PSEL_N == 1), qualify the common bus PENABLE signal with the slave's PSEL signal "PSELx", e.g.
                                                  //      .penable (PENABLE & PSELx),
      input  wire  [ABUS_WIDTH-1:0]    paddr,     // Master: address
      input  wire                      pwrite,    // Master: write request
      input  wire  [DBUS_WIDTH-1:0]    pwdata,    // Master: write data
      input  wire                      pready,    // Slave: ready signal
      input  wire  [DBUS_WIDTH-1:0]    prdata,    // Slave: read data
      input  wire                      pslverr    // Slave: error signal

          );

    // }}} INTERFACE ENDS HERE
    
    //____________________________________________________WIRE DECLARATIONS & ASSIGNMENTS

    // Signals for CSR-PA checker
    logic                     csr_wr_valid;       // connected to jasper_csr_extended_checker port "wr"
    logic [ABUS_WIDTH-1:0]    csr_wr_addr;        // connected to jasper_csr_extended_checker port "wr_addr"  
    logic [DBUS_WIDTH-1:0]    csr_wr_data;        // connected to jasper_csr_extended_checker port "din"
    logic                     csr_wr_secure;      // connected to jasper_csr_extended_checker port "wr_secure"
    logic [DBUS_WIDTH-1:0]    csr_wr_bit_mask;    // connected to jasper_csr_extended_checker port "wr_bit_mask"
    logic [DBUS_WIDTH/8-1:0]  csr_wr_byte_enable; // connected to jasper_csr_extended_checker port "wr_byte_enable"
    logic                     csr_rd_valid;       // connected to jasper_csr_extended_checker port "rd"
    logic [ABUS_WIDTH-1:0]    csr_rd_addr;        // connected to jasper_csr_extended_checker port "rd_addr"
    logic [DBUS_WIDTH-1:0]    csr_rd_data;        // connected to jasper_csr_extended_checker port "dout"
    logic                     csr_rd_secure;      // connected to jasper_csr_extended_checker port "rd_secure"
    logic [DBUS_WIDTH-1:0]    csr_rd_bit_mask;    // connected to jasper_csr_extended_checker port "rd_bit_mask"

    localparam bit NO_WAIT_STATES = ((MAX_WAIT_CYCLES_ON == 1) && (MAX_WAIT_CYCLES == 0));
    localparam PSEL_MAX = $clog2(PSEL_N);
    localparam int PADDR_ALIGN_BITS = $clog2(DBUS_WIDTH/8);

    //Current APB bus state
    typedef enum bit[1:0] {IDLE, SETUP, ACCESS, ERROR} apb_states_e;
    apb_states_e state;
    
    // Macro to define strength of liveness properties.  
    `ifdef JG_ABVIP_STRONG_SEMANTICS
      `define STRENGTH strong    //sv09 & above
    `else
      `define STRENGTH           //sv05 strong by default
    `endif
 
   //____________________________________________________PRINT AMBA CONFIGURATION
    // {{{

    `include "version.v"

    initial begin
        $display("-------------------------------------------------------------");
        $display("Cadence AMBA APB 3 Assertion Monitor Configuration");
        $display("  Module:   %L");
        $display("  Instance: %m");
        $display("  ABUS_WIDTH:       %d", ABUS_WIDTH);
        $display("  DBUS_WIDTH:       %d", DBUS_WIDTH);
        $display("  COVERAGE_ON:                %d", COVERAGE_ON);
        $display("  COVERGROUPS_ON:             %d", COVERGROUPS_ON);
        $display("  MAX_WAIT_CYCLES_ON:         %d", MAX_WAIT_CYCLES_ON);
        if (MAX_WAIT_CYCLES_ON) begin
            $display("    MAX_WAIT_CYCLES:%d", MAX_WAIT_CYCLES);
        end
        $display("  RST_CHECKS_ON:              %d", RST_CHECKS_ON);
        $display("  RECM_CHECKS_ON:             %d", RECM_CHECKS_ON);
        $display("  XCHECKS_ON:                 %d", XCHECKS_ON);
        $display("-------------------------------------------------------------");
    end

    // }}} // END OF PRINT AMBA CONFIGURATION


    //____________________________________________________Out of Reset logic
    // {{{
    reg out_of_reset;
    always_ff @(posedge pclk or negedge presetn) begin : flops
      if (!presetn) begin
        out_of_reset <= 1'b1; 
      end
      else if (presetn && out_of_reset) begin
        out_of_reset <= 1'b0; 
      end
      else begin
        out_of_reset <= out_of_reset; 
      end
    end

    // }}} // END OF Out of Reset logic

    //____________________________________________________previous psel logic
    // {{{
    reg [PSEL_N-1:0] psel_prev;
    always @ (posedge pclk or negedge presetn) begin
      if (~presetn) psel_prev <= 0;
      else psel_prev <= psel;
    end
    // }}} // END OF  previous psel logic

    //____________________________________________________which psel is high logic
    // {{{
    reg [PSEL_MAX:0] which_psel;
    always @* begin
       if (!presetn) begin
          which_psel = 0;
       end else begin
         if (|psel) begin
          for (int i=0 ; i<=PSEL_N-1 ; i++) begin
              if (psel[i] == 1) begin
                  which_psel = i;
              end
          end
         end else begin
                  which_psel = 0;
         end
       end
    end
    // }}} // END OF which psel is high logic

    //____________________________________________________APB state machine logic
    // {{{

  assign state = (~|(psel) && ~penable) ? IDLE   :
                 (|(psel) && ~penable)  ? SETUP  :
                 (|(psel) &&  penable) ? ACCESS :
                              ERROR ;
    
    // }}} // END OF APB state machine logic 

    //____________________________________________________CSR-PA Checker Integration
    // {{{

    generate
      if (CONFIG_CSR_INTERFACE == 1) begin: gen_csr_checker
        
        logic                     slv_error; 
        assign slv_error          = CONFIG_CSR_DISCARD_ON_ERROR ? pslverr : 1'b0;

        assign csr_wr_valid       = |psel & penable & pready &   pwrite  & !slv_error;
        assign csr_rd_valid       = |psel & penable & pready & (~pwrite) & !slv_error;
        assign csr_wr_addr        = paddr & {ABUS_WIDTH{csr_wr_valid}};
        assign csr_wr_data        = pwdata & {DBUS_WIDTH{csr_wr_valid}};
        assign csr_wr_secure      = 1'b0;
        assign csr_wr_bit_mask    = {DBUS_WIDTH{1'b1}};
        assign csr_wr_byte_enable = {(DBUS_WIDTH/8){1'b1}};
        assign csr_rd_addr        = paddr & {ABUS_WIDTH{csr_rd_valid}};
        assign csr_rd_data        = prdata & {DBUS_WIDTH{csr_rd_valid}};
        assign csr_rd_secure      = 1'b0;
        assign csr_rd_bit_mask    = {DBUS_WIDTH{1'b1}};
        
        jasper_csr_extended_checker
        #(
          .ADDR_WIDTH (ABUS_WIDTH),
          .DATA_WIDTH (DBUS_WIDTH)
         )
        inst(
          .clk           (pclk              ),
          .rstN          (presetn           ),
          .wr            (csr_wr_valid      ),
          .wr_addr       (csr_wr_addr       ),
          .din           (csr_wr_data       ),
          .wr_secure     (csr_wr_secure     ),
          .wr_bit_mask   (csr_wr_bit_mask   ),
          .wr_byte_enable(csr_wr_byte_enable),
          .rd            (csr_rd_valid      ),
          .rd_addr       (csr_rd_addr       ),
          .dout          (csr_rd_data       ),
          .rd_secure     (csr_rd_secure     ),
          .rd_bit_mask   (csr_rd_bit_mask   )
        );

        `ifdef CDNS_APB3_MASTER
        default disable iff !presetn;

        if(CONFIG_CSR_ADDR_ALIGN && (DBUS_WIDTH > 8)) begin : genAddrAlign
          // Short Description: Master should apply constraint to align addresses when CONFIG_CSR_ADDR_ALIGN is on
          master_csr_addr_alignment: assert property (@(posedge pclk) paddr[PADDR_ALIGN_BITS-1:0] == '0);
        end : genAddrAlign
        `endif // CDNS_APB3_MASTER

      end
      else begin
        assign csr_wr_valid       = '0;
        assign csr_wr_addr        = '0;
        assign csr_wr_data        = '0;
        assign csr_wr_secure      = '0;
        assign csr_wr_bit_mask    = '0;
        assign csr_wr_byte_enable = '0;
        assign csr_rd_valid       = '0;
        assign csr_rd_addr        = '0;
        assign csr_rd_data        = '0;
        assign csr_rd_secure      = '0;
        assign csr_rd_bit_mask    = '0;
      end
    endgenerate

    // }}} // END OF CSR-PA Checker Integration

    //___________________________________________________________________
    //
    // PROPERTIES
    //___________________________________________________________________
    // {{{
    
    //____________________________________________________RESET CHECKS
    // {{{

    // Default clocking block for all properties defined from here on
    clocking apb3_clk @(posedge pclk);
    endclocking
    default clocking apb3_clk;

    wire idle_state   = (~|psel && !penable);
    wire setup_state  = ( |psel && !penable);
    wire access_state = ( |psel &&  penable);

    if (RST_CHECKS_ON) begin: genRstChks

     default disable iff 1'b0;

    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : The default state for APB bus is IDLE
    // Critical Signals: psel, penable, presetn
    master_idle_during_reset: assert property (
       !presetn |-> idle_state);

    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : The default state for APB bus is IDLE
    // Critical Signals: psel, penable, presetn
    master_idle_after_reset_released: assert property (
      out_of_reset |-> idle_state);

    if (RECM_CHECKS_ON) begin: genRecmChkRst

    // APB Spec v1.0   : Section 2.3 on page 2-6
    // Description     : It is recommended that pslverr is low when it is not
    //                   being sampled. i.e. when any one of penable, psel and
    //                   pready are low. This should also be applicable during reset
    // Critical Signals: presetn, penable
    slave_pslverr_low_during_reset : assert property (
     !presetn  |-> !pslverr);

    end

    end  // genRstChks block ends here

    // }}} APB RESET CHECKS ENDS HERE

    // Default disable iff reset goes low
    default disable iff !presetn;

    //____________________________________________________APB XCHECKS
    // {{{

     if (XCHECKS_ON) begin: genXChks

    // APB Spec v1.0   : Section 2.1.1 on page 2-2
    // Description     : The address PADDR, write data PWDATA, and control signals
    //                   all remain valid until the transfer completes at the
    //                   end of the access phase
    // Critical Signals: psel, penable, pwrite, pwdata
    master_access_paddr_xcheck: assert property (
     setup_state |-> !$isunknown(paddr));

    master_access_pwrite_xcheck: assert property (
     setup_state |-> !$isunknown(pwrite));

    master_access_pwdata_xcheck : assert property (
    (setup_state && pwrite) |-> !$isunknown(pwdata));

    slave_access_pslverr_xcheck : assert property (
    (|psel && penable && pready) |-> !$isunknown(pslverr));

    // APB Spec v1.0   : Section 2.2.1 on page 2-4
    // Description     : A slave must provide valid data for READ transfers
    //                   in final transfer of ACCESS state
    // Critical Signals: prdata, penable, psel, pwrite, pready
    if (!PERMIT_RD_X) begin : genNoRDx
    slave_access_prdata_xcheck : assert property (
    (access_state && pready && !pwrite) |-> !$isunknown(prdata));
    end

    /*
    Note that X's are explicitly permitted on PRDATA when an error is incurred (PSLVERR = 1).  However, PSLVERR is an optional signal.
    For devices that do not support PSLVERR, the PSLVERR signal is tied low (inactive).
    It is not explicitly stated in the spec., but presumed that for devices that do not support PSLVERR, X's could appear on PRDATA
    when an error is incurred.  It is assumed that this condition is of interest, for the occurrence of a functional error if not for
    the X's, so the property is written to normally recognize this condition as an exception.  If the user prefers this to not be
    recognized as an exception, PERMIT_RD_X should be set to 1.

    Note that when this property is assumed (ABVIP is a slave), setting PERMIT_RD_X to 1 will allow values of X on PRDATA to be
    tested, whereas setting PERMIT_RD_X to 0 will not assume values of X on PRDATA.
    */

    if (PERMIT_RD_X) begin : genRDx
    slave_access_prdata_no_slverr_xcheck : assert property (
    (access_state && pready && !pslverr && !pwrite) |-> !$isunknown(prdata));
    end

      end  // genXChks block ends here

    // }}} APB XCHECKS ENDS HERE

    //____________________________________________________STABILITY ASSERTIONS
    // {{{

    if (RECM_CHECKS_ON) begin: genRecmStbChks

    // APB Spec v1.0   : Section 2.1.2 on page 2-3
    // Description     : It is recommended that the address and write signals are
    //                   not changed immediately after a transfer, but remain stable
    //                   until another access occurs. This reduces power consumption
    // Critical Signals: psel, penable, paddr
    master_idle_paddr_stable: assert property (
      (!out_of_reset && idle_state) |-> $stable(paddr));

    master_idle_pwrite_stable: assert property (
      (!out_of_reset && idle_state) |-> $stable(pwrite));
     
    end  // genRecmStbChks block ends here

    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : The address, write and select signals all remain stable
    //                   during the transition from SETUP to ACCESS state
    // Critical Signals: psel, penable, pwrite, paddr, pwdata
    master_setup_psel_stable: assert property (
     setup_state |=> $stable(psel));

    master_setup_paddr_stable: assert property (
     setup_state |=> $stable(paddr));

    master_setup_pwrite_stable: assert property (
     setup_state |=> $stable(pwrite));

    master_setup_pwdata_stable: assert property (
     (setup_state && pwrite) |=> $stable(pwdata));

    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : If PREADY is held low by slave then the peripheral bus 
    //                   remains in the ACCESS state and all signals have to be stable
    // Critical Signals: psel, penable, pready, paddr, pwrite, pwdata 
    if (!NO_WAIT_STATES) begin: stable_checks
      master_access_penable_stable: assert property (
      (access_state && !pready) |=> penable);

      master_access_psel_stable: assert property (
      (access_state && !pready) |=> $stable(psel));

      master_access_paddr_stable: assert property (
      (access_state && !pready) |=> $stable(paddr));

      master_access_pwrite_stable: assert property (
      (access_state && !pready) |=> $stable(pwrite));

      master_access_pwdata_stable: assert property (
      (access_state && !pready && pwrite) |=> $stable(pwdata));
    end: stable_checks
    // }}} STABILITY ASSERTIONS ENDS HERE

    //____________________________________________________APB TRANSITION ASSERTIONS
    // {{{

    // APB Spec v2.0   : Section 2.1
    // Description     : Penable can only be asserted one clock after psel for that transfer
    // Critical Signals: psel, penable
    master_never_penable_first_clock : assert property (
    !(|psel_prev) |-> !penable);


    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : Master cannot transition directly from IDLE state to ACCESS state
    // Critical Signals: psel, penable
    master_never_idle_to_access: assert property (
     idle_state |=> !penable);

    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : The bus only remains in the SETUP state for one clock cycle
    //                   and always moves to the ACCESS state on the next
    //                   rising edge of the clock
    // Critical Signals: psel, penable
    master_setup_to_access: assert property (
     setup_state |=> access_state);

    // APB Spec v1.0   : Section 3.1 on page 3-3
    // Description     : If PREADY is driven HIGH by the slave then the ACCESS
    //                   is exited
    // Critical Signals: psel, penable
    master_exit_access: assert property (
     (access_state && pready) |=> !penable);

    // APB Spec v1.0   : Section 3.1 on page 3-2
    // Description     : PENABLE can not go high while PSEL is low
    //                   is exited
    // Critical Signals: psel, penable
    master_never_penable_without_psel: assert property (
     !(~|psel && penable));

    // psel is slave select signal. Master selects at most one slave at a time.
    if (PSEL_N > 1) begin: onehot
     master_select_at_most_one_slave: assert property (
      |psel |-> $onehot(psel));
    end: onehot

     if (RECM_CHECKS_ON) begin: genRecmTrnChks

    // APB Spec v1.0   : Section 2.3 on page 2-6
    // Description     : It is recommended that pslverr is low when it is not
    //                   being sampled. i.e. when any one of penable, psel and
    //                   pready are low.
    // Critical Signals: penable, psel, pready, pslverr
    slave_pslverr_last_access : assert property (
     !(access_state && pready)  |-> !pslverr);

     end  // genRecmTrnChks block ends here


    // }}} APB TRANSITION ASSERTIONS ENDS HERE

    //____________________________________________________MAX WAIT CYCLES
    // {{{

     if (NO_WAIT_STATES) begin: nowaitstates

    // APB Spec v1.0   : Section 2.1.1 on page 2-2
    // Description     : If MAX_WAIT_CYCLES_ON = 1 and MAX_WAIT_CYCLES = 0,
    //                   then there are no wait states, and pready must
    //                   always be high when (psel & penable).
    // Critical Signals: penable, psel, pready
    slave_pready_no_wait_cycles : assert property (
     access_state |-> pready);

     end: nowaitstates

     if (MAX_WAIT_CYCLES_ON && (MAX_WAIT_CYCLES != 0)) begin: genWaitChks

    // APB Spec v1.0   : Section 2.1.2 on page 2-2
    // Description     : The maximum number of cycles for which PREADY
    //                   remains low after entering ACCESS state must not
    //                   exceed the MAX_WAIT_CYCLES specified
    // Critical Signals: penable, psel, pready
    slave_pready_wait_cycles : assert property (
     (access_state && !pready)  |-> (!pready[*1:MAX_WAIT_CYCLES] ##1 pready));

     end: genWaitChks

     if (!MAX_WAIT_CYCLES_ON) begin: genLiveChks

    // APB Spec v1.0   : Section 2.1.2 on page 2-2
    // Description     : PREADY must eventually go high
    // Critical Signals: penable, psel, pready
    slave_pready_eventually : assert property (
     (access_state && !pready)  |-> `STRENGTH(##[0:$] pready));

     end: genLiveChks

    // }}} MAX WAIT CYCLES ENDS HERE

    // }}} PROPERTIES ENDS HERE

    if (COVERAGE_ON) begin: genCov

    //____________________________________________________COVERAGE_ON
    // {{{

    //____________________________________________________APB TRANSITION COVERS

      cover_idle_state              : cover property (idle_state);
      cover_setup_state             : cover property (setup_state);
      cover_access_state            : cover property (access_state);
      cover_setup_after_idle_state  : cover property (idle_state ##1 setup_state);
      cover_access_after_setup_state: cover property (setup_state ##1 access_state);
      cover_setup_after_access_state: cover property (access_state ##1 setup_state);
      cover_idle_after_access_state : cover property (access_state ##1 idle_state);
      cover_idle_after_idle_state   : cover property (idle_state ##1 idle_state);

    //____________________________________________________READ & WRITE COVERS

      cover_write_transfer          : cover property  ((pwrite && setup_state) ##1
                                                       (pwrite && access_state));
      cover_read_transfer           : cover property ((!pwrite && setup_state) ##1
                                                      (!pwrite && access_state));
      if (!NO_WAIT_STATES) begin: nnw
        cover_write_transfer_with_wait_states: cover property (
                                                      (pwrite && access_state && !pready)[*1:$] ##1
                                                      (pwrite && access_state &&  pready));
        cover_read_transfer_with_wait_states : cover property (
                                                      (!pwrite && access_state && !pready)[*1:$] ##1
                                                      (!pwrite && access_state &&  pready));
      end: nnw

      cover_burst_of_write_transfers       : cover property (
                                                    ((pwrite && setup_state) ##1
                                                    ( pwrite && access_state && !pready)[*0:$] ##1
                                                    ( pwrite && access_state && pready))[*2]);
      cover_burst_of_read_transfers        : cover property (
                                                   ((!pwrite && setup_state) ##1
                                                    (!pwrite && access_state && !pready)[*0:$] ##1
                                                    (!pwrite && access_state && pready))[*2]);

      cover_read_after_write_transfer      : cover property (
                                                     (pwrite && setup_state) ##1
                                                     (pwrite && access_state)[*1:$] ##1
                                                    (!pwrite && setup_state) ##1
                                                    (!pwrite && access_state));
      cover_write_after_read_transfer      : cover property (
                                                    (!pwrite && setup_state) ##1
                                                    (!pwrite && access_state)[*1:$] ##1
                                                     (pwrite && setup_state) ##1
                                                     (pwrite && access_state));

    end // genCov block ends here

    // }}} COVERAGE_ON ENDS HERE

    //____________________________________________________

    //Covergroups

    generate

    if (COVERGROUPS_ON) begin : genCG

    covergroup signal_values_cg @(posedge pclk);
       option.per_instance = 1;
       option.name = "cover_apb3_monitor";
       
       cp_paddr : coverpoint paddr {
         bins eight_bit = {8'h00, 8'h0f, 8'h10, 8'hf0, 8'hff};
         bins sixteen_bit = {16'h01ff, 16'h0f00, 16'h1f00, 16'hff00, 16'hffff};
         bins thirty2_bit = {32'h0001ffff, 32'h00ff00ff, 32'h55555555, 32'haaaaaaaa, 32'hffffffff, 32'hffff0000};
       }


       cp_psel : coverpoint which_psel {
          ignore_bins unwanted = {[PSEL_N : $]};
       } 

       cp_pwrite : coverpoint pwrite iff (state==ACCESS);

       cp_pslverr : coverpoint pslverr iff (state==ACCESS && !pwrite && pready);

       cp_state_transition : coverpoint state {
         bins tran_idle_setup = (IDLE => SETUP);
         bins tran_setup_access = (SETUP => ACCESS);
         bins tran_access_idle = (ACCESS => IDLE);
         bins tran_access_setup = (ACCESS => SETUP);
         bins tran_idle_setup_access = (IDLE => SETUP => ACCESS);
         bins tran_access_wait = (SETUP => ACCESS => ACCESS => ACCESS);
       }

       cp_wait_states : coverpoint pready iff (state==ACCESS && !NO_WAIT_STATES) {
         bins wait_state = (0=>0=>1);
       }

    endgroup

    signal_values_cg signal_values_cg_inst = new();

    end //genCG
    endgenerate
    
    //Covergroups end

endmodule
`undef CDNS_MODULE_NAME
`undef CDNS_APPLY_MASTER
`undef CDNS_APPLY_SLAVE
//__RTL_GEN_CODE_2__
