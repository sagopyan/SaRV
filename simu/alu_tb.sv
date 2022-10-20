`timescale 1ns/1ps
`include "define.v"

module main;

  reg clk, reset;
    reg[4:0] ar1,ar2,ar3;
    wire[31:0] r1,r2;
    wire[31:0] r1d,r2d;
    reg [31:0] r3;
    reg we3;


  always #10 clk = ~clk;

    alu alu0(
        .clk(clk), 
        .rst(reset), d1,d2, op,dout ); 
  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,regs);
     clk = 0;
     reset = 1;
     

     #50 reset = 0;



     #40


     #100 $finish;
  end // initial begin

endmodule // main