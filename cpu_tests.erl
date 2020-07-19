-module(cpu_tests).
-include_lib("eunit/include/eunit.hrl").

return_unimplemented_with_unimplemented_opcode_test() ->
    ?assertEqual(unimplemented, cpu:alu(0)).
