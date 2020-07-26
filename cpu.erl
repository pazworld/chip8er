-module(cpu).
-export([alu/2]).

-record(regs, {pc, i, v={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}).

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

alu(_, _) ->
    unimplemented.
