
module registers(clk, rst, ar1i,ar2i, ar3i,r3i,we3, r1o,r2o,r1do,r2do );
    input clk,rst;

    input [4:0] ar1i;
    input [4:0] ar2i;
    input [4:0] ar3i;
    input [31:0] r3i;
    input  we3;

    output reg [31:0] r1o;
    output reg [31:0] r2o;

    output [31:0] r1do;
    output [31:0] r2do;

reg [31:0]  regs [0:31]; 
integer i;

assign r1do = regs[ar1i];
assign r2do = regs[ar2i];

always @ (posedge clk) begin
        r1o<=regs[ar1i];
        r2o<=regs[ar2i];
end

always @(negedge clk) begin
    if(rst==1'b1) begin
         for ( i = 0; i < 16; i = i + 1) 
            regs [i] = 32'h0; 
    end
    else begin
    if(we3==1'b1 && ar3i!=0)
            regs[ar3i]<=r3i;

    end
end


endmodule