class mem_bfm;
     	mem_tx tx; 	
         virtual mem_intf vif;
		 int num_agent;
   function new(int i);
	      vif=$root.top.pif;
          num_agent=i;
   endfunction
	task run ();
	$display("********* mem_bfm ********");
     
	  //$display("********** %0t **********", $time);
	  forever begin
      wait(vif.bfm_mp.res==0);
	    mem_common::gen2bfm.get(tx);
		mem_common::mem_smp.get(1);
		drive_to_dut(tx);
		mem_common::bfm_tx_driven++;
		tx.print($sformatf("mem_bfm %0d",num_agent));
		mem_common::mem_smp.put(1);
		
		end
	endtask

	  task drive_to_dut(mem_tx tx);
 		  @(vif.bfm_mp.bfm_cb);
		  vif.bfm_mp.bfm_cb.addr<=tx.addr;
		 vif.bfm_mp.bfm_cb.wr_rd<=tx.wr_rd;

		  if(tx.wr_rd)
		     vif.bfm_mp.bfm_cb.wdata<=tx.data;
		 vif.bfm_mp.bfm_cb.valid<=1;
		  wait(vif.bfm_mp.bfm_cb.ready==1);

		  if(!tx.wr_rd) begin
		       tx.data=vif.bfm_mp.bfm_cb.rdata;
		  end
		  @(vif.bfm_mp.bfm_cb);
		  vif.bfm_mp.bfm_cb.addr<=0;
		  vif.bfm_mp.bfm_cb.wr_rd<=0;
		  vif.bfm_mp.bfm_cb.wdata<=0;
		  
		  vif.bfm_mp.bfm_cb.valid<=0;

	  endtask

  endclass

