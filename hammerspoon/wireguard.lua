function toggle()
  excode, output, descriptor = hs.osascript.applescript(
    string.format(
      [[
ignoring application responses
	tell application "System Events" to click menu bar item 1 of menu bar 2 of application process "WireGuard"
	--click menu item "QNAS" of menu 1 of menu bar 2 of application process "WireGuard"
end ignoring

delay 0.01
do shell script "killall 'System Events'"
delay 0.01

tell application "System Events"
	launch
	click menu item "QNAS" of menu 1 of menu bar 2 of application process "WireGuard"
end tell
]]
    )
  )
end

hs.hotkey.bind({ "alt" }, "q", function() toggle() end)
