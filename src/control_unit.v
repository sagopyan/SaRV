
`include "opcodes.v"
`include "define.v"
module control_unit(clk, rst, op,func3, func7,
            alu_ctrl,
            jump,
            branch, 
            imm_src, 
            reg_write, 
            mem_write, 
            alu_src,
            result_src 
        );

    input clk,rst;

    input wire [6:0] op;
    input wire [2:0] func3;
    input wire [6:0] func7;

    output reg  [4:0] alu_ctrl;
    output reg        jump;
    output reg  [2:0] branch;
    output reg  [1:0] imm_src;
    output reg  [1:0] reg_write; //active when write to regfile
    output reg  [1:0] mem_write; //active when write to regfile
    output reg        alu_src;
    output reg  [1:0] result_src;

    output reg  error;

     always @* begin

    case(op)  
      `BRANCH    :       begin     
            imm_src<=`IMM12;
            mem_write<=2'b0;
            reg_write<=1'b0;
            alu_src <= `ALU_IMM;
            jump <=1'b0;
            case(func3)
                `BRF_BEQ   : begin branch <= 2'b01; alu_ctrl<=`SUB;   end
                `BRF_BNE   : begin branch <= 2'b00; alu_ctrl<=`SUB;   end   
                `BRF_BLT   : begin branch <= 2'b10; alu_ctrl<=`SLT;   end  
                `BRF_BGE   : begin branch <= 2'b00; alu_ctrl<=`SLT;   end   
                `BRF_BLTU  : begin branch <= 2'b10; alu_ctrl<=`SLTU;  end    
                `BRF_BGEU  : begin branch <= 2'b00; alu_ctrl<=`SLTU;  end   
                default : error <=1'b1;
            endcase 

      end
      `STORE    :begin
            imm_src    <=`IMM12;
            alu_ctrl   <=`ADD;
            alu_src    <= `ALU_IMM;
            jump       <=1'b0;
            branch     <= 2'b0;
            reg_write  <=1'b0;

            case(func3)
                `SF_SB : begin  mem_write=`MEM_WRITE_8 ;   end
                `SF_SH : begin  mem_write=`MEM_WRITE_16;   end   
                `SF_SW : begin  mem_write=`MEM_WRITE_32;   end  
            endcase 
      end 

      `LOAD    : begin
            imm_src    <=`IMM12;
            alu_ctrl   <=`ADD;
            mem_write  <=2'b0;
            alu_src    <= `ALU_IMM;
            jump       <=1'b0;
            case(func3)
                `IF_LB  : begin  reg_write <=`MEM_WRITE_8 ;   end
                `IF_LH  : begin  reg_write <=`MEM_WRITE_16;   end   
                `IF_LW  : begin  reg_write <=`MEM_WRITE_32;   end  
                `IF_LBU : begin  reg_write <=`MEM_WRITE_16;   end   
                `IF_LHU : begin  reg_write <=`MEM_WRITE_32;   end  
            endcase     
      end   
      `LUI    : 
        begin
            imm_src    <=`IMM20SHIFTED;
            reg_write  <=1'b1;
            alu_ctrl   <=`ADD;
            mem_write  <=2'b0;
            alu_src    <= `ALU_REG;
            jump       <=1'b0;
            branch     <= 2'b0;

        end    
      `AUIPC    : 
        begin
            imm_src    <=`IMM20SHIFTED;
            alu_ctrl   <=`ADD;
            alu_src    <=`ALU_REG;
            reg_write  <=`MEM_WRITE_32;
            mem_write  <=2'b0;
            
            jump       <=1'b0;
            branch     <= 2'b0;
        end  
      `JAL_R    :
        begin 
            jump   <=1'b1;
            branch <= 2'b0;
            imm_src<=`IMM12;

            reg_write  <=1'b0;
            mem_write  <=2'b0;

        end   
      `JAL     : 
        begin 
            jump   <=1'b1;
            branch <= 2'b0;
            imm_src<=`IMM20;

            reg_write  <=1'b0;
            mem_write  <=2'b0;
        end

      `OP_IM    : 
        begin 
            imm_src    <=`IMM12;
            reg_write  <= `MEM_WRITE_32; 
            mem_write  <= 2'b0;
            alu_src    <=`ALU_IMM;
            case(func3)
                `OPF_ADDI   : begin alu_ctrl<= `ADD ;     end
                `OPF_SLTI   : begin alu_ctrl<= `SLT ;     end   
                `OPF_SLTIU  : begin alu_ctrl<= `SLTU;     end  
                `OPF_XORI   : begin alu_ctrl<= `XOR ;     end   
                `OPF_ORI    : begin alu_ctrl<= `OR  ;     end    
                `OPF_ANDI   : begin alu_ctrl<= `AND ;     end   
                `SF3_SLLI   : begin alu_ctrl<= `SLL ;  imm_src=`IMM_SHAMT; end
                `SF3_SRLI   : begin 
                                  
                                imm_src<=`IMM_SHAMT;
                                case(func7)
                                    `SF7_SRLI: alu_ctrl<= `SRL ;
                                    `SF7_SRAI: alu_ctrl<= `SRA ;
                                    default : error<=1'b1;
                                endcase
                            end
                default : error<=1'b1;
            endcase  
        end

      `OP_R    :
        begin
            reg_write<= `MEM_WRITE_32;
            alu_src<=`ALU_REG;
            case(func3)
                `OPF3_ADD   : begin alu_ctrl<= `ADD ;    end
                `OPF3_SLL   : begin alu_ctrl<= `SLL ;    end   
                `OPF3_SLT   : begin alu_ctrl<= `SLT ;    end  
                `OPF3_SLTU  : begin alu_ctrl<= `SLTU;    end   
                `OPF3_XOR   : begin alu_ctrl<= `XOR  ;   end    
                `OPF3_SRL   : begin alu_ctrl<= `SRL ;    end       
                `OPF3_SRA   : begin alu_ctrl<= `SRA ;    end       
                `OPF3_OR    : begin alu_ctrl<= `OR ;     end       
                `OPF3_AND   : begin alu_ctrl<= `AND ;    end       
                default : error<=1'b1;
            endcase 
        end
      `FENCE    :  error<=1'b1;   
      `EXEC    :  error<=1'b1;   

      default  :  error<=1'b1;     

    endcase 
     end



endmodule