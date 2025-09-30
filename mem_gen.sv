class mem_gen;
   	mem_tx tx; 	
     bit [`ADDR_WIDTH-1:0] addr_t[$];
	 
	//static bit [`ADDR_WIDTH-1:0] tx_addr[$];
	task run ();
	$display("********* mem_gen ********");
	 case (mem_common::testcase)
	   "one_write_one_read":begin
	//write
	  tx=new();
      tx.randomize() with {wr_rd==1;};
	   mem_common::gen2bfm.put(tx);
	   addr_t.push_back(tx.addr);  //storing in temporay address
	 // tx.print("mem_gen");

	  	  //read
		  tx=new();
      tx.randomize()with{wr_rd==0;data==0;addr==addr_t.pop_front();};
	   mem_common::gen2bfm.put(tx);
	 // tx.print("mem_gen");
     end

	   "N_writes_N_reads":begin
	//write
	repeat(mem_common::N)begin
	  tx=new();
      tx.randomize() with {wr_rd==1; !(addr inside {tx.tx_addr});};
      // tx_addr.push_back(tx.addr);
	   mem_common::gen2bfm.put(tx);
	   addr_t.push_back(tx.addr);  //storing in temporay address
	 // tx.print("mem_gen");
    end
	  	  //read
	repeat(mem_common::N)begin
		  tx=new();
      tx.randomize()with{wr_rd==0;data==0;addr==addr_t.pop_front();};
	   mem_common::gen2bfm.put(tx);
	 // tx.print("mem_gen");
      end
	  end

   	   "CONSECUTIVE_WRITES_READS":begin
	repeat(mem_common::N)begin
	  tx=new();
      tx.randomize() with {wr_rd==1; !(addr inside {tx.tx_addr});};
      // tx_addr.push_back(tx.addr);
	   mem_common::gen2bfm.put(tx);
	   addr_t.push_back(tx.addr);  //storing in temporay address
	 // tx.print("mem_gen");
   		  tx=new();
      tx.randomize()with{wr_rd==0;data==0;addr==addr_t.pop_front();};
       mem_common::gen2bfm.put(tx);
	 // tx.print("mem_gen");
     end
   end

     endcase
	endtask
	
  endclass



