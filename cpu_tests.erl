-module(cpu_tests).
-include_lib("eunit/include/eunit.hrl").

-record(regs, {pc, i, v={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}}).

return_unimplemented_with_unimplemented_opcode_test() ->
    ?assertEqual(unimplemented, cpu:alu(0, #regs{})).

a21e_set_21e_to_i_register_test() ->
    {_, R} = cpu:alu(<<16#A21E:16>>, #regs{i=0}),
    I = R#regs.i,
    ?assertEqual(16#21E, I).

c201_set_0_or_1_to_v2_register_test() ->
    {_, R} = cpu:alu(<<16#C201:16>>, #regs{}),
    V2 = element(2 + 1, R#regs.v),
    ?assert(V2 =:= 0 orelse V2 =:= 1).

op3201_skip_next_if_v2_register_is_01_test() ->
    {_, PC} = cpu:alu(<<16#3201:16>>, #regs{pc=16#300, v={0, 0, 1}}),
    ?assertEqual(16#301, PC).
