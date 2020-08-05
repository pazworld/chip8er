-module(ram).
-export([new_ram/0]).

new_ram() ->
    << <<0>> || _ <- lists:seq(0, 16#FFF) >>.
