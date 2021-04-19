/***************************************************************************
 *
 * File:        $RCSfile: apb_master.sv,v $
 * Revision:    $Revision: 1.8 $  
 * Date:        $Date: 2003/07/15 15:18:31 $
 *
 *******************************************************************************
 *
 * Basic Transaction Verification Module aimed at
 * creating read() and write() transactions based
 * on APB management Interface
 *
 *******************************************************************************
 * Copyright (c) 1991-2005 by Synopsys Inc.  ALL RIGHTS RESERVED.
 * CONFIDENTIAL AND PROPRIETARY INFORMATION OF SYNOPSYS INC.
 *******************************************************************************
 */


`define CALC_MASTER_IF	calc_master_if.master_cb
`include "apb_env/calc_request.sv"

  
class calc_master (input Clk);

    // APB Interface (Master side)
    virtual calc_if.Master calc_master_if;

    // APB Transaction mailboxes
    mailbox #(calc_request) gen2mas, mas2scb;

    // Verbosity level
    bit verbose;
  
    // Constructor
    function new(virtual calc_if.Master calc_master_if, 
                 mailbox #(calc_request) gen2mas, mas2scb,
                 bit verbose=0);

      this.gen2mas       = gen2mas;
      this.mas2scb       = mas2scb;    
      this.calc_master_if = calc_master_if;
      this.verbose       = verbose;
    endfunction: new
    
    // Main daemon. Runs forever to switch APB transaction to
    // corresponding read/write/idle command
    task main();
       calc_request tr;

       if(verbose)
         $display($time, ": Starting apb_master");

       forever begin
        // Wait & get a calc request
        gen2mas.get(tr);
        
        //Send request to DUT
        sendRequest(tr);

        if(verbose)
          tr.display("Master");
      end

       if(verbose)
         $display($time, ": Ending calc_master");

    endtask: main
        

  // Sent the calc request to all 4 ports of the Calc
  task  sendRequest(calc_request tr);
     // Drive Control bus
     @(posedge Clk)
     `CALC_MASTER_IF.PAddr  <= tr.cmd;
     `CALC_MASTER_IF.PData <= tr.data;
     `CALC_MASTER_IF.PTag <= tr.tag;
     
     @(posedge Clk)
     `CALC_MASTER_IF.PAddr  <= 4'b0000;
     `CALC_MASTER_IF.PData <= tr.data2;
     `CALC_MASTER_IF.PTag <= tr.tag;
     
     mas2scb.put(tr);
  endtask: sendRequest

endclass: calc_master

