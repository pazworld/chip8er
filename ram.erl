-module(ram).
-export([new_ram/0, at/2, load_file/3]).

new_ram() ->
    << <<0>> || _ <- lists:seq(0, 16#FFF) >>.

at(Adr, RAM) ->
    <<Byte>> = binary_part(RAM, Adr, 1),
    Byte.

load_file(Adr, FileName, RAM) ->
    Left = binary_part(RAM, 0, Adr),
    {ok, Content} = file:read_file(FileName),
    RightStart = Adr + byte_size(Content),
    Right = binary_part(RAM, RightStart, byte_size(RAM) - RightStart),
    iolist_to_binary([Left, Content, Right]).
