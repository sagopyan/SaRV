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


always @ *
begin
    imm20_r     = {instructionD[31:12], 12'b0};
    imm12_r     = {{20{instructionD[31]}}, instructionD[31:20]};
    bimm_r      = {{19{opcode_opcode_i[31]}}, instructionD[31], instructionD[7], instructionD[30:25], instructionD[11:8], 1'b0};
    jimm20_r    = {{12{instructionD[31]}}, instructionD[19:12], instructionD[20], instructionD[30:25], instructionD[24:21], 1'b0};
    shamt_r     = instructionD[24:20];
end


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