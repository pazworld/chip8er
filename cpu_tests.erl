-module(cpu_tests).
-include_lib("eunit/include/eunit.hrl").

return_unimplemented_with_unimplemented_opcode_test() ->
    ?assertEqual(unimplemented, cpu:alu(0)).

a21e_set_21e_to_i_register_test() ->
    {_, I} = cpu:alu(<<16#A21E:16>>),
    ?assertEqual(16#21E, I).

c201_set_0_or_1_to_v2_register_test() ->
    {_, {_, V2}} = cpu:alu(<<16#C201:16>>),
    ?assert(V2 =:= 0 orelse V2 =:= 1).

op3201_skip_next_if_v2_register_is_01_test() ->
    PC = cpu:alu(<<16#3201:16>>),
    ?assertEqual(16#201, PC).
