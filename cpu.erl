-module(cpu).
-export([alu/1]).

alu(<<16#A:4, Operand:12>>) ->
    {ok, Operand};

alu(_) ->
    unimplemented.
