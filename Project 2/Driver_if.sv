/////////////////////////////////////////////////////////////////////////
// Purpose: Driver Interface for Project2_COEN413
/////////////////////////////////////////////////////////////////////////

interface driver_if;
    bit c_clk;
    bit reset;
    
    bit [3:0] req_cmd_in;
    bit [3:0] req1_cmd_in;
    bit [3:0] req2_cmd_in;
    bit [3:0] req3_cmd_in;
    bit [3:0] req4_cmd_in;
    
    bit [20:0] A;
    bit CE_b;
    bit WE_b;
    bit OE_b;
    wire [7:0] DQ;
      
    modport master (output A, CE_b, WE_b, OE_b, inout DQ);

endinterface
