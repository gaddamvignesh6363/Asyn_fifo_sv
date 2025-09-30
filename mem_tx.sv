class mem_tx;
   rand bit wr_rd;
   rand bit [`ADDR_WIDTH-1:0] addr;
  rand bit [`WIDTH-1:0] data;
  static bit [`ADDR_WIDTH-1:0] tx_addr[$];

     //   bit [`WIDTH-1:0] rdata;
   function void pre_randomize();
        if(tx_addr.size==`DEPTH)
		tx_addr.delete();
   endfunction
   function void post_randomize();
         tx_addr.push_back(addr);
   endfunction
   function void print(string str="mem_tx");
     $display("*** string=%s wr_rd=%s addr=%0h data=%0h", str, wr_rd?"WRITE":"READ", addr, data);
		  
   endfunction
   endclass

