function setWifi()
  local interface = hs.wifi.interfaces()[1]
  local interfacePowerState = hs.wifi.interfaceDetails()["power"]

  if interfacePowerState == true then
    hs.wifi.setPower(false, interface)
  elseif interfacePowerState == false then
    hs.wifi.setPower(true, interface)
  end
end

hs.hotkey.bind({ "alt" }, "w", function() setWifi() end)
