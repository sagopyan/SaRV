module corerv(clk, rst, axi_imem_aread, axi_imem_arvalid, axi_imem_rvalid );

reg [31:0] instructionD,r1D,r2D;
wire ar1;
wire ar2;
wire instructionD_valid;

assign ar1D = instructionD[19:15];
assign ar2D = instructionD[24:20];

    registers regs(
        .clk(clk), 
        .rst(reset), 
        .ar1i   (ar1D),
        .ar2i   (ar2D), 
        .ar3i   (ar3),
        .r3i    (r3),
        .we3    (we3), 
        .r1do    (r1D),
        .r2do    (r2D) );


// increment pc only when instruction is valid
always@(posedge clk) begin
    if(rst ==1'b1) begin
        PCF<=31'b0;
    end
    else begin
        if(instructionD_valid==1'b1) 
            PCF<=PCF+4'd4;
    end
end

endmodule