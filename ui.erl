-module(ui).
-export([setup/0]).
-include_lib("wx/include/wx.hrl").

setup() ->
    Wx = wx:new(),
    wxFrame:new(Wx, ?wxID_ANY, "chip8er").
