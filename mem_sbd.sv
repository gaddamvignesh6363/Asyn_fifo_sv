class mem_sbd;
     	mem_tx tx; 	
       bit [`WIDTH-1:0] mem [*];
	task run ();
	$display("********* mem_sbd ********");
	   forever begin
              mem_common::mon2sbd.get(tx);
			  //tx.print("mem_sbd");
			  if(tx.wr_rd) begin
                   mem[tx.addr]=tx.data;
			  end
			 else begin
			   if(tx.data==mem[tx.addr]) begin
                    mem_common::matchs++;
			   end
			   else begin
                   mem_common::miss_matches++;
			   end
	        end

			  $display("########  size of mem=%0d #######",mem.num);
	   end
	endtask
	
  endclass

