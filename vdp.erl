-module(vdp).
-export([new_vram/0, pixel/3, setpixel/4, setbyte/4, setbytes/4, bitlist/1]).

new_vram() ->
    [0 || _ <- lists:seq(1, 64 * 32)].

idx(X, Y) ->
    Y * 64 + (X rem 64).

pixel(X, Y, VRAM) ->
    lists:nth(idx(X, Y) + 1, VRAM).

setpixel(X, Y, Value, VRAM) ->
    Idx = idx(X, Y),
    Left = lists:sublist(VRAM, Idx),
    Right = [Value | lists:nthtail(Idx + 1, VRAM)],
    Left ++ Right.

setbyte(X, Y, Byte, VRAM) ->
    F = fun(Bit, {AX, AccVRAM}) ->
        NextVRAM = setpixel(X + AX, Y, Bit, AccVRAM),
        {AX + 1, NextVRAM}
    end,
    {_, VRAM2} = lists:foldl(F, {0, VRAM}, bitlist(Byte)),
    VRAM2.

setbytes(X, Y, Bytes, VRAM) ->
    F = fun(Byte, {AY, AccVRAM}) ->
        NextVRAM = setbyte(X, Y + AY, Byte, AccVRAM),
        {AY + 1, NextVRAM}
    end,
    {_, VRAM2} = lists:foldl(F, {0, VRAM}, Bytes),
    VRAM2.

bitlist(Byte) ->
    [X - $0 || X <- io_lib:format("~8.2.0B", [Byte])].
