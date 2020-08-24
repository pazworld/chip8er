-module(ui).
-export([setup/0, getpixel/2, drawdot/4]).
-include_lib("wx/include/wx.hrl").

setup() ->
    Wx = wx:new(),
    wxFrame:new(Wx, ?wxID_ANY, "chip8er").

getpixel(Obj, {X, Y}) ->
    DC = wxClientDC:new(Obj),
    {_, Color} = wxDC:getPixel(DC, {X, Y}),
    Color.

%drawscreen(Obj, VRAM) ->
%    [ || X <- lists:seq(0, 63), Y <- lists:seq(0, 31)].

drawdot(Obj, X, Y, Bit) ->
    DC = wxClientDC:new(Obj),
    Color = case Bit of
        0 -> ?wxBLACK;
        1 -> ?wxWHITE
    end,
    Brush = wxBrush:new(Color),
    wxDC:setBrush(DC, Brush),
    Pen = wxPen:new(Color),
    wxDC:setPen(DC, Pen),
    wxDC:drawRectangle(DC, {X * 4, Y * 4, 4, 4}).
