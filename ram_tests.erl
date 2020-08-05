-module(ram_tests).
-include_lib("eunit/include/eunit.hrl").

make_new_memory_image_test() ->
    RAM = ram:new_ram(),
    ?assertEqual(16#1000, byte_size(RAM)).
