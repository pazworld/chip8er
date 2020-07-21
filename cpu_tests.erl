-module(cpu_tests).
-include_lib("eunit/include/eunit.hrl").

return_unimplemented_with_unimplemented_opcode_test() ->
    ?assertEqual(unimplemented, cpu:alu(0)).

a21e_set_21e_to_i_register_test() ->
    {_, I} = cpu:alu(<<16#A21E:16>>),
    ?assertEqual(16#21E, I).
