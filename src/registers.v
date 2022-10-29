

`include "opcodes.v"
`include "src/define.v"

module registers(clk, rst, ar1i,ar2i, ar3i,r3i,we3, r1o,r2o,r1do,r2do );
    input clk,rst;

    input [4:0] ar1i;
    input [4:0] ar2i;
    input [4:0] ar3i;
    input [31:0] r3i;
    input [1:0] we3;

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
    
     if(ar3i!=0) begin
      case(we3)
        `MEM_WRITE_8    :  regs[ar3i]  <={24'b0,r3i[7:0]};
        `MEM_WRITE_16   :  regs[ar3i]  <={16'b0,r3i[15:0]};
        `MEM_WRITE_32   :  regs[ar3i]  <=r3i;
        default : regs[ar3i]<=0;
      endcase
        end

    end
end


endmodule