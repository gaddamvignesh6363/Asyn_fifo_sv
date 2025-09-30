class mem_mon;
     	mem_tx tx; 	
 	
         virtual mem_intf vif;
   function new();
	      vif=$root.top.pif;     
   endfunction

	task run ();
	$display("********* mem_mon ********");
	forever begin
	
	   @(posedge vif.mon_cb);
	   if(vif.mon_cb.valid && vif.mon_cb.ready) begin
	   tx=new();
	     tx.addr=vif.mon_cb.addr;
	     tx.wr_rd=vif.mon_cb.wr_rd;
	     tx.data=tx.wr_rd?vif.mon_cb.wdata:vif.mon_cb.rdata;
		// tx.print("mem_mon");
		 mem_common::mon2cov.put(tx);
		 mem_common::mon2sbd.put(tx);
	     
		 end
		end
	endtask
	
  endclass

