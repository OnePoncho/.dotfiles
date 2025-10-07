local VimMode = {}

local modes = {
  normal = "NORMAL",
  insert = "INSERT",
  visual = "VISUAL"
}

local currentMode = nil
local modeIndicator = nil
local prefixIndicator = nil

local commandPrefix = nil

local function sendKey(mods, key)
  hs.eventtap.keyStroke(mods, key, 50)
end

local function setCommandPrefix(key)
  commandPrefix = key
  prefixIndicator[2].text = key
  prefixIndicator:show()
end

function VimMode:init()
  modeIndicator = hs.canvas.new({ x = 600, y = 2.5, w = 100, h = 30 })
  modeIndicator:appendElements({
    type = "rectangle",
    action = "fill",
    fillColor = { red = 0, green = 0, blue = 0, alpha = 0.8 },
    roundedRectRadii = { xRadius = 5, yRadius = 5 },
  }, {
    type = "text",
    text = "",
    textColor = { red = 0, green = 1, blue = 0, alpha = 1 },
    textSize = 17,
    textAlignment = "center",
    frame = { x = 0, y = 5, w = 100, h = 20 }
  })
  prefixIndicator = hs.canvas.new({ x = 1000, y = 2.5, w = 100, h = 30 })
  prefixIndicator:appendElements({
    type = "rectangle",
    action = "fill",
    fillColor = { red = 0, green = 0, blue = 0, alpha = 0.8 },
    roundedRectRadii = { xRadius = 5, yRadius = 5 },
  }, {
    type = "text",
    text = "",
    textColor = { red = 0, green = 1, blue = 0, alpha = 1 },
    textSize = 17,
    textAlignment = "center",
    frame = { x = 0, y = 5, w = 100, h = 20 }
  })
  self.normalModal = hs.hotkey.modal.new()
  self.insertModal = hs.hotkey.modal.new()
  self.visualModal = hs.hotkey.modal.new()
end

local function showMode(mode)
  if mode then
    modeIndicator[2].text = mode
    modeIndicator:show()
    prefixIndicator:show()
  else
    modeIndicator:hide()
    prefixIndicator:hide()
  end
end

function VimMode:enterNormalMode()
  currentMode = modes.normal
  setCommandPrefix(nil)

  if self.insertModal then self.insertModal:exit() end
  if self.visualModal then self.visualModal:exit() end

  self.normalModal:enter()
  showMode(currentMode)
end

function VimMode:enterInsertMode()
  currentMode = modes.insert
  setCommandPrefix(nil)

  if self.normalModal then self.normalModal:exit() end
  if self.visualModal then self.visualModal:exit() end

  self.insertModal:enter()
  showMode(currentMode)
end

function VimMode:enterVisualMode()
  currentMode = modes.visual
  setCommandPrefix(nil)

  if self.normalModal then self.normalModal:exit() end
  if self.visualModal then self.visualModal:exit() end

  self.visualModal:enter()
  showMode(currentMode)
end

function VimMode:exitAllModes()
  currentMode = nil
  setCommandPrefix(nil)

  if self.normalModal then self.normalModal:exit() end
  showMode(nil)
end

function VimMode:setupNormalMode()
  local modal = self.normalModal

  modal:bind({}, "h", function() sendKey({}, "left") end)
  modal:bind({}, "j", function() sendKey({}, "down") end)
  modal:bind({}, "k", function() sendKey({}, "up") end)
  modal:bind({}, "l", function() sendKey({}, "right") end)

  modal:bind({}, "w", function() sendKey({ "alt" }, "right") end)
  modal:bind({}, "b", function() sendKey({ "alt" }, "left") end)

  modal:bind({}, "0", function() sendKey({ "cmd" }, "left") end)
  modal:bind({ "shift" }, "4", function() sendKey({ "cmd" }, "right") end)

  modal:bind({ "shift" }, "g", function() sendKey({ "cmd" }, "down") end)
  modal:bind({}, "p", function() sendKey({ "cmd" }, "v") end)
  modal:bind({}, "u", function() sendKey({ "cmd" }, "z") end)
  modal:bind({ "ctrl" }, "r", function() sendKey({ "cmd", "shift" }, "z") end)

  modal:bind({}, "g", function()
    if commandPrefix == "g" then
      sendKey({ "cmd" }, "up")
      setCommandPrefix(nil)
    else
      setCommandPrefix("g")
      hs.timer.doAfter(0.5, function()
        setCommandPrefix(nil)
      end)
    end
  end)

  modal:bind({}, "y", function()
    if commandPrefix == "y" then
      sendKey({ "cmd" }, "left")
      sendKey({ "cmd", "shift" }, "right")
      sendKey({ "cmd" }, "c")
      sendKey({ "cmd" }, "left")
      setCommandPrefix(nil)
    else
      setCommandPrefix("y")
      hs.timer.doAfter(0.5, function()
        setCommandPrefix(nil)
      end)
    end
  end)

  modal:bind({}, "d", function()
    if commandPrefix == "d" then
      sendKey({ "cmd" }, "left")
      sendKey({ "cmd", "shift" }, "right")
      sendKey({ "cmd" }, "c")
      sendKey({}, "delete")
      sendKey({}, "delete")
      setCommandPrefix(nil)
    else
      setCommandPrefix("d")
      hs.timer.doAfter(0.5, function()
        setCommandPrefix(nil)
      end)
    end
  end)

  modal:bind({}, "c", function()
    if commandPrefix == "c" then
      sendKey({ "cmd" }, "left")
      sendKey({ "cmd", "shift" }, "right")
      sendKey({}, "delete")
      sendKey({}, "return")
      setCommandPrefix(nil)
      self:enterInsertMode()
    else
      setCommandPrefix("c")
      hs.timer.doAfter(0.5, function()
        setCommandPrefix(nil)
      end)
    end
  end)

  modal:bind({ "ctrl" }, "d", function()
    local i = 1
    repeat
      sendKey({}, "down")
      i = i + 1
    until i == 20
  end)

  modal:bind({ "ctrl" }, "u", function()
    local i = 1
    repeat
      sendKey({}, "up")
      i = i + 1
    until i == 20
  end)


  modal:bind({}, "escape", function() setCommandPrefix(nil) end)

  modal:bind({}, 'i', function() self:enterInsertMode() end)
  modal:bind({}, 'a', function()
    sendKey({}, 'right')
    self:enterInsertMode()
  end)
  modal:bind({ 'shift' }, 'i', function()
    sendKey({ 'cmd' }, 'left')
    self:enterInsertMode()
  end)
  modal:bind({ 'shift' }, 'a', function()
    sendKey({ 'cmd' }, 'right')
    self:enterInsertMode()
  end)
  modal:bind({}, 'o', function()
    sendKey({ 'cmd' }, 'right')
    sendKey({}, 'return')
    self:enterInsertMode()
  end)
  modal:bind({ 'shift' }, 'o', function()
    sendKey({ 'cmd' }, 'left')
    sendKey({}, 'return')
    sendKey({}, 'up')
    self:enterInsertMode()
  end)

  modal:bind({}, "v", function() self:enterVisualMode() end)
end

function VimMode:setupInsertMode()
  local modal = self.insertModal

  modal:bind({}, "escape", function() self:enterNormalMode() end)
end

function VimMode:setupVisualMode()
  local modal = self.visualModal

  modal:bind({}, "h", function() sendKey({ "shift" }, "left") end)
  modal:bind({}, "j", function() sendKey({ "shift" }, "down") end)
  modal:bind({}, "k", function() sendKey({ "shift" }, "up") end)
  modal:bind({}, "l", function() sendKey({ "shift" }, "right") end)

  modal:bind({}, "w", function() sendKey({ "shift", "alt" }, "right") end)
  modal:bind({}, "b", function() sendKey({ "shift", "alt" }, "left") end)

  modal:bind({}, "0", function() sendKey({ "cmd", "shift" }, "left") end)
  modal:bind({ "shift" }, "4", function() sendKey({ "cmd", "shift" }, "right") end)

  modal:bind({}, "d", function()
    sendKey({ "cmd" }, "c")
    sendKey({}, "delete")
  end)
  modal:bind({}, "x", function() sendKey({}, "delete") end)
  modal:bind({}, "y", function()
    sendKey({ "cmd" }, "c")
    sendKey({}, "left")
    self:enterNormalMode()
  end)

  modal:bind({}, "escape", function() self:enterNormalMode() end)
end

VimMode:init()
VimMode:setupNormalMode()
VimMode:setupInsertMode()
VimMode:setupVisualMode()


-- Global hotkeys
hs.hotkey.bind({ "cmd" }, "\\", function()
  if currentMode then
    VimMode:exitAllModes()
  else
    VimMode:enterNormalMode()
  end
end)

hs.hotkey.bind({ "alt" }, "return", function() hs.application.open("ghostty") end)
hs.hotkey.bind({ "alt" }, "v", function() hs.application.open("vivaldi") end)

hs.hotkey.bind({ "ctrl" }, "h", function() sendKey({}, "left") end)
hs.hotkey.bind({ "ctrl" }, "j", function() sendKey({}, "down") end)
hs.hotkey.bind({ "ctrl" }, "k", function() sendKey({}, "up") end)
hs.hotkey.bind({ "ctrl" }, "l", function() sendKey({}, "right") end)

return VimMode
