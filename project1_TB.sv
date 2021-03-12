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
        $display("error at port 1 addition");
      end      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 addition port 21outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 addition port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 addition port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 addition port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 addition port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 addition port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 addition port 3 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 addition port 3 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 addition port 3 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 addition");
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 addition port 4 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 addition port 4 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 addition port 4 outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 substraction port 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 substraction port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 substraction port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 subtraction port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 subtraction port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 subtraction port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 subtraction port 3 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 subtraction port 3 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 subtraction port 3 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 substraction");
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 substraction port 4 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 substraction port 4 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 substraction port 4 outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 shift left outVal: %0b", out_data1);
      end
      
         
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 shift left port 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 shift left port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 shift left port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 shift left outVal: %0b", out_data2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 shift left port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 shift left port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error anonzerp port 4 shift left port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 shift left outVal: %0b", out_data3);
      end
        
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 shift left port 3 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 shift left port 3 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 shift left port 3 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 shift left outVal: %0b", out_data4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 shift left port 4 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 shift left port 4 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 shift left port 4 outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 shift right outVal: %0b", out_data1);
      end
      
    
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 shift right port 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 shift right port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 shift right port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 shift right outVal: %0b", out_data2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 shift right port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 shift right port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 shift right port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 shift right outVal: %0b", out_data3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 shift right port 3 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 shift right port 3 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 shift right port 3 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 shift right outVal: %0b", out_data4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift right outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift right outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift right outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 underflow outVal: %b0, respVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 underflow port 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 underflow port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 underflow port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 underflow outVal: %b0, respVal: %b0", out_data2, out_resp2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 underflow port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 underflow port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 underflow port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 underflow outVal: %b0, respVal: %b0", out_data3, out_resp3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 underflow port 3 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 underflow port 3 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 underflow port 3 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 underflow outVal: %b0, respVal: %b0", out_data4, out_resp4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 underflow port 4 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 underflow port 4 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 underflow port 4 outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 overflow outVal: %b0, respVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 overflow port 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 overflow port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 overflow port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 overflow port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 overflow port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 overflow port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 overflow outVal: %b0, respVal: %b0", out_data3, out_resp3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 overflow port 3 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 overflow port 3 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 overflow port 3 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 overflow outVal: %b0, respVal: %b0", out_data4, out_resp4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 overflow port 4 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 overflow port 4 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 overflow port 4 outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 underflow by 1 outVal: %b0, respVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 underflow by 1 port 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 underflow by 1 port 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 underflow by 1 port 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 underflow by 1 outVal: %b0, respVal: %b0", out_data2, out_resp2);
      end
      
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error nonzero port 1 underflow by 1 port 2 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 underflow by 1 port 2 outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 underflow by 1 port 2 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 underflow by 1 outVal: %b0, respVal: %b0", out_data3, out_resp3);
      end
      
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 underflow by 1 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 underflow by 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 underflow by 1 outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 underflow by 1 outVal: %b0, respVal: %b0", out_data4, out_resp4);
      end
      
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 underflow by 1 outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 underflow by 1 outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 underflow by 1 outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
    
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 sum FFFFFFFF outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
      if (!(out_data1 === 32'h00000000)) begin
        $display("error at port 1 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
       
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 substraction 2equal numbers outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 shift left 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift left 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift left 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 shift left 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 shift left 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift left 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift left 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 shift left 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 shift left 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift left 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift left 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 shift left 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 shift left 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift left 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift left 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift left 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 shift right 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end

      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift right 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift right 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 shift right 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 shift right 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift right 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift right 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 shift right 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 shift right 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end

      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift right 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift right 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 shift right 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 4 shift right 0 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 shift right 0 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 shift right 0 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 shift right 0 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
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
        $display("error at port 1 illegal command outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 illegal command outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 illegal command outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 illegal command outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 2 illegal command outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 illegal command outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 illegal command outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 illegal command outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
        $display("error at port 3 illegal command outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 illegal command outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 illegal command outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error at port 4 illegal command outVal: %b0, repVal: %b0", out_data4, out_resp4);
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
      if (!(out_resp4 === 2'b10)) begin
        $display("error at port 4 illegal command outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      
      if (!(out_resp1 === 2'b00) || !(out_data1 === 32'h00000000)) begin
        $display("error at port 1 illegal command outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error at port 2 illegal command outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error at port 3 illegal command outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      // COPIED ONE OF THE SHIFT TESTS AND SHIFT BY 1 INSTEAD OF 0
      //test shift left 1 places****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0101; req1_data_in = 32'h00000010;
      @(negedge c_clk); req1_cmd_in = 4'b0000; req1_data_in = 32'h00000001;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h00000020)) begin
        $display("error at port 1 shift left 1 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      // here is part of row 'Check that the high-order 27 bits are ignored in the second operand of both shift commands.'
      //test shift left 1 places ignores top bit****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0101; req1_data_in = 32'h00000010;
      @(negedge c_clk);
      req1_cmd_in = 4'b0000; req1_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h00000020)) begin
        $display("error at port 1 shift left 1 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      //port 2 #######################################################################
      req2_cmd_in = 4'b0101; req2_data_in = 32'h00000010;
      @(negedge c_clk);
      req2_cmd_in = 4'b0000; req2_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h00000020)) begin
        $display("error at port 2 shift left 1 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      //port 3 #######################################################################
      req3_cmd_in = 4'b0101; req3_data_in = 32'h00000010;
      @(negedge c_clk);
      req3_cmd_in = 4'b0000; req3_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h00000020)) begin
        $display("error at port 3 shift left 1 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      //port 4 #######################################################################
      req4_cmd_in = 4'b0101; req4_data_in = 32'h00000010;
      @(negedge c_clk);
      req4_cmd_in = 4'b0000; req4_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4=== 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h00000020)) begin
        $display("error at port 4 shift left 1 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      
      // here is part of row 'Check that the high-order 27 bits are ignored in the second operand of both shift commands.'
      //test shift right 1 places ignores top bit****************************************************************************
      //port 1 #######################################################################
      req1_cmd_in = 4'b0110; req1_data_in = 32'h00000020;
      @(negedge c_clk);
      req1_cmd_in = 4'b0000; req1_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h00000010)) begin
        $display("error at port 1 shift right 1 places outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      //port 2 #######################################################################
      req2_cmd_in = 4'b0110; req2_data_in = 32'h00000020;
      @(negedge c_clk);
      req2_cmd_in = 4'b0000; req2_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h00000010)) begin
        $display("error at port 2 shift right 1 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      //port 3 #######################################################################
      req3_cmd_in = 4'b0110; req3_data_in = 32'h00000020;
      @(negedge c_clk);
      req3_cmd_in = 4'b0000; req3_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h00000010)) begin
        $display("error at port 3 shift right 1 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      //port 4 #######################################################################
      req4_cmd_in = 4'b0110; req4_data_in = 32'h00000020;
      @(negedge c_clk);
      req4_cmd_in = 4'b0000; req4_data_in = 32'hffffffe1;
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h00000010)) begin
        $display("error at port 4 shift right 1 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      // >>>>>>>
      
      
      // this is part of row 'Check all outputs all of the time. Calc1 should not generate superfluous output values.'
      if (!(out_resp2 === 2'b00) || !(out_data2 === 32'h00000000)) begin
        $display("error nonzero port 2 shift left 1 places outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      if (!(out_resp3 === 2'b00) || !(out_data3 === 32'h00000000)) begin
        $display("error nonzero port 3 shift left 1 places outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      if (!(out_resp4 === 2'b00) || !(out_data4 === 32'h00000000)) begin
        $display("error nonzero port 4 shift left 1 places outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      // etc or all outputs that are not affected in this command...(wip)
      
      // this is part of 'Check that the design ignores data inputs unless the data are supposed to be valid (concurrent with the command and the following cycle). Remember that ?00000000?X is a data value just as any other 32- bit combination. Here, the check must include verifying that the design latches the data only when appropriate, and does not key off nonzero data.'
      //test 2.5 ***************************************************************************
      //port 1 #######################################################################
            // add
      req1_cmd_in = 4'b0001;
      req1_data_in = 32'h00000000;
      @(negedge c_clk);
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000002;
      @(negedge c_clk);
      // these are ignored while the calculation is happening
      // add 5 and 5
      req1_cmd_in = 4'b0001;
      req1_data_in = 32'h00000005;
      @(negedge c_clk);
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000005;
      @(negedge c_clk);
      // not valid
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000002;
      @(negedge c_clk);
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000002;
      
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h00000002)) begin
        $display("error at port 1 test 2.5 ignores inputs during calculation outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
            // add
      req2_cmd_in = 4'b0001;
      req2_data_in = 32'h00000000;
      @(negedge c_clk);
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000002;
      @(negedge c_clk);
      // these are ignored while the calculation is happening
      // add 5 and 5
      req2_cmd_in = 4'b0001;
      req2_data_in = 32'h00000005;
      @(negedge c_clk);
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000005;
      @(negedge c_clk);
      // not valid
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000002;
      @(negedge c_clk);
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000002;
      
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h00000002)) begin
        $display("error at port 2 test 2.5 ignores inputs during calculation outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
            // add
      req3_cmd_in = 4'b0001;
      req3_data_in = 32'h00000000;
      @(negedge c_clk);
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000002;
      @(negedge c_clk);
      // these are ignored while the calculation is happening
      // add 5 and 5
      req3_cmd_in = 4'b0001;
      req3_data_in = 32'h00000005;
      @(negedge c_clk);
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000005;
      @(negedge c_clk);
      // not valid
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000002;
      @(negedge c_clk);
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000002;
      
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h00000002)) begin
        $display("error at port 3 test 2.5 ignores inputs during calculation outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
            // add
      req4_cmd_in = 4'b0001;
      req4_data_in = 32'h00000000;
      @(negedge c_clk);
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000002;
      @(negedge c_clk);
      // these are ignored while the calculation is happening
      // add 5 and 5
      req4_cmd_in = 4'b0001;
      req4_data_in = 32'h00000005;
      @(negedge c_clk);
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000005;
      @(negedge c_clk);
      // not valid
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000002;
      @(negedge c_clk);
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000002;
      
      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h00000002)) begin
        $display("error at port 4 test 2.5 ignores inputs during calculation outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      
      // this is part of 'Check that the design ignores data inputs unless the data are supposed to be valid (concurrent with the command and the following cycle). Remember that ?00000000?X is a data value just as any other 32- bit combination. Here, the check must include verifying that the design latches the data only when appropriate, and does not key off nonzero data.'
      //test 2.5 ***************************************************************************
      //port 1 #######################################################################
      // this is passed to the posedge, so it will not be used
      req1_cmd_in = 4'b0001;
      req1_data_in = 32'h00000002;
      @(posedge c_clk);
      // add 3
      req1_cmd_in = 4'b0001;
      req1_data_in = 32'h00000003;
      @(negedge c_clk);
      // this is ignored since it's against the posedge
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000005;
      @(posedge c_clk);
      // with 7
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000007;
      @(posedge c_clk);
      // these two inputs will not be considered since a calculation is happening
      req1_cmd_in = 4'b0001;
      req1_data_in = 32'h00000003;
      @(negedge c_clk);
      req1_cmd_in = 4'b0000;
      req1_data_in = 32'h00000003;

      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp1 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data1 === 32'h0000000a)) begin
        $display("error at port 1 test 2.5 goodedge latching outVal: %b0, repVal: %b0", out_data1, out_resp1);
      end
      
      //port 1 #######################################################################
      // this is passed to the posedge, so it will not be used
      req2_cmd_in = 4'b0001;
      req2_data_in = 32'h00000002;
      @(posedge c_clk);
      // add 3
      req2_cmd_in = 4'b0001;
      req2_data_in = 32'h00000003;
      @(negedge c_clk);
      // this is ignored since it's against the posedge
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000005;
      @(posedge c_clk);
      // with 7
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000007;
      @(posedge c_clk);
      // these two inputs will not be considered since a calculation is happening
      req2_cmd_in = 4'b0001;
      req2_data_in = 32'h00000003;
      @(negedge c_clk);
      req2_cmd_in = 4'b0000;
      req2_data_in = 32'h00000003;

      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp2 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data2 === 32'h0000000a)) begin
        $display("error at port 2 test 2.5 goodedge latching outVal: %b0, repVal: %b0", out_data2, out_resp2);
      end
      
      //port 3 #######################################################################
      // this is passed to the posedge, so it will not be used
      req3_cmd_in = 4'b0001;
      req3_data_in = 32'h00000002;
      @(posedge c_clk);
      // add 3
      req3_cmd_in = 4'b0001;
      req3_data_in = 32'h00000003;
      @(negedge c_clk);
      // this is ignored since it's against the posedge
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000005;
      @(posedge c_clk);
      // with 7
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000007;
      @(posedge c_clk);
      // these two inputs will not be considered since a calculation is happening
      req3_cmd_in = 4'b0001;
      req3_data_in = 32'h00000003;
      @(negedge c_clk);
      req3_cmd_in = 4'b0000;
      req3_data_in = 32'h00000003;

      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp3 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data3 === 32'h0000000a)) begin
        $display("error at port 3 test 2.5 goodedge latching outVal: %b0, repVal: %b0", out_data3, out_resp3);
      end
      
      //port 4 #######################################################################
      // this is passed to the posedge, so it will not be used
      req4_cmd_in = 4'b0001;
      req4_data_in = 32'h00000002;
      @(posedge c_clk);
      // add 3
      req4_cmd_in = 4'b0001;
      req4_data_in = 32'h00000003;
      @(negedge c_clk);
      // this is ignored since it's against the posedge
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000005;
      @(posedge c_clk);
      // with 7
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000007;
      @(posedge c_clk);
      // these two inputs will not be considered since a calculation is happening
      req4_cmd_in = 4'b0001;
      req4_data_in = 32'h00000003;
      @(negedge c_clk);
      req4_cmd_in = 4'b0000;
      req4_data_in = 32'h00000003;

      repeat(3) @(negedge c_clk);
      		timeout = 0;

      while (out_resp4 === 2'b00) begin
			 @(negedge c_clk);
			 timeout = timeout + 1;
			
			 if ( timeout >= 20)
			   			  break;  			  
		  end      
      if (!(out_data4 === 32'h0000000a)) begin
        $display("error at port 4 test 2.5 goodedge latching outVal: %b0, repVal: %b0", out_data4, out_resp4);
      end
      
  end  
  
  task reset_sys;
    reset = 7'b0000000;
    @(negedge c_clk);
    reset = 7'b1111111;
    reset = 7'b0000000;
  endtask
  

endmodule
