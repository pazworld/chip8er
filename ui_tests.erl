-module(ui_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("wx/include/wx.hrl").

ui_setup_return_wxFrame_test() ->
    F = ui:setup(),
    ?assertEqual(wx_ref, element(1, F)).

%ui_draw_content_of_vram_test() ->
%    Color = ui:getPixel(F, {0, 0}),
%    {_, Color} = wxDC:getPixel(DC, {0, 0}),
%    ?assertEqual(0, Color).

ui_getpixel_return_pixel_color_test() ->
    F = ui:setup(),
    wxFrame:show(F),
    DC = wxClientDC:new(F),
    Brush = wxBrush:new(?wxBLACK),
    wxDC:setBrush(DC, Brush),
    wxDC:drawRectangle(DC, {0, 0, 100, 100}),
    Color = ui:getpixel(F, {0, 0}),
    wxFrame:destroy(F),
    ?assertEqual(?wxBLACK, Color).
