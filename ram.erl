-module(ram).
-export([new_ram/0, at/2]).

new_ram() ->
    << <<0>> || _ <- lists:seq(0, 16#FFF) >>.

at(Adr, RAM) ->
    <<Byte>> = binary_part(RAM, Adr, 1),
    Byte.
