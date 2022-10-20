`timescale 1ns/1ps
module main;

  reg clk, reset;
    reg[4:0] ar1,ar2,ar3;
    wire[31:0] r1,r2;
    wire[31:0] r1d,r2d;
    reg [31:0] r3;
    reg we3;


  always #10 clk = ~clk;

    registers regs(
        .clk(clk), 
        .rst(reset), 
        .ar1i   (ar1),
        .ar2i   (ar2), 
        .ar3i   (ar3),
        .r3i    (r3),
        .we3    (we3), 
        .r1o    (r1),
        .r2o    (r2), 
        .r1do    (r1d),
        .r2do    (r2d) );

  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0,regs);
     clk = 0;
     reset = 1;
     ar1    <= 5'b0;
     ar2    <= 5'b0;
     ar3    <= 5'b0;
     r3     <= 31'd1;
     we3    <= 5'b0;

     #50 reset = 0;


     for(integer i=0;i<32;i++) begin
     
        we3 <= 1'b1;
        r3  <= r3+32'd2;
        #20;
        ar3 <= ar3+1'b1;

     end
     we3 <= 1'b0;
     #40
    for(integer i=0;i<32;i++) begin
        ar1<=ar1+1'b1;
        //ar2<=ar2+2'd2;
        #20;

     end

     #100 $finish;
  end // initial begin

endmodule // main