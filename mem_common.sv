`define WIDTH 16
`define DEPTH 64
`define ADDR_WIDTH $clog2(`DEPTH)
 class mem_common;
   static mailbox gen2bfm=new();
   static mailbox mon2sbd=new();
   static mailbox mon2cov=new();
   static int num_agents=3;
   static semaphore mem_smp=new();
   static string testcase;
   static int N;
   static int miss_matches;
   static int matchs;
   static int bfm_tx_driven;
 endclass

