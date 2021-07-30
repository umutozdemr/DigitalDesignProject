module clock1(input logic clk, output logic outclk);
    logic [28:0] ctr = 0;
parameter cd = 28'd2;
always@(posedge clk)
    begin
    ctr <= ctr+ 1;
    if(ctr == 10_000_000 ) ctr <= 0;
    end
assign outclk =(ctr < cd /2) ? 1'b0:1'b1;
endmodule