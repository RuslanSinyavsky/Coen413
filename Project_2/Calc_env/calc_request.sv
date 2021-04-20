/***************************************************************************
 *
 * File:        $RCSfile: apb_trans.sv,v $
 * Revision:    $Revision: 1.5 $  
 * Date:        $Date: 2003/07/02 15:47:08 $
 *
 *******************************************************************************
 *
 * APB Transaction Structure
 *
 *******************************************************************************
 * Copyright (c) 1991-2005 by Synopsys Inc.  ALL RIGHTS RESERVED.
 * CONFIDENTIAL AND PROPRIETARY INFORMATION OF SYNOPSYS INC.
 *******************************************************************************
 */
`ifndef CALC_IF_DEFINE
`define CALC_IF_DEFINE

`include "hdl/root.sv"

class calc_request;
    rand reg_cmd_t cmd;
    rand req_data_t data;
    rand req_data_t data2;
    //rand trans_e transaction;
    static int count=0;
    bit [1:0] tag;
    int id, trans_cnt;

    function new;
    id = count++;
    tag = id;
    endfunction
    
  function calc_request copy();
    calc_request to   = new();
    to.cmd        = this.cmd;
    to.data        = this.data;
    to.data2        = this.data2;
    copy = to;
  endfunction: copy
    
endclass

`endif


