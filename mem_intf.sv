//interface mem_intf #(parameter WIDTH = 16,
//                     parameter DEPTH = 64,
  //                   parameter ADDR_WIDTH = $clog2(`DEPTH));

  interface mem_intf(input reg clk,res);
  //bit clk;
 // bit res;
  bit wr_rd;
  bit [`ADDR_WIDTH-1:0] addr;
  bit [`WIDTH-1:0] wdata;
  bit [`WIDTH-1:0] rdata;
  bit valid;
  bit ready;
    clocking bfm_cb@(posedge clk);
	     default input #0 output #1;
        	output wr_rd;
		   	output addr;
			output wdata;
            output valid;
	        input rdata;
			input ready;

	
		
					endclocking
    clocking mon_cb@(posedge clk);
	     default input #1;
        input ready;
		input rdata;
		input valid;
		input addr;
		input wdata;
		input wr_rd;
	endclocking
     
	     modport bfm_mp(clocking bfm_cb);
endinterface
