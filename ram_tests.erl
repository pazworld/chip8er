-module(ram_tests).
-include_lib("eunit/include/eunit.hrl").

make_new_memory_image_test() ->
    RAM = ram:new_ram(),
    ?assertEqual(16#1000, byte_size(RAM)).

read_byte_test() ->
    RAM = ram:new_ram(),
    ?assertEqual(0, ram:at(16#200, RAM)).

load_rom_image_test() ->
    RAM = ram:new_ram(),
    RAM2 = ram:load_file(16#200, "maze.ch8", RAM),
    ?assertEqual(16#A2, ram:at(16#200, RAM2)).
