`timescale 1ns/1ns

module alu_test();
  
  reg c_clk;
  reg [3:0] req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
  reg [31:0] req1_data_in, req2_data_in, req3_data_in, req4_data_in;
  reg [6:0] reset;  
  
  wire [1:0] out_resp1, out_resp2, out_resp3, out_resp4;
  wire [31:0] out_data1, out_data2, out_data3, out_data4;
  
  integer timeout;
  
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
      
                
      //test addition ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0001; req1_data_in = 32'h80002345; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00010000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end
      if (!(out_data1 === 32'h80012345)) begin
        $display("error at port 1 addition outVal: %b0, respVal: %b", out_data1, out_resp1);
      end      
      // port 2 #######################################################################
      req2_cmd_in = 4'b0001; req2_data_in = 32'h80002345; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00010000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 			timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data2 === 32'h80012345)) begin
        $display("error at port 2 addition");
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0001; req3_data_in = 32'h80002345; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00010000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data3 === 32'h80012345)) begin
        $display("error at port 3 addition");
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0001; req4_data_in = 32'h80002345; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00010000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data4 === 32'h80012345)) begin
        $display("error at port 4 addition outVal: %b0, respVal: %b", out_data4, out_resp4);
      end
      
      //test substraction ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0010; req1_data_in = 32'hFFFFFFFF; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h11111111;  
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end      
      if (!(out_data1 === 32'hEEEEEEEE)) begin
        $display("error at port 1 substraction");
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0010; req2_data_in = 32'hFFFFFFFF; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h11111111; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data2 === 32'hEEEEEEEE)) begin
        $display("error at port 2 substraction");
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0010; req3_data_in = 32'hFFFFFFFF; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h11111111;  
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end     
      if (!(out_data3 === 32'hEEEEEEEE)) begin
        $display("error at port 3 substraction");
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0010; req4_data_in = 32'hFFFFFFFF; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h11111111; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data4 === 32'hEEEEEEEE)) begin
        $display("error at port 4 substraction outVal: %b0, respVal: %b", out_data4, out_resp4);
      end

      
      //test shift left ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0101; req1_data_in = 32'h00000001; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h80000000)) begin
        $display("error at port 1 shift left outVal: %b", out_data1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0101; req2_data_in = 32'h00000001; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h80000000)) begin
        $display("error at port 2 shift left outVal: %b", out_data2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0101; req3_data_in = 32'h00000001; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h80000000)) begin
        $display("error at port 3 shift left outVal: %b", out_data3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0101; req4_data_in = 32'h00000001; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h80000000)) begin
        $display("error at port 4 shift left outVal: %b", out_data4);
      end

      //test shift right ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0110; req1_data_in = 32'h80000000; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h00000001)) begin
        $display("error at port 1 shift right outVal: %b", out_data1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0110; req2_data_in = 32'h80000000; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h00000001)) begin
        $display("error at port 2 shift right outVal: %b", out_data2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0110; req3_data_in = 32'h80000000; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h00000001)) begin
        $display("error at port 3 shift right outVal: %b", out_data3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0110; req4_data_in = 32'h80000000; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h000001FF;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h00000001)) begin
        $display("error at port 4 shift right outVal: %b", out_data4);
      end
      
     
      //test underflow ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0010; req1_data_in = 32'h11111111; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp1 === 2'b10)) begin
        $display("error at port 1 underflow outVal: %b, respVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0010; req2_data_in = 32'h11111111; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp2 === 2'b10)) begin
        $display("error at port 2 underflow outVal: %b, respVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0010; req3_data_in = 32'h11111111; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp3 === 2'b10)) begin
        $display("error at port 3 underflow outVal: %b, respVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0010; req4_data_in = 32'h11111111; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end        
      if (!(out_resp4 === 2'b10)) begin
        $display("error at port 4 underflow outVal: %b, respVal: %b", out_data4, out_resp4);
      end
      
      //test overflow ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0001; req1_data_in = 32'hFFFFFFFF; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp1 === 2'b10)) begin
        $display("error at port 1 overflow outVal: %b, respVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0001; req2_data_in = 32'hFFFFFFFF; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp2 === 2'b10)) begin
        $display("error at port 2 overflow outVal: %b0, respVal: %b0", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0001; req3_data_in = 32'hFFFFFFFF; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp3 === 2'b10)) begin
        $display("error at port 3 overflow outVal: %b, respVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0001; req4_data_in = 32'hFFFFFFFF; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp4 === 2'b10)) begin
        $display("error at port 4 overflow outVal: %b, respVal: %b", out_data4, out_resp4);
      end    
      
      //test underflow by 1****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0010; req1_data_in = 32'h11111111; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h11111112;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp1 === 2'b10)) begin
        $display("error at port 1 underflow by 1 outVal: %b, respVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0010; req2_data_in = 32'h11111111; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp2 === 2'b10)) begin
        $display("error at port 2 underflow by 1 outVal: %b, respVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0010; req3_data_in = 32'h11111111; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_resp3 === 2'b10)) begin
        $display("error at port 3 underflow by 1 outVal: %b, respVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0010; req4_data_in = 32'h11111111; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h20000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end        
      if (!(out_resp4 === 2'b10)) begin
        $display("error at port 4 underflow by 1 outVal: %b, respVal: %b", out_data4, out_resp4);
      end
      

   
      //test sum add two numbers whose sum is FFFFFFFF ****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0001; req1_data_in = 32'hEEEEEEEE; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h11111111; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data1 === 32'hFFFFFFFF)) begin
        $display("error at port 1 sum FFFFFFFF outVal: %b, repVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0001; req2_data_in = 32'hEEEEEEEE; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h11111111; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data2 === 32'hFFFFFFFF)) begin
        $display("error at port 2 sum FFFFFFFF outVal: %b, repVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0001; req3_data_in = 32'hEEEEEEEE; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h11111111; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data3 === 32'hFFFFFFFF)) begin
        $display("error at port 3 sum FFFFFFFF outVal: %b, repVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0001; req4_data_in = 32'hEEEEEEEE; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h11111111; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data4 === 32'hFFFFFFFF)) begin
        $display("error at port 4 sum FFFFFFFF outVal: %b, repVal: %b", out_data4, out_resp4);
      end
    
      //test substraction 2 equal numbers****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0010; req1_data_in = 32'hFFFFFFFF; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'hFFFFFFFF;  
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end      
      if (!(out_resp1 === 2'b01)) begin
        $display("error at port 1 substraction 2equal numbers outVal: %b, repVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0010; req2_data_in = 32'hFFFFFFFF; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'hFFFFFFFF; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data2 === 32'h00000000)) begin
        $display("error at port 2 substraction 2equal numbers outVal: %b, repVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0010; req3_data_in = 32'hFFFFFFFF; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'hFFFFFFFF;  
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end     
      if (!(out_data3 === 32'h00000000)) begin
        $display("error at port 3 substraction 2equal numbers outVal: %b, repVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0010; req4_data_in = 32'hFFFFFFFF; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'hFFFFFFFF; 
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;
		  end       
      if (!(out_data4 === 32'h00000000)) begin
        $display("error at port 4 substraction 2equal numbers outVal: %b, repVal: %b", out_data4, out_resp4);
      end
       
     
      //test shift left 0 places****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0101; req1_data_in = 32'h00000010; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h00000010)) begin
        $display("error at port 1 shift left 0 places outVal: %b, repVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0101; req2_data_in = 32'h00000010; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h00000010)) begin
        $display("error at port 2 shift left 0 places outVal: %b, repVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0101; req3_data_in = 32'h00000010; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h00000010)) begin
        $display("error at port 3 shift left 0 places outVal: %b, repVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0101; req4_data_in = 32'h00000010; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h00000010)) begin
        $display("error at port 4 shift left 0 places outVal: %b, repVal: %b", out_data4, out_resp4);
      end
  

      //test shift right 0 places****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0110; req1_data_in = 32'h08000000; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h08000000)) begin
        $display("error at port 1 shift right 0 places outVal: %b, repVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b0110; req2_data_in = 32'h08000000; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h08000000)) begin
        $display("error at port 2 shift right 0 places outVal: %b, repVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b0110; req3_data_in = 32'h08000000; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h08000000)) begin
        $display("error at port 3 shift right 0 places outVal: %b, repVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b0110; req4_data_in = 32'h08000000; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00000000;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h08000000)) begin
        $display("error at port 4 shift right 0 places outVal: %b, repVal: %b", out_data4, out_resp4);
      end
            
      //test illegal command****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b1000; req1_data_in = 32'h08000000; @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_resp1 === 2'b10)) begin
        $display("error at port 1 illegal command outVal: %b, repVal: %b", out_data1, out_resp1);
      end
      //port 2 #######################################################################
      req2_cmd_in = 4'b1000; req2_data_in = 32'h08000000; @(negedge c_clk); req2_cmd_in = 4'b0000; req2_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_resp2 === 2'b10)) begin
        $display("error at port 2 illegal command outVal: %b, repVal: %b", out_data2, out_resp2);
      end
      //port 3 #######################################################################
      req3_cmd_in = 4'b1000; req3_data_in = 32'h08000000; @(negedge c_clk); req3_cmd_in = 4'b0000; req3_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_resp3 === 2'b10)) begin
        $display("error at port 3 illegal command outVal: %b, repVal: %b", out_data3, out_resp3);
      end
      //port 4 #######################################################################
      req4_cmd_in = 4'b1000; req4_data_in = 32'h08000000; @(negedge c_clk); req4_cmd_in = 4'b0000; req4_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_resp4 === 2'h2)) begin
        $display("error at port 4 illegal command outVal: %b, repVal: %b", out_data4, out_resp4);
      end
      

  end  
  
  task reset_sys;
    reset = 7'b0000000;
    @(negedge c_clk);
    reset = 7'b1111111;
    reset = 7'b0000000;
  endtask
  

endmodule
