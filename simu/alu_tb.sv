`timescale 1ns/1ps
`include "../src/define.v"

module alu_tb;

  reg clk, reset;
  reg [31:0] d1,d2;
  wire [31:0] dout;
  reg [3:0] op;


  always #10 clk = ~clk;
  localparam period=20;
    alu alu0(
        .clk(clk), 
        .rst(reset), 
        .d1(d1),
        .d2(d2), 
        .op(op),
        .dout(dout)
         ); 
  initial begin

 //   $dumpfile("dump.vcd");
//    $dumpvars(0,regs);
     clk = 0;
     reset = 1;
     

     #50 reset = 0;

     d1<= 32'hFFFFFFF6;
     d2<=32'b1;
     op<=`SRL;

     #40
     if (dout != 32'h7FFFFFFb) begin 
      $error("SRL failed dout should be h7FFFFFFb and is %x ",dout);   
     end
     d1<= 32'hFFFFFFF6;
     d2<=32'b1;
     op<=`SRA;
     


     #40

     if (dout != 32'hFFFFFFFb) begin
      $error("SRA failed");
     end
     
     #100 $finish;
  end // initial begin

endmodule // main