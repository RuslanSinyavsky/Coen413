/*******************************************************************************
 *
 * File:        $RCSfile: top.v,v $
 * Revision:    $Revision: 1.7 $  
 * Date:        $Date: 2003/07/15 15:18:31 $
 *
 *******************************************************************************
 *
 * Top level SystemVerilog file that instantiates the APB interface, testbench
 * and design under test
 *
 *******************************************************************************
 * Copyright (c) 1991-2005 by Synopsys Inc.  ALL RIGHTS RESERVED.
 * CONFIDENTIAL AND PROPRIETARY INFORMATION OF SYNOPSYS INC.
 *******************************************************************************
 */

module top;
  parameter simulation_cycle = 100;
  
  bit clk;
  always #(simulation_cycle/2) 
    clk = ~clk;

  calc_if       my_calc_if(clk); // APB interafce
  test          t1(my_calc_if);  // Testbench program
  
  calc2_top     m1( my_calc_if.Slave.out_data1, my_calc_if.Slave.out_data2, my_calc_if.Slave.out_data3, my_calc_if.Slave.out_data4, 
                    my_calc_if.Slave.out_resp1, my_calc_if.Slave.out_resp2, my_calc_if.Slave.out_resp3, my_calc_if.Slave.out_resp4, 
                    my_calc_if.Slave.out_tag1, my_calc_if.Slave.out_tag2, my_calc_if.Slave.out_tag3, my_calc_if.Slave.out_tag4, ,
                    clk,clk,clk,
                    my_calc_if.Slave.req1_cmd_in, my_calc_if.Slave.req1_data_in, my_calc_if.Slave.req1_tag_in, 
                    my_calc_if.Slave.req2_cmd_in, my_calc_if.Slave.req2_data_in, my_calc_if.Slave.req2_tag_in, 
                    my_calc_if.Slave.req3_cmd_in, my_calc_if.Slave.req3_data_in, my_calc_if.Slave.req3_tag_in, 
                    my_calc_if.Slave.req4_cmd_in, my_calc_if.Slave.req4_data_in, my_calc_if.Slave.req4_tag_in, 
                    my_calc_if.Slave.Rst, 
                    );  // Memory device

endmodule  
