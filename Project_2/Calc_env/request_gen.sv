/*******************************************************************************
 *
 * File:        $RCSfile: apb_gen.sv,v $
 * Revision:    $Revision: 1.7 $  
 * Date:        $Date: 2003/07/15 15:18:31 $
 *
 *******************************************************************************
 *
 * Basic Transaction Generator aimed at randomizing and
 * initiating read() and write() transactions based
 * on APB BFM (apb_master)
 *
 *******************************************************************************
 * Copyright (c) 1991-2005 by Synopsys Inc.  ALL RIGHTS RESERVED.
 * CONFIDENTIAL AND PROPRIETARY INFORMATION OF SYNOPSYS INC.
 *******************************************************************************
 */


`include "Calc_env/calc_request.sv"

class request_gen;

  // Random APB transaction
  rand calc_request rand_tr;

  // Test terminates when the trans_cnt is greater
  // than max_trans_cnt member
  int max_trans_cnt;
  
  // event notifying that all transactions were sent
  event ended;
  
  // Counts the number of performed transactions
  int trans_cnt = 0;

  // Verbosity level
  bit verbose;
  
  // APB Transaction mailbox
  mailbox #(calc_request) gen2mas;
    
  // Constructor
  function new(mailbox #(calc_request) gen2mas, int max_trans_cnt, bit verbose=0);
    this.gen2mas       = gen2mas;
    this.verbose       = verbose;
    this.max_trans_cnt = max_trans_cnt;
    rand_tr            = new;
  endfunction

  // Method aimed at generating transactions
  task main();
    if(verbose)
      $display($time, ": Starting apb_gen for %0d transactions", 
               max_trans_cnt);
    
    // Start this daemon as long as there is a transaction 
    // to be proceeded)
    while(!end_of_test())
      begin
        calc_request my_tr;
        
        // Wait & Get a transaction
        my_tr = get_transaction();
        ++trans_cnt;
  
        // Increment the number of sent transactions
        //if(my_tr.transaction != IDLE)
          
  
        //if(verbose)
          //my_tr.display("Generator");

        gen2mas.put(my_tr);
      end // while (!end_of_test())
        
    if(verbose) 
      $display($time, ": Ending apb_gen\n");
  
    ->ended;

  endtask


  // Returns TRUE when the test should stop
  virtual function bit end_of_test();
    end_of_test = (trans_cnt >= max_trans_cnt);
  endfunction
    
  // Returns a transaction (associated with tr member)
  virtual function calc_request get_transaction();
    rand_tr.trans_cnt = trans_cnt;
    if (! this.rand_tr.randomize() with {rand_tr.cmd dist{4'b0001 := 25, 4'b0010 := 25, 4'b0101 := 25, 4'b0110 := 25};})
      begin
        $display("apb_gen::randomize failed");
        $finish;
      end
      
    $display("request_gen::cmd: %40b", rand_tr.cmd);
    return rand_tr.copy();
  endfunction
    
endclass

