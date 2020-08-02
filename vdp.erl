-module(vdp).
-export([new_vram/0, pixel/3, setpixel/4, setbyte/4, bitlist/1]).

new_vram() ->
    [0, 0, 0, 0].

idx(X, Y) ->
    Y * 64 + (X rem 64).

pixel(X, Y, VRAM) ->
    lists:nth(idx(X, Y) + 1, VRAM).

setpixel(X, Y, Value, VRAM) ->
    Idx = idx(X, Y),
    Left = lists:sublist(VRAM, Idx),
    Right = [Value | lists:nthtail(Idx + 1, VRAM)],
    Left ++ Right.

setbyte(_X, _Y, _Byte, _VRAM) ->
    [1, 1, 0, 0].

bitlist(Byte) ->
    [X - $0 || X <- io_lib:format("~8.2.0B", [Byte])].
