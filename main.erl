-module(main).
-export([start/0]).

start() ->
    Ui = ui:setup2(),
    ui:loop(Ui),
    ok.
