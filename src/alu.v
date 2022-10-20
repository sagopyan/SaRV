
`include "define.v"

module alu(clk, rst, d1,d2, op,dout );
    input clk,rst;

    input [2:0] op;
    output reg [31:0] dout;

    input [31:0] d1;
    input [31:0] d2;

    wire signed[31:0] d1s,d2s;

assign r1do = regs[ar1i];
assign r2do = regs[ar2i];
assign d1s = d1;
assign d2s = d2;

always @ (posedge clk) begin
    if(rst==1'b1) begin
        dout<=32'b0;
    end
    else begin
        case(op)
            `ADD : dout<=d1+d2;
            `SUB : dout<=d1-d2;
            `OR  : dout<=d1|d2;
            `XOR : dout<=d1^d2;
            `AND : dout<=d1&d2;
            `SRL : dout<=d1>>d2;
            `SLL : dout<=d1<<d2;
            `SLT : if(d1s < d2s) dout<=32'b1; else dout <=32'b0;
        endcase
    end
end


endmodule