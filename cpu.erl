-module(cpu).
-export([alu/1]).

alu(<<16#A:4, Operand:12>>) ->
    {ok, Operand};

alu(<<16#C:4, _Reg:4, Mask:8>>) ->
    Random = (rand:uniform(256) - 1) band Mask,
    {ok, {0, Random}};

alu(_) ->
    unimplemented.
