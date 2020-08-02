-module(vdp).
-export([new_vram/0, pixel/3, setpixel/4]).

new_vram() ->
    [0].

pixel(_X, _Y, VRAM) ->
    hd(VRAM).

setpixel(_X, _Y, _Value, _VRAM) ->
    [1].
