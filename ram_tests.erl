-module(ram_tests).
-include_lib("eunit/include/eunit.hrl").

make_new_memory_image_test() ->
    RAM = ram:new_ram(),
    ?assertEqual(16#1000, byte_size(RAM)).

read_byte_test() ->
    RAM = ram:new_ram(),
    ?assertEqual(0, ram:at(16#200, RAM)).
