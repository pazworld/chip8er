-module(cpu_tests).
-include_lib("eunit/include/eunit.hrl").

-record(regs, {pc, i, v={0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, ram= <<>>, vram=[]}).

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

d014_draw_4_bytes_at_v0_v1_test() ->
    RAM = <<255, 255, 255, 255>>,
    VRAM = vdp:new_vram(),
    R = #regs{i=0, v={0, 0}, ram=RAM, vram=VRAM},
    {_, R2} = cpu:alu(<<16#D014:16>>, R),
    VRAM2 = R2#regs.vram,
    ?assertEqual(1, vdp:pixel(0, 0, VRAM2)).

single_step_test() ->
    PC = 16#200,
    RAM = ram:load_file(16#200, "maze.ch8", ram:new_ram()),
    VRAM = vdp:new_vram(),
    R = #regs{pc=PC, i=0, v={0}, ram=RAM, vram=VRAM},
    R2 = cpu:step(R),
    I = R2#regs.i,
    ?assertEqual(16#21E, I).
