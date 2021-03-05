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
	reg [3:0] req1_cmd_in, req2_cmd_in, req3_cmd_in, req4_cmd_in;
	reg [31:0] req1_data_in, req2_data_in, req3_data_in, req4_data_in;

	// Output of Cal1
	wire [1:0] out_resp1, out_resp2, out_resp3, out_resp4;
	wire [31:0] out_data1, out_data2, out_data3, out_data4;

	integer 	     error_count; // 32-bit signed

	integer 	     correct_count; // 32-bit signed

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

	//reg [1:0] Opcode;	// The opcode

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
      
      /*
      //Initializing the cmd array
     	cmd_array[0] = req1_cmd_in;
     	cmd_array[1] = req2_cmd_in;
     	cmd_array[2] = req3_cmd_in;
     	cmd_array[3] = req4_cmd_in;
     	
     	//Initializing the data in array
     	data_in_array[0] = req1_data_in;
     	data_in_array[1] = req2_data_in;
     	data_in_array[2] = req3_data_in;
     	data_in_array[3] = req4_data_in;
     	
     	//Initializing the out resp array
     	out_resp_array[0] = out_resp1;
     	out_resp_array[1] = out_resp2;
     	out_resp_array[2] = out_resp3;
     	out_resp_array[3] = out_resp4;
     	
     	//Initializing the out data array
     	//out_data_array[0] = out_data1;
     	out_data_array[1] = out_data2;
     	out_data_array[2] = out_data3;
     	out_data_array[3] = out_data4;
     	*/
     	      
      ///////////////////////////////////////////////// Test 1.1 ///////////////////////////////////////////////
      assert_reset;      
      check_result_1(0, Add, 32'h80002345, 32'h00010000, 32'h80012345);
	  
	    ///////////////////////////////////////////////// Test 2.1.1 ///////////////////////////////////////////// 64 tests 
	    assert_reset;

	    array1[0] = Add;
	    array1[1] = Sub;
	    array1[2] = Left_shift;
	    array1[3] = Right_shift;
	    
	    temp_Op1 = 32'h00002000;
      temp_Op2 = 32'h00000001;
      	    
	    for (integer i = 0; i < 4; i = i+1) begin
	      for (integer j = 0; j < 4; j = j+1) begin
	        check_operation(array1[i], temp_Op1, temp_Op2);
	      end
	    end
	    
  end

	task check_result_1 (input integer i, input [3:0] Cmd, input [31:0] Operand1, Operand2, input [31:0] expected_result);
		cmd_array[i] = Cmd;
		data_in_array[i] = Operand1;
		@(negedge clk);
		cmd_array[i] = No_Op;
		data_in_array[i] = Operand2;
		
		repeat(3) @(negedge clk);
		
		while (out_resp_array[i] === 2'b00) begin
			@(negedge clk);
		end
		
		if (expected_result !== out_data_array[i]) begin
			error_count = error_count + 1;
			$display("%t: Error: For Cmd = %0b, Operand1= 0d%0d, and Operand2=0d%0d C should equal 0d%0d but is 0d%0d ", $time, Cmd, Operand1, Operand2, expected_result, out_data1);
		end
		else
			correct_count = correct_count + 1;
	endtask
	
	task check_operation (input [3:0] Cmd, input [31:0] Operand1, Operand2);
		req1_cmd_in = Cmd;
		req1_data_in = Operand1;
		@(negedge clk);
		req1_cmd_in = No_Op;
		req1_data_in = Operand2;
		
		repeat(3) @(negedge clk);
		
		while (out_resp1 === 2'b00) begin
			@(negedge clk);
		end
		
		if (out_resp1 === 2'b10) begin
			error_count = error_count + 1;
			//$display("%t: Error: For Cmd = %0b, Operand1= 0d%0d, and Operand2=0d%0d C should equal 0d%0d but is 0d%0d ", $time, Cmd, Operand1, Operand2, expected_result, out_data1);
		end
		else if (out_resp1 === 2'b01)
			correct_count = correct_count + 1;
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
