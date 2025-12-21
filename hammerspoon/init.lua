require "vimMode"
require "wifi"

hs.hotkey.bind({ "alt" }, "return", function() hs.application.open("ghostty") end)
hs.hotkey.bind({ "alt" }, "v", function() hs.application.open("vivaldi") end)
