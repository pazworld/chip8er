-module(vdp_tests).
-include_lib("eunit/include/eunit.hrl").

read_pixel_0_0_test() ->
    VRAM = vdp:new_vram(),
    ?assertEqual(0, vdp:pixel(0, 0, VRAM)).

write_pixel_0_0_test() ->
    VRAM = vdp:new_vram(),
    VRAM2 = vdp:setpixel(0, 0, 1, VRAM),
    ?assertEqual(1, vdp:pixel(0, 0, VRAM2)).

write_pixel_by_byte_test() ->
    VRAM = vdp:new_vram(),
    VRAM2 = vdp:setbyte(0, 0, 16#C0, VRAM),
    ?assertEqual(1, vdp:pixel(0, 0, VRAM2)),
    ?assertEqual(1, vdp:pixel(1, 0, VRAM2)),
    ?assertEqual(0, vdp:pixel(2, 0, VRAM2)).

divide_byte_into_bit_list_test() ->
    ?assertEqual([1, 1, 0, 0, 0, 1, 0, 1], vdp:bitlist(16#C5)).
