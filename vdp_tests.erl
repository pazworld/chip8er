-module(vdp_tests).
-include_lib("eunit/include/eunit.hrl").

read_pixel_0_0_test() ->
    VRAM = vdp:new_vram(),
    ?assertEqual(0, vdp:pixel(0, 0, VRAM)).
