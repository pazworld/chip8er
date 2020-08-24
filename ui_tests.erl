-module(ui_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("wx/include/wx.hrl").

ui_setup_return_wxFrame_test() ->
    F = ui:setup(),
    ?assertEqual(wx_ref, element(1, F)).

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

%ui_draw_content_of_vram_test() ->
%    VRAM = vdp:setpixel(0, 0, 1, vdp:new_vram()),
%    F = ui:setup(),
%    wxFrame:show(F),
%    ui:drawscreen(F, VRAM),
%    Color = ui:getpixel(F, {0, 0}),
%    wxFrame:destroy(F),
%    ?assertEqual(?wxBLACK, Color).

ui_drawdot_test() ->
    F = ui:setup(),
    wxFrame:show(F),
    ui:drawdot(F, 0, 0, 1),
    Color = ui:getpixel(F, {0, 0}),
    wxFrame:destroy(F),
    ?assertEqual(?wxWHITE, Color).
