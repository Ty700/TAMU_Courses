/**************************************************************************/
/**************************************************************************
 *
 * MODULE: apb_master
 * 
 * FILE NAME: apb_master.v
 *
 *
 * Cadence Proprietary Information
 * (c) 2011 Cadence Design Systems, Inc, San Jose, CA
 * All Rights Reserved
 *
 * 
 * DATE:Dec1, 2011
 * AUTHOR:Cadence Design Systems,Inc
 * 
 * CODE TYPE : RTL
 *  
 * Description:The RTL design of APB Master
 *  
 *************************************************************************/

module apb_master(
    pclk_i,
    presetn_i,
    sys_ready_i,
    sys_addr_i,
    sys_data_i,
    sys_write_i,
    prdata_i,
    pready_i,
    paddr_o,
    pwrite_o,
    pwdata_o,
    penable_o,
    pslverr_i,
    psel_o
);   
    parameter ABUS_WIDTH      = 32;
    parameter DBUS_WIDTH      = 32;
   
    input                        presetn_i;
    input                        pclk_i;
    input                        sys_ready_i;  // System Transfer ready for Master
    input [ABUS_WIDTH-1:0]       sys_addr_i;   // System Transfer address for Master
    input [DBUS_WIDTH-1:0]       sys_data_i;   // System Transfer data for Master write data or read compare data
    input                        sys_write_i;  // System Transfer type (1=Write 0=Read)
    input [DBUS_WIDTH-1:0]       prdata_i;
    input                        pready_i;
    output [ABUS_WIDTH-1:0]      paddr_o;
    output                       pwrite_o;
    output [DBUS_WIDTH-1:0]      pwdata_o;
    output                       penable_o;
    output                       psel_o;
    input                       pslverr_i;
    reg [ABUS_WIDTH-1:0]         paddr_o;
    reg                          pwrite_o;
    reg [DBUS_WIDTH-1:0]         pwdata_o;
    reg                          penable_o;
    reg                          psel_o;
    localparam [1:0] IDLE_STATE   = 2'b00;
    localparam [1:0] SETUP_STATE  = 2'b01;
    localparam [1:0] ACCESS_STATE = 2'b10;

    localparam IDLE = 2'b00;
    localparam BUSY = 2'b01;
    localparam NONSEQ = 2'b10;
    localparam SEQ  = 2'b11;

    localparam OKAY  = 2'b00;
    localparam ERROR = 2'b01;
    localparam RETRY = 2'b10;
    localparam SPLIT = 2'b11;
 
    reg [1:0]             state;

    wire idle_state   = (!psel_o && !penable_o);
    wire setup_state  = ( psel_o && !penable_o);
    wire access_state = ( psel_o &&  penable_o);

    property slave_access_rdata_check;
      @(posedge pclk_i) disable iff (!presetn_i) 
        (psel_o && penable_o && !pwrite_o && pready_i) |-> (prdata_i == sys_data_i);
    endproperty

   
    always @(posedge pclk_i)
      begin : APB_FSM
        if(!presetn_i)
          begin
            state       <= IDLE_STATE;
            paddr_o     <= {ABUS_WIDTH{1'b0}};
            pwrite_o    <= 1'b0;
            pwdata_o    <= {DBUS_WIDTH{1'b0}};
            penable_o   <= 1'b0;
            psel_o      <= 1'b0;
          end
        else
          begin
            case(state)
              IDLE_STATE : begin
                if (sys_ready_i ) begin   // system transfer available, go to SETUP state
                  state <= SETUP_STATE;
		  if(!sys_write_i) begin  // start APB read transfer
		    paddr_o     <= sys_addr_i;
                    pwrite_o    <= 1'b0;
                    penable_o   <= 1'b0;
                    psel_o      <= 1'b1;
                    pwdata_o    <= pwdata_o;
                  end
                  else begin              // start APB write transfer
		    paddr_o     <= sys_addr_i;
                    pwrite_o    <= 1'b1;
                    penable_o   <= 1'b0;
                    psel_o      <= 1'b1;
                    pwdata_o    <= sys_data_i; // Write data updated in SETUP state
                  end
	        end
                else begin               // stay in IDLE state
                  state <= IDLE_STATE;
                  paddr_o     <= paddr_o;
                  pwrite_o    <= pwrite_o;
                  penable_o   <= 1'b0;
                  psel_o      <= 1'b0;
                  pwdata_o    <= pwdata_o;
                end
	      end
              SETUP_STATE : begin
                state <= ACCESS_STATE;     // Always go to ACCESS state directly
                paddr_o     <= paddr_o;
                pwrite_o    <= pwrite_o;
                penable_o   <= 1'b1;
                psel_o      <= 1'b1;
                pwdata_o    <= pwdata_o;
              end
              ACCESS_STATE : begin
                if (sys_ready_i) begin      
                  if (pready_i) begin       // current APB transfer done, next system transfer available, go back to SETUP state
                    if(!pwrite_o) begin     // current APB transfer is read so check read data
                      assert_rdata_check_sys_ready: assert property (slave_access_rdata_check);
                    end
                    state <= SETUP_STATE;
                    if(!sys_write_i) begin  // start next APB read transfer
		      paddr_o     <= sys_addr_i;
                      pwrite_o    <= 1'b0;
                      penable_o   <= 1'b0;
                      psel_o      <= 1'b1;
                      pwdata_o    <= pwdata_o;
                    end
                    else begin              // start next APB write transfer
		      paddr_o     <= sys_addr_i;
                      pwrite_o    <= 1'b1;
                      penable_o   <= 1'b0;
                      psel_o      <= 1'b1;
                      pwdata_o    <= sys_data_i; // Write data updated in SETUP state
                    end
                  end
                  else begin                // current APB transfer not done, stay in ACCESS state
                    state <= ACCESS_STATE;
		    paddr_o     <= paddr_o;
                    psel_o      <= 1'b1;
                    pwrite_o    <= pwrite_o;
                    penable_o   <= 1'b1;
                    pwdata_o    <= pwdata_o;
                  end
                end
                else begin
                  if (pready_i) begin       // current APB transfer done, no new system transfer, go to IDLE state
                    if(!pwrite_o) begin     // current APB transfer is read so check read data
                      assert_rdata_check_not_sys_ready: assert property (slave_access_rdata_check);
                    end
                    state <= IDLE_STATE;
		    paddr_o     <= paddr_o;
                    pwrite_o    <= pwrite_o;
                    penable_o   <= 1'b0;
                    psel_o      <= 1'b0;
                    pwdata_o    <= pwdata_o;
                  end
                  else begin                // current APB transfer not done, stay in ACCESS state
                    state <= ACCESS_STATE;
		    paddr_o     <= paddr_o;
                    psel_o      <= 1'b1;
                    pwrite_o    <= pwrite_o;
                    penable_o   <= 1'b1;
                    pwdata_o    <= pwdata_o;
                  end
                end
              end
            endcase
          end
      end   // APB_FSM

endmodule // ahb2apb_bridge
