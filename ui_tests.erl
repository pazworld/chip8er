-module(ui_tests).
-include_lib("eunit/include/eunit.hrl").
-include_lib("wx/include/wx.hrl").

ui_setup_return_wxFrame_test() ->
    F = ui:setup(),
    ?assertEqual(wx_ref, element(1, F)).
