module top;
  reg clk,res;
  mem_intf pif(clk,res);
 // mem_program m_prog();
  mem_env env;
 // assign pif.clk=clk;
  //assign pif.res=res;

  memory #(`WIDTH,`DEPTH,`ADDR_WIDTH) dut (.clk(pif.clk),.res(pif.res),.wr_rd(pif.wr_rd),.addr(pif.addr),.wdata(pif.wdata),.valid(pif.valid),.rdata(pif.rdata),.ready(pif.ready));

  mem_assert #(`WIDTH,`DEPTH,`ADDR_WIDTH) assert_inst(.clk(pif.clk),.res(pif.res),.wr_rd(pif.wr_rd),.addr(pif.addr),.wdata(pif.wdata),.valid(pif.valid),.rdata(pif.rdata),.ready(pif.ready));



  
//  memory #(
//   .WIDTH(`WIDTH),
//   .DEPTH(`DEPTH),
//   .ADDR_WIDTH(`ADDR_WIDTH)
//) dut (
//   .clk(pif.clk),
//   .res(pif.res),
//   .wr_rd(pif.wr_rd),
//   .wdata(pif.wdata),
//   .addr(pif.addr),
//   .rdata(pif.rdata),
//   .ready(pif.ready),
//   .valid(pif.valid)
//);
//


   always #5 clk=~clk;     
	   initial begin
	   clk=0;
          res=1;
		  repeat(2)@(posedge clk);
		    res=0;
		  end
        initial begin
		    $value$plusargs("testcase=%0s",mem_common::testcase);
		    $value$plusargs("N=%0d",mem_common::N);
            $value$plusargs("num_agents=%0d",mem_common::num_agents);
            $display("%0s %0d ",mem_common::testcase,mem_common::N);
		   env=new();
		   env.run();
        end 
  initial begin
  $dumpfile("waveform.vcd");   // Name of the dump file
  $dumpvars(0, top);           // top is your top module name
end

       initial begin
	   #5000;
	   wait(mem_common::N*2*mem_common::num_agents==mem_common::bfm_tx_driven);
	   $display(mem_common::bfm_tx_driven);
	   if(mem_common::matchs>mem_common::N*mem_common::num_agents && mem_common::miss_matches==0) begin
           
           $display("######## \n \t\t  TESTCASE PASSED \n \t\t  matches=%0d \t\t miss_matches=%0d  \n #########\n", mem_common::matchs,mem_common::miss_matches);
           
         end
         else
           $display("######## \n \t\t  TESTCASE FAILED \n \t\t  matches=%0d \t\t miss_matches=%0d  \n #########\n", mem_common::matchs,mem_common::miss_matches);	   $display("######\n  \t\t\t overal FC :: %0f   \n######",$get_coverage());
	   $finish;
	   end
   endmodule





