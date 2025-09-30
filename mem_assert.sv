

module mem_assert #(parameter WIDTH=16,DEPTH=64,ADDR_WIDTH=$clog2(DEPTH))(
input clk,res,wr_rd,valid,
input [WIDTH-1:0] wdata,
  input [ADDR_WIDTH-1:0] addr,
output reg [WIDTH-1:0] rdata,
  output reg ready);

property handshaking_pr;
  @(posedge clk) valid==1 |=> ready==1;
endproperty
HANDSHAKE_PR:assert property (handshaking_pr);

property wdata_pr;
  @(posedge clk) wr_rd==1 |-> ! ($isunknown(wdata));
endproperty
WDATA_PR:assert property (wdata_pr);

property rdata_pr;
  @(posedge clk) wr_rd==0 |=> ! ($isunknown(rdata));
endproperty
RDATA_PR:assert property (rdata_pr);

property addr_pr;
  @(posedge clk) (valid==1 && res==0) |-> ! ($isunknown(addr));
endproperty
ADDR_PR:assert property (addr_pr);

endmodule
