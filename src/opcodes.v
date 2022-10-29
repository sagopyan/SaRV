// U/J type
// U - LUI     0110111
// U - AUIPC   0010111
// J - JAL     1101111

`define LUI       7'b0110111
`define AUIPC     7'b0010111
`define JAL       7'b1101111
`define JAL_R     7'b1100111

// B type
//       f    op

`define BRANCH 7'b 1100011
      `define BRF_BEQ   3'b000      // BEQ  000 1100011
      `define BRF_BNE   3'b001      // BNE  001 1100011
      `define BRF_BLT   3'b100      // BLT  100 1100011
      `define BRF_BGE   3'b101      // BGE  101 1100011
      `define BRF_BLTU  3'b110      // BLTU 110 1100011 
      `define BRF_BGEU  3'b111      // BGEU 111 1100011 

//S type
`define STORE 0100011
      `define SF_SB   3'b000  //SB   000  0100011 
      `define SF_SH   3'b001  //SH   001  0100011 
      `define SF_SW   3'b010  //SW   010  0100011 

//I type
//      f3     op
`define LOAD 7'b0000011
      `define IF_LB   3'b000     //LB   000  0000011     
      `define IF_LH   3'b001     //LH   001  0000011
      `define IF_LW   3'b010     //LW   010  0000011
      `define IF_LBU  3'b100     //LBU  100  0000011 
      `define IF_LHU  3'b101     //LHU  101  0000011 


`define OP_IM  7'b0010011
      `define OPF_ADDI  3'b000  //ADDI  000  0010011
      `define OPF_SLTI  3'b010  //SLTI  010  0010011
      `define OPF_SLTIU 3'b011  //SLTIU 011  0010011
      `define OPF_XORI  3'b100  //XORI  100  0010011
      `define OPF_ORI   3'b110  //ORI   110  0010011
      `define OPF_ANDI  3'b111  //ANDI  111  0010011

//R type
//        f7    f3    op  
//`define SHIFT 7'b0010011
      `define SF3_SLLI 3'b001 //SLLI 0000000 001  0010011 
      `define SF3_SRLI 3'b101 //SRLI 0000000 101  0010011 
      `define SF3_SRAI 3'b101 //SRAI 0100000 101  0010011 
      `define SF7_SLLI 7'b0000000 //SLLI 0000000 001  0010011 
      `define SF7_SRLI 7'b0000000 //SRLI 0000000 101  0010011 
      `define SF7_SRAI 7'b0100000 //SRAI 0100000 101  0010011 

`define OP_R 7'b0110011
      `define OPF3_ADD  3'b000//0000000 000  0110011    
      `define OPF3_SUB  3'b000//0100000 000  0110011    
      `define OPF3_SLL  3'b001//0000000 001  0110011    
      `define OPF3_SLT  3'b010//0000000 010  0110011    
      `define OPF3_SLTU 3'b011//0000000 011  0110011  
      `define OPF3_XOR  3'b100//0000000 100  0110011    
      `define OPF3_SRL  3'b101//0000000 101  0110011    
      `define OPF3_SRA  3'b101//0100000 101  0110011    
      `define OPF3_OR   3'b110//0000000 110  0110011    
      `define OPF3_AND  3'b111//0000000 111  0110011    
      
      `define OPF7_ADD  7'b0000000
      `define OPF7_SUB  7'b0100000
      `define OPF7_SLL  7'b0000000
      `define OPF7_SLT  7'b0000000
      `define OPF7_SLTU 7'b0000000
      `define OPF7_XOR  7'b0000000
      `define OPF7_SRL  7'b0000000
      `define OPF7_SRA  7'b0100000
      `define OPF7_OR   7'b0000000
      `define OPF7_AND  7'b0000000
 
 
`define FENCE 7'b0001111
`define EXEC 7'b1110011
      `define EX_CALL 5'b0
      `define EX_BREAK 7'b1

//1000 0011 0011 00000 000 00000 0001111 FENCE.TSO
//0000 0001 0000 00000 000 00000 0001111 PAUSE
//0000 0000 0000 00000 000 00000 1110011 ECALL
//0000 0000 0001 00000 000 00000 1110011 EBREAK
 