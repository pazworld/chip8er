-module(cpu).
-export([alu/2, step/1, regs_to_string/1]).
-include("chip8er.hrl").

alu(<<3:4, Reg:4, Operand:8>>, R) ->
    PC = R#regs.pc,
    VR = element(Reg + 1, R#regs.v),
    case VR of
        Operand -> {ok, PC + 1};
        _       -> {ok, PC}
    end;

alu(<<16#A:4, Operand:12>>, R) ->
    {ok, R#regs{i=Operand}};

alu(<<16#C:4, Reg:4, Mask:8>>, R) ->
    Random = (rand:uniform(256) - 1) band Mask,
    V = R#regs.v,
    V2 = setelement(Reg + 1, V, Random),
    {ok, R#regs{v=V2}};

alu(<<16#D:4, Reg1:4, Reg2:4, Size:4>>, R) ->
    X = element(Reg1 + 1, R#regs.v),
    Y = element(Reg2 + 1, R#regs.v),
    I = R#regs.i,
    Bytes = binary_to_list(binary:part(R#regs.ram, I, Size)),
    VRAM = vdp:setbytes(X, Y, Bytes, R#regs.vram),
    {ok, R#regs{vram=VRAM}};

alu(_, _) ->
    unimplemented.

step(R) ->
    RAM = R#regs.ram,
    OpCode1 = ram:at(R#regs.pc, RAM),
    OpCode2 = ram:at(R#regs.pc + 1, RAM),
    OpCode = <<OpCode1, OpCode2>>,
    {ok, R2} = alu(OpCode, R),
    R2.

regs_to_string(R) ->
    PC = R#regs.pc,
    RAM = R#regs.ram,
    OpCode1 = ram:at(PC, RAM),
    OpCode2 = ram:at(PC + 1, RAM),
    <<OpCode:16>> = <<OpCode1:8, OpCode2:8>>,
    I = R#regs.i,
    V = string:join([io_lib:format("~2.16.0B", [X]) || X <- tuple_to_list(R#regs.v)], " "),
    lists:flatten(io_lib:format("~s, ~3.16.0B, ~3.16.0B:~4.16.0B", [V, I, PC, OpCode])).
