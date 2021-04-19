`include ""

class scoreboard;

  // Verbosity level
  bit verbose;
  
  // Max # of transactions
  int max_trans_cnt;
  event ended;

  // Number of good matches
  int match;

  // Transaction coming in
  mailbox #(calc_request) mas2scb;
  mailbox #(calc_result) mon2scb;    

  // Constructor
  function new(int max_trans_cnt, mailbox #(calc_request) mas2scb, #(calc_result) mon2scb, bit verbose=0);
    this.max_trans_cnt = max_trans_cnt;
	this.mon2scb       = mon2scb;
    this.mas2scb       = mas2scb;
    this.verbose       = verbose;
  endfunction


  // Method to receive transactions from master and monitor
  task main();
    apb_trans mas_tr, mon_tr;
	reg [1:0] out_resp;
	reg [31:0] out_data;
	reg [31:0] out_data2;
	reg [31:0] exp_val
	reg [1:0] out_tag; 

    $display($time, ": Starting scoreboard for %0d transaction", max_trans_cnt);

    forever
      begin
        mas2scb.get(mas_tr);//input
        mon2scb.get(mon_tr);//output
		  
		//Set expected data
		in_data1 = mas_tr.data;
		in_data2 = mas_tr.data2;
		
		case(mas_tr.cmd)
		
			//check for addition
			4'b0001:
				begin
					exp_val = mas_tr.data + mas_tr.data2;
					if (mon_tr.out_Resp != 2'b01)
						$display("@%0d: ERROR monitor response (%h) does not match expected response (%h)",
							$time, mon_tr.out_Resp, 2'b01);
					else if (mon_tr.out_Data != exp_val)
						$display("@%0d: ERROR monitor data (%h) does not match expected value (%h)",
							$time, mon_tr.out_Data, exp_val);
					else if (mon_tr.out_Tag != TODO)
						$display("@%0d: ERROR monitor tag (%h) does not match expected tag (%h)",
							$time, mon_tr.out_Tag, TODO);
				end

			//check for sub				
			4'b0010:
				begin
					exp_val = mas_tr.data - mas_tr.data2;
					if (mon_tr.out_Resp != 2'b01)
						$display("@%0d: ERROR monitor response (%h) does not match expected response (%h)",
							$time, mon_tr.out_Resp, 2'b01);
					else if (mon_tr.out_Data != exp_val)
						$display("@%0d: ERROR monitor data (%h) does not match expected value (%h)",
							$time, mon_tr.out_Data, exp_val);
					else if (mon_tr.out_Tag != TODO)
						$display("@%0d: ERROR monitor tag (%h) does not match expected tag (%h)",
							$time, mon_tr.out_Tag, TODO);				
				end

			//check for left shift				
			4'b0101
				begin
					exp_val = mas_tr.data << mas_tr.data2;
					if (mon_tr.out_Resp != 2'b01)
						$display("@%0d: ERROR monitor response (%h) does not match expected response (%h)",
							$time, mon_tr.out_Resp, 2'b01);
					else if (mon_tr.out_Data != exp_val)
						$display("@%0d: ERROR monitor data (%h) does not match expected value (%h)",
							$time, mon_tr.out_Data, exp_val);
					else if (mon_tr.out_Tag != TODO)
						$display("@%0d: ERROR monitor tag (%h) does not match expected tag (%h)",
							$time, mon_tr.out_Tag, TODO);						
				end

			//check for right shift				
			4'b0110:
				begin
					exp_val = mas_tr.data >> mas_tr.data2;
					if (mon_tr.out_Resp != 2'b01)
						$display("@%0d: ERROR monitor response (%h) does not match expected response (%h)",
							$time, mon_tr.out_Resp, 2'b01);
					else if (mon_tr.out_Data != exp_val)
						$display("@%0d: ERROR monitor data (%h) does not match expected value (%h)",
							$time, mon_tr.out_Data, exp_val);
					else if (mon_tr.out_Tag != TODO)
						$display("@%0d: ERROR monitor tag (%h) does not match expected tag (%h)",
							$time, mon_tr.out_Tag, TODO);	
				end

			
          default:
            begin
              $display("@%0d: Fatal error: Scoreboard received illegal master transaction '%s'", 
                       $time, mon_tr.out_Port);
              $finish;
            end
        endcase
        end 
        
        // Determine if the end of test has been reached
        if(--max_trans_cnt<1)
          ->ended;
        
      end // forever
  endtask

endclass

