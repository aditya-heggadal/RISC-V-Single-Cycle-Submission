module ex_stage(
    input logic [31:0] rs1_data, rs2_data, imm_out, address,
    input logic branch, alu_src, fn7_5, mux_inp,
    input logic [2:0] fn3,
    input logic [6:0] imm11_5,
    input logic [2:0] aluop,
    input logic [6:0] opcode,
    output logic and_out_ex,
    output logic [31:0] alu_out, pc_ex_out
);
    logic [31:0] operand_b;
    logic [4:0] alu_code;
    logic zero;
    assign operand_b = alu_src ? imm_out : rs2_data;
    alu_control ac(.alu_op(aluop),.fn3(fn3),.imm11_5(imm11_5),
        .fn7_5(fn7_5),.control_out(alu_code));
    alu #(.DATA_WIDTH(32)) alu_i(.alu_control(alu_code),.rs1_data(rs1_data),
        .rs2_data(operand_b),.alu_out(alu_out),.zero(zero));
    always_comb begin
        pc_ex_out = mux_inp ? {alu_out[31:1],1'b0} : address+imm_out;
        and_out_ex = (branch && zero) || (opcode==7'h6F) || (opcode==7'h67);
    end
endmodule
