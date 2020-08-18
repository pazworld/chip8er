-module(ui).
-export([setup/0, getpixel/2]).
-include_lib("wx/include/wx.hrl").

setup() ->
    Wx = wx:new(),
    wxFrame:new(Wx, ?wxID_ANY, "chip8er").

getpixel(Obj, {X, Y}) ->
    DC = wxClientDC:new(Obj),
    {_, Color} = wxDC:getPixel(DC, {X, Y}),
    Color.
