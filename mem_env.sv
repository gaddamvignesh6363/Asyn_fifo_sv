class mem_env;
   mem_agt agt[];
   mem_mon mon;
   mem_cov cov;
   mem_sbd sbd;
   task run();
     $display("********* mem_env ********");
	 agt=new[mem_common::num_agents];
	   foreach(agt[i]) begin
	       agt[i]=new(i);
		   end
		   foreach(agt[i])begin
		   fork
		     agt[i].run();
					//	 $display("#######    i=%0d  ##########", i);
			join_none
			 #0;
		   end
		   fork
		   	mon.run();
			cov.run();
			sbd.run();
			join
		
     endtask
	 endclass

