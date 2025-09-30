class mem_cov;
     	mem_tx tx;
        // event mem_cge;
        covergroup mem_cg;
          WR_RD_CP:coverpoint tx.wr_rd{ 
                bins WRITE ={1'b1};
				bins READ ={1'b0};
		   }
           ADDR_CP:coverpoint tx.addr{ 
             option.auto_bin_max=5;
		   }
           DATA_CP:coverpoint tx.data{ 
            option.auto_bin_max=10;
		   }
         CROSS_ADDR_AND_WR_RD: cross WR_RD_CP ,ADDR_CP;
		endgroup
          function new();
             mem_cg=new();
		  endfunction

	task run ();
	   $display("********* mem_cov ********");
	      forever begin
		    mem_common::mon2cov.get(tx);
		//	->m_cge;
             mem_cg.sample();
		end
	endtask
	
  endclass

