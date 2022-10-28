
`include "define.v"

module alu(clk, rst, d1,d2, op,dout );
    input clk,rst;

    input [3:0] op;
    output reg [31:0] dout;

    input [31:0] d1;
    input [31:0] d2;

    wire signed[31:0] d1s,d2s;
    reg [31:0] ones;
    reg [31:0] test;
    assign d1s = d1;
    assign d2s = d2;

always @ (posedge clk) begin
    if(rst==1'b1) begin
        dout<=32'b0;
        ones<=32'hFFFFFFFF;
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
            `SRA : if(d1[31]==1'b1) begin  
                        dout<=( (d1>>d2) | (ones<<(31-d2)) );  
                        
                   end
                   else begin
                        dout<=d1>>d2; 
                   end
            `SLT : if(d1s < d2s) dout<=32'b1; else dout <=32'b0;
            `SLTU : if(d1 < d2) dout<=32'b1; else dout <=32'b0;
        endcase
    end
end


endmodule