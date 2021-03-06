`timescale 1ns/1ns

module alu_test();
  
  reg c_clk;
  reg [3:0] req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
  reg [31:0] req1_data_in, req2_data_in, req3_data_in, req4_data_in;
  reg [6:0] reset;  
  
  wire [1:0] out_resp1, out_resp2, out_resp3, out_resp4;
  wire [31:0] out_data1, out_data2, out_data3, out_data4;
  
  calc1_top uut(
    .c_clk(c_clk),
    .req1_cmd_in(req1_cmd_in),
    .req2_cmd_in(req2_cmd_in),
    .req3_cmd_in(req3_cmd_in),
    .req4_cmd_in(req4_cmd_in),
    .reset(reset),
    .req1_data_in(req1_data_in), 
    .req2_data_in(req2_data_in), 
    .req3_data_in(req3_data_in), 
    .req4_data_in(req4_data_in),
    .out_resp1(out_resp1), 
    .out_resp2(out_resp2), 
    .out_resp3(out_resp3), 
    .out_resp4(out_resp4),
    .out_data1(out_data1), 
    .out_data2(out_data2), 
    .out_data3(out_data3), 
    .out_data4(out_data4)  
  );
  
  initial begin 
    c_clk = 0;
    forever #30 c_clk = ~c_clk;
  end
  
  initial begin

      reset_sys;
      
      //test addition
      req1_cmd_in = 4'b0001; req1_data_in = 32'h80002345; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00010000;       
      if (!(out_data1 === 31'h80012345)) begin
        $display("error at port 1 addition");
      end
      req2_cmd_in = 4'b0001; req2_data_in = 32'h80002345; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00010000;       
      if (!(out_data1 === 31'h80012345)) begin
        $display("error at port 2 addition");
      end
      req3_cmd_in = 4'b0001; req3_data_in = 32'h80002345; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00010000;       
      if (!(out_data1 === 31'h80012345)) begin
        $display("error at port 3 addition");
      end
      req4_cmd_in = 4'b0001; req4_data_in = 32'h80002345; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00010000;       
      if (!(out_data1 === 31'h80012345)) begin
        $display("error at port 4 addition");
      end
      
      //test substraction
      req1_cmd_in = 4'b0010; req1_data_in = 32'hFFFFFFFF; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h11111111;       
      if (!(out_data1 === 31'hEEEEEEEE)) begin
        $display("error at port 1 substraction");
      end
      req2_cmd_in = 4'b0010; req2_data_in = 32'hFFFFFFFF; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h11111111;       
      if (!(out_data1 === 31'hEEEEEEEE)) begin
        $display("error at port 2 substraction");
      end
      req3_cmd_in = 4'b0010; req3_data_in = 32'hFFFFFFFF; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h11111111;       
      if (!(out_data1 === 31'hEEEEEEEE)) begin
        $display("error at port 3 substraction");
      end
      req4_cmd_in = 4'b0010; req4_data_in = 32'hFFFFFFFF; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h11111111;       
      if (!(out_data1 === 31'hEEEEEEEE)) begin
        $display("error at port 4 substraction");
      end
      
      //test underflow
      req1_cmd_in = 4'b0010; req1_data_in = 32'h11111111; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h20000000;       
      if (!(out_resp1 === 2'b10)) begin
        $display("error at port 1 underflow");
      end
      req2_cmd_in = 4'b0010; req2_data_in = 32'h11111111; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h20000000;       
      if (!(out_resp2 === 2'b10)) begin
        $display("error at port 2 underflow");
      end
      req3_cmd_in = 4'b0010; req3_data_in = 32'h11111111; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h20000000;       
      if (!(out_resp3 === 2'b10)) begin
        $display("error at port 3 underflow");
      end
      req4_cmd_in = 4'b0010; req4_data_in = 32'h11111111; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h20000000;       
      if (!(out_resp4 === 2'b10)) begin
        $display("error at port 4 underflow");
      end
      
      //test overflow
      req1_cmd_in = 4'b0001; req1_data_in = 32'hFFFFFFFF; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00000001;       
      if (!(out_resp1 === 2'b10)) begin
        $display("error at port 1 overflow");
      end
      req2_cmd_in = 4'b0001; req2_data_in = 32'hFFFFFFFF; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00000001;       
      if (!(out_resp2 === 2'b10)) begin
        $display("error at port 2 overflow");
      end
      req3_cmd_in = 4'b0001; req3_data_in = 32'hFFFFFFFF; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00000001;       
      if (!(out_resp3 === 2'b10)) begin
        $display("error at port 3 overflow");
      end
      req4_cmd_in = 4'b0001; req4_data_in = 32'hFFFFFFFF; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00000001;       
      if (!(out_resp4 === 2'b10)) begin
        $display("error at port 4 overflow");
      end
      
      
    
 
  end  
  
  task reset_sys;
    reset = 7'b0000000;
    @(negedge c_clk);
    reset = 7'b1111111;
    reset = 7'b0000000;
  endtask
  
//      always
//      begin
//        c_clk <= 1; #5;
//        c_clk <= 0; #5;
//      end    
endmodule
