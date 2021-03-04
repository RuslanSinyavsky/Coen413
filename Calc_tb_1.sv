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
              
	localparam 	     	MAXPOS = 7,
						ZERO   = 0,
						MAXNEG = -8;

	//reg [1:0] Opcode;	// The opcode

	calc1_top calc1_top (
			.c_clk(clk),
			.reset(reset),
			.req1_cmd_in(req1_cmd_in), //Cmd and data for all 4 input ports
			.req2_cmd_in(req2_cmd_in),
			.req3_cmd_in(req3_cmd_in),
			.req4_cmd_in(req4_cmd_in),
			.req1_data_in(req1_data_in),
			.req2_data_in(req2_data_in),
			.req3_data_in(req3_data_in),
			.req4_data_in(req4_data_in),
			.out_resp1(out_resp1), //Resp and data for all 4 input ports
			.out_resp2(out_resp2),
			.out_resp3(out_resp3),
			.out_resp4(out_resp4),
			.out_data1(out_data1),
			.out_data2(out_data2),
			.out_data3(out_data3),
			.out_data4(out_data4)
			);

	// Create the clock and reset

	initial begin
	  clk = 0;
	  forever #50 clk = !clk;
	end
  
  initial begin
      error_count = 0;
      correct_count = 0;
      
      assert_reset;      
      
      check_result_1(Add, 32'h80002345, 32'h00010000, 32'h80012345);
  end
      
   /*
   // Create the Opcode and A and B
   initial begin
      error_count = 0;
      correct_count = 0;

      assert_reset;
      
      // Apply all permutations of max pos, max neg, and 0 to each opcode
      A=MAXNEG; B=MAXNEG;
      Opcode = Add;
      check_result(Opcode, A, B, -16);
      Opcode = Sub;
      check_result(Opcode, A, B, ZERO);

      A=MAXNEG; B=ZERO;
      Opcode = Add;
      check_result(Opcode, A, B, MAXNEG);
      Opcode = Sub;
      check_result(Opcode, A, B, MAXNEG);

      A=MAXNEG; B=MAXPOS;
      Opcode = Add;
      check_result(Opcode, A, B, -1);
      Opcode = Sub;
      check_result(Opcode, A, B, -15);

      A=ZERO; B=MAXNEG;
      Opcode = Add;
      check_result(Opcode, A, B, MAXNEG);
      Opcode = Sub;
      check_result(Opcode, A, B, 8);
      
      A=ZERO; B=ZERO;
      Opcode = Add;
      check_result(Opcode, A, B, ZERO);
      Opcode = Sub;
      check_result(Opcode, A, B, ZERO);

      A=ZERO; B=MAXPOS;
      Opcode = Add;
      check_result(Opcode, A, B, MAXPOS);
      Opcode = Sub;
      check_result(Opcode, A, B, -7);

      A=MAXPOS; B=MAXNEG;
      Opcode = Add;
      check_result(Opcode, A, B, -1);
      Opcode = Sub;
      check_result(Opcode, A, B, 15);
      
      A=MAXPOS; B=ZERO;
      Opcode = Add;
      check_result(Opcode, A, B, MAXPOS);
      Opcode = Sub;
      check_result(Opcode, A, B, MAXPOS);

      A=MAXPOS; B=MAXPOS;
      Opcode = Add;
      check_result(Opcode, A, B, 14);
      Opcode = Sub;
      check_result(Opcode, A, B, ZERO);

      // Set B to non-all 0 and non-all 1.  Apply all 0 and all 1'ss to bitwise invert input A opcode.
      Opcode = Not_A;
      
      A=4'b0000; B=4'b0101;
      check_result(Opcode, A, B, 5'b11111);
      A=4'b1111; B=4'b1010;
      check_result(Opcode, A, B, 5'b00000);

      // Apply 0, all 1's, and walking 1's to B for ReductionOR_B opcode. Set A to a value that will yield the opposite result.
      Opcode = ReductionOR_B;

      A=4'b1111; B=4'b0000;
      check_result(Opcode, A, B, 0);
      A=4'b0000; B=4'b1111;
      check_result(Opcode, A, B, 1);      
      A=4'b0000; B=4'b0001;
      check_result(Opcode, A, B, 1);
      A=4'b0000; B=4'b0010;
      check_result(Opcode, A, B, 1);
      A=4'b0000; B=4'b0100;
      check_result(Opcode, A, B, 1);
      A=4'b0000; B=4'b1000;
      check_result(Opcode, A, B, 1);

      // Set the operands and walk through the opcodes
      A=4'b0101; B=4'b1010;
      Opcode = Add;
      check_result(Opcode, A, B, -1);
      Opcode = Sub;
      check_result(Opcode, A, B, 11);
      Opcode = Not_A;
      check_result(Opcode, A, B, 5'b11010);
      Opcode = ReductionOR_B;
      check_result(Opcode, A, B, 1);

      // Apply inputs so that C is all 1's. Reset
      Opcode = Not_A;
      
      A=4'b0000; B=4'b0101;
      check_result(Opcode, A, B, 5'b11111);

      assert_reset;

      // After reset is released and a postitive clock edge occurs, check the expected value again.
      check_result(Opcode, A, B, 5'b11111);

      $display("%t: At end of test error count is %0d and correct count = %0d", $time, error_count, correct_count);  
      $finish; 
   end
   */

	task check_result_1 (input [3:0] Cmd, input [31:0] Operand1, Operand2, input [31:0] expected_result);
		req1_cmd_in = Cmd;
		req1_data_in = Operand1;
		@(negedge clk);
		req1_cmd_in = No_Op;
		req1_data_in = Operand2;
		
		repeat(3) @(negedge clk);
		
		while (out_resp1 === 2'b00) begin
			@(negedge clk);
		end
		
		if (expected_result !== out_data1) begin
			error_count = error_count + 1;
			$display("%t: Error: For Cmd = %0b, Operand1= 0d%0d, and Operand2=0d%0d C should equal 0d%0d but is 0d%0d ", $time, Cmd, Operand1, Operand2, expected_result, out_data1);
		end
		else
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
