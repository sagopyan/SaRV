// defines

`ifndef DEFINE_V
`define DEFINE_V

    `define RSIZE 4


    `define ADD 4'b0000
    `define SUB 4'b0001
    `define AND 4'b0010
    `define OR  4'b0011
    `define XOR 4'b0100
    `define SRL 4'b0101
    `define SLL 4'b0110
    `define SLT 4'b0111
    `define SRA 4'b1000
    `define SLTU 4'b1001

    `define IMM20 2'b00
    `define IMM20SHIFTED 2'b10
    `define IMM12 2'b01
    `define IMM_SHAMT 2'b11

    `define ALU_REG = 1'b0
    `define ALU_IMM = 1'b1

    `define MEM_WRITE_8 = 2'b01
    `define MEM_WRITE_16 = 2'b10
    `define MEM_WRITE_32 = 2'b11

`endif
