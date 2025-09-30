class mem_agt;
   mem_gen gen;
   mem_bfm bfm;
      
   function new(int i);
     gen = new();
	 bfm = new(i);
   endfunction
   
   task run();
     $display("********* mem_agt ********");
		fork
			gen.run();
			bfm.run();
	    join
	endtask
	
endclass

