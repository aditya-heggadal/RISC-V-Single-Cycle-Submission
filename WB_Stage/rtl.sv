module wb_stage(
    input logic [31:0] mem_out, alu_out, return_addr, imm_out, pc_signed_offset,
    input logic [1:0] memtoreg,
    input logic [6:0] opcode_out_d,
    output logic [31:0] wb_data
);
    always_comb begin
        case(memtoreg)
            2'b00: wb_data=alu_out;
            2'b01: wb_data=mem_out;
            2'b10: case(opcode_out_d)
                7'b1101111,7'b1100111: wb_data=return_addr;
                7'b0110111: wb_data=imm_out;
                7'b0010111: wb_data=pc_signed_offset;
                default: wb_data=alu_out;
            endcase
            default: wb_data=alu_out;
        endcase
    end
endmodule
