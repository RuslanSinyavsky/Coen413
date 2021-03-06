///////////////////////////////////////////////////////////////////////////
// Purpose: Testbench for Chap_1_Verificat ion_Guidelines/homework_solution
// Author: Greg Tumbush
//
// REVISION HISTORY:
// $Log: ALU_4_bit_tb.sv,v $
// Revision 1.1  2011/05/28 14:57:35  tumbush.tumbush
// Check into cloud repository
//
// Revision 1.1  2011/03/17 16:39:07  Greg
// Initial check-in
//
///////////////////////////////////////////////////////////////////////////

`default_nettype none
module Calc_tb_1;


	// inputs to instantiated Cal1
	reg clk;
	reg [7:0] reset;
	
	/* 
	reg [3:0] req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
	reg [31:0] req1_data_in, req2_data_in, req3_data_in, req4_data_in;

	// Output of Cal1
	wire [1:0] out_resp1, out_resp2, out_resp3, out_resp4;
	wire [31:0] out_data1, out_data2, out_data3, out_data4;
  */
  
	integer 	     error_count; // 32-bit signed

	integer 	     correct_count; // 32-bit signed
	integer       timeout;
	reg [3:0] previous_operation;

	localparam 	No_Op = 4'b0000,
				Add = 4'b0001,
				Sub = 4'b0010, // operand1 -  operand2
				Left_shift = 4'b0101, //Shift left operand1 by operand2 places
				Right_shift = 4'b0110; //Shift right operand1 by operand2 places

	localparam 	No_response = 2'b00,
				Successful = 2'b01,
				Input_error = 2'b10, //invalid command or overflow/underflow error
				Internal_error = 2'b11;
              
	integer 	     	temp_Op1 = 0,
						ZERO   = 0,
						temp_Op2 = 0;
	
	int array1 [int];
	
	reg [3:0] cmd_array[0:3];
	reg [31:0] data_in_array[0:3];
	wire [1:0] out_resp_array[0:3];
	wire [31:0] out_data_array[0:3];

	reg [1:0] OperationCheck;

	calc1_top calc1_top (
			.c_clk(clk),
			.reset(reset),
			.req1_cmd_in(cmd_array[0]), //Cmd and data for all 4 input ports
			.req2_cmd_in(cmd_array[1]),
			.req3_cmd_in(cmd_array[2]),
			.req4_cmd_in(cmd_array[3]),
			
			.req1_data_in(data_in_array[0]),
			.req2_data_in(data_in_array[1]),
			.req3_data_in(data_in_array[2]),
			.req4_data_in(data_in_array[3]),
			
			.out_resp1(out_resp_array[0]), //Resp and data for all 4 input ports
			.out_resp2(out_resp_array[1]),
			.out_resp3(out_resp_array[2]),
			.out_resp4(out_resp_array[3]),
			
			.out_data1(out_data_array[0]),
			.out_data2(out_data_array[1]),
			.out_data3(out_data_array[2]),
			.out_data4(out_data_array[3])
			);

	// Create the clock and reset

	initial begin
	  clk = 0;
	  forever #50 clk = !clk;
	end
  
  initial begin
      error_count = 0;
      correct_count = 0;
      
	    array1[0] = Add;
	    array1[1] = Sub;
	    array1[2] = Left_shift;
	    array1[3] = Right_shift;
     	      
      
      ///////////////////////////////////////////////// Test 1.1 ///////////////////////////////////////////////
      assert_reset;      
      check_result_1(0, Add, 32'h80002345, 32'h00010000, 32'h80012345);
      check_result_1(1, Add, 32'h80002345, 32'h00010000, 32'h80012345); 
      check_result_1(2, Add, 32'h80002345, 32'h00010000, 32'h80012345);
      check_result_1(3, Add, 32'h80002345, 32'h00010000, 32'h80012345);
      
      //////////////////////////////////////////////////////////////////////////////////////////////////////////
      
	  
	    ///////////////////////////////////////////////// Test 2.1.1 ///////////////////////////////////////////// 128 tests total ( 16*2 = 32 tests for each port)
	    assert_reset;

	    
	    temp_Op1 = 32'h00002000;
      temp_Op2 = 32'h00000001;
      	    
	    for (integer i = 0; i < 4; i = i+1) begin //Iterate through the 4 ports available
	      for (integer j = 0; j < 4; j = j+1) begin //First command
	        for (integer k = 0; k < 4; k = k+1) begin //Second command
	          check_operation(i, array1[j], temp_Op1, temp_Op2);
	          check_operation(i, array1[k], temp_Op1, temp_Op2);
	        end
	      end
	    end

      //////////////////////////////////////////////////////////////////////////////////////////////////////////	    
	    
	    ///////////////////////////////////////////////// Test 2.1.2 ///////////////////////////////////////////// 128 tests total ( 16*2 = 32 tests for each port)
	    assert_reset;

	    
	    temp_Op1 = 32'h00002000;
      temp_Op2 = 32'h00000001;
      	    
	    for (integer i = 0; i < 4; i = i+1) begin //First command
	      for (integer j = 0; j < 4; j = j+1) begin //Second command
	        for (integer k = 0; k < 4; k = k+1) begin //Iterate through the 4 ports available
	          check_operation(k, array1[i], temp_Op1, temp_Op2);
	        end
	        
	        for (integer k = 0; k < 4; k = k+1) begin //Iterate through the 4 ports available
	          check_operation(k, array1[j], temp_Op1, temp_Op2);
	        end
	        
	      end
	    end
	    
      //////////////////////////////////////////////////////////////////////////////////////////////////////////
      
      
            
      ///////////////////////////////////////////////// Test 2.2 ///////////////////////////////////////////// 12 tests total
	    assert_reset;

	    
	    temp_Op1 = 32'h00002000;
      temp_Op2 = 32'h00000001;
      	    
	    for (integer i = 0; i < 4; i = i+1) begin //First command
	      for (integer j = 0; j < 4; j = j+1) begin //Second command
	        if (j == i)
	          continue;
	        check_priority(i,j, Add, temp_Op1, temp_Op2);
	      end
	    end
	    
      //////////////////////////////////////////////////////////////////////////////////////////////////////////
      
	    
  end

	task check_result_1 (input integer i, input [3:0] Cmd, input [31:0] Operand1, Operand2, input [31:0] expected_result);
		cmd_array[i] = Cmd;
		data_in_array[i] = Operand1;
		@(negedge clk);
		cmd_array[i] = No_Op;
		data_in_array[i] = Operand2;
		
		repeat(3) @(negedge clk);
		
		timeout = 0;
		
		while (out_resp_array[i] === 2'b00) begin
			@(negedge clk);
			timeout = timeout + 1;
			
			if ( timeout >= 20)
			  break;
		end
		
		if (expected_result !== out_data_array[i]) begin
			error_count = error_count + 1;
			$display("%t: Logical Error (Test 1.1): For Port Number = %0d, Cmd = %0b, Operand1= 0h%0h, and Operand2=0h%0h C should equal 0h%0h but is 0h%0h ", $time, (i+1), Cmd, Operand1, Operand2, expected_result, out_data_array[i]);
		end
		else
			correct_count = correct_count + 1;
	endtask
	
	task check_operation (input integer i, input [3:0] Cmd, input [31:0] Operand1, Operand2);
		cmd_array[i] = Cmd;
		data_in_array[i] = Operand1;
		@(negedge clk);
		cmd_array[i] = No_Op;
		data_in_array[i] = Operand2;
		
		repeat(3) @(negedge clk);
		
    timeout = 0;
		
		while (out_resp_array[i] === 2'b00) begin
			@(negedge clk);
			timeout = timeout + 1;
			
			if ( timeout >= 20)
			  break;
		end
		
		if (out_resp_array[i] === 2'b10 || timeout >= 20) begin
			error_count = error_count + 1;
			$display("%t: Operation Error (Test 2.1.1, 2.1.2): For Cmd = %0b, Previous Cmd = %0b, Port Number = %0d", $time, Cmd, previous_operation, (i+1));
		end
		else if (out_resp_array[i] === 2'b01)
			correct_count = correct_count + 1;
			
		previous_operation = Cmd;
	endtask
	
	task check_priority (input integer first_port, input integer second_port, input [3:0] Cmd, input [31:0] Operand1, Operand2);
	  //Reset operation check
	  OperationCheck = 2'b00; //Most left bit are for the first port
	  
		//Send command to the first port
		cmd_array[first_port] = Cmd;
		data_in_array[first_port] = Operand1;
		@(negedge clk);
		cmd_array[first_port] = No_Op;
		data_in_array[first_port] = Operand2;
		
		//Send command to the second port
		@(negedge clk);
		cmd_array[second_port] = Cmd;
		data_in_array[second_port] = Operand1;
		@(negedge clk);
		cmd_array[second_port] = No_Op;
		data_in_array[second_port] = Operand2;
		
		//repeat(3) @(negedge clk);
		
    timeout = 0;
		
		while (out_resp_array[second_port] === 2'b00) begin //When the second port still waiting for the result
			@(negedge clk);
			
			if (OperationCheck === 2'b00 && out_resp_array[first_port] !== 2'b00) begin //If the first port get the result 
			  OperationCheck = 2'b10;
			end
			timeout = timeout + 1;
			
			if ( timeout >= 20)
			  break;
		end
		
		if (timeout < 20) begin
		  if (out_resp_array[second_port] === 2'b01 && OperationCheck === 2'b10)
			  correct_count = correct_count + 1;
			else begin
			  error_count = error_count + 1;
			  $display("%t: Priority Error (Test 2.2): For Cmd = %0b, 1st Port = %0d, 2nd Port = %0d", $time, Cmd, (first_port+1), (second_port+1));
			end
		end
		else begin
		  error_count = error_count + 1;
			$display("%t: Timeout Error (Test 2.2): For Cmd = %0b, 1st Port = %0d, 2nd Port = %0d", $time, Cmd, (first_port+1), (second_port+1));
		end
			
	endtask
	
	task assert_reset;
      reset = 7'b0000000;
      @(negedge clk);
      reset = 7'b1111111;
      repeat(7) @(negedge clk);
      // Check reset value of C
      //checkC(5'b0);
      reset = 7'b0000000;
   endtask // assert_reset

/*
   task checkC(input signed [4:0] expected_C);
      @(negedge clk);
      if (expected_C !== C) begin
	 error_count = error_count + 1;
	 $display("%t: Error: C should equal 0d%0d but the calcuated result is 0d%0d ", $time, expected_C, C);
      end
   endtask // checkC

   */
endmodule
