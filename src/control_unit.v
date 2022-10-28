
`include "opcodes.v"
`include "define.v"
module control_unit(clk, rst, op,func3, func7 );
    input clk,rst;

    input wire [6:0] op;
    input wire [2:0] func3;
    input wire [6:0] func7;

    wire [4:0] alu_ctrl;
    wire jump;
    wire [2:0] branch;
    wire [1:0]imm_src;
    wire reg_write; //active when write to regfile
    wire [1:0]mem_write; //active when write to regfile
    wire alu_src;

    wire error;

     always @* begin

    case(op)  
      `BRANCH    :       begin     
            imm_src=`IMM12;
            mem_write=2'b0;
            reg_write=1'b0;
            alu_src = `ALU_IMM;
            jump =1'b0;
            case(func3)
                `BRF_BEQ   : begin branch = 2'b01; alu_ctrl=`SUB;   end
                `BRF_BNE   : begin branch = 2'b00; alu_ctrl=`SUB;   end   
                `BRF_BLT   : begin branch = 2'b10; alu_ctrl=`SLT;   end  
                `BRF_BGE   : begin branch = 2'b00; alu_ctrl=`SLT;   end   
                `BRF_BLTU  : begin branch = 2'b10; alu_ctrl=`SLTU;  end    
                `BRF_BGEU  : begin branch = 2'b00; alu_ctrl=`SLTU;  end   
                default : error =1'b1;
            endcase 

      end
      `STORE    :begin
            imm_src=`IMM12;
            alu_ctrl=`ADD;
            reg_write=1'b0;
            alu_src = `ALU_IMM;
            jump =1'b0;
            case(func3)
                `SF_SB : begin  mem_write=`MEM_WRITE_8 ;   end
                `SF_SH : begin  mem_write=`MEM_WRITE_16;   end   
                `SF_SW : begin  mem_write=`MEM_WRITE_32;   end  
            endcase 
      end 
      `LOAD    : begin
            imm_src=`IMM12;
            alu_ctrl=`ADD;
            mem_write=2'b0;
            alu_src = `ALU_IMM;
            jump =1'b0;
            case(func3)
                `IF_LB  : begin  reg_write=`MEM_WRITE_8 ;   end
                `IF_LH  : begin  reg_write=`MEM_WRITE_16;   end   
                `IF_LW  : begin  reg_write=`MEM_WRITE_32;   end  
                `IF_LBU : begin  reg_write=`MEM_WRITE_16;   end   
                `IF_LHU : begin  reg_write=`MEM_WRITE_32;   end  
            endcase 
      end   
      `LUI    : 
        begin
            imm_src=`IMM20SHIFTED;

        end    
      `AUIPC    : 
        begin
            imm_src=`IMM20SHIFTED;

        end  
      `JAL_R    :
        begin 
            jump=1'b1;
            imm_src=`IMM12;
        end   
      `JAL     : 
        begin 
            jump=1'b1;
            imm_src=`IMM20;

        end

      `OP_IM    : 
        begin 
            alu_input=1'b1;
            imm_src=`IMM12;
            case(func3)
                `OPF_ADDI   : begin alu_ctrl = `ADD ;   reg_write = 1'b1;  alu_src =1'b1; end
                `OPF_SLTI   : begin alu_ctrl = `SLT ;   reg_write = 1'b1;  alu_src =1'b1; end   
                `OPF_SLTIU  : begin alu_ctrl = `SLTU;   reg_write = 1'b1;  alu_src =1'b1; end  
                `OPF_XORI   : begin alu_ctrl = `XOR ;   reg_write = 1'b1;  alu_src =1'b1; end   
                `OPF_ORI    : begin alu_ctrl = `OR  ;   reg_write = 1'b1;  alu_src =1'b1; end    
                `OPF_ANDI   : begin alu_ctrl = `AND ;   reg_write = 1'b1;  alu_src =1'b1; end   
                default : error =1'b1;
            endcase  
        end
      `SHIFT    : begin
            imm_src=`IMM_SHAMT;
      end   
      `OP_R    :
        begin
            alu_input=1'b0;

            case(func3)
                `OPF3_ADD   : begin alu_ctrl = `ADD ;    reg_write = 1'b1;  alu_src =1'b0; end
                `OPF3_SLL   : begin alu_ctrl = `SLL ;    reg_write = 1'b1;  alu_src =1'b0; end   
                `OPF3_SLT   : begin alu_ctrl = `SLT ;    reg_write = 1'b1;  alu_src =1'b0; end  
                `OPF3_SLTU  : begin alu_ctrl = `SLTU;    reg_write = 1'b1;  alu_src =1'b0; end   
                `OPF3_XOR   : begin alu_ctrl = `XOR  ;   reg_write = 1'b1;  alu_src =1'b0; end    
                `OPF3_SRL   : begin alu_ctrl = `SRL ;    reg_write = 1'b1;  alu_src =1'b0; end       
                `OPF3_SRA   : begin alu_ctrl = `SRA ;    reg_write = 1'b1;  alu_src =1'b0; end       
                `OPF3_OR    : begin alu_ctrl = `OR ;     reg_write = 1'b1;  alu_src =1'b0; end       
                `OPF3_AND   : begin alu_ctrl = `AND ;    reg_write = 1'b1;  alu_src =1'b0; end       
                default : error =1'b1;
            endcase 
        end
      `FENCE    : out = c;     
      `EXEC    : out = c;      

      default  : out = 0;      

    endcase 
     end



endmodule