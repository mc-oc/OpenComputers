local colors = require("colors")
local component = require("component")
local shell = require("shell")

-- Remote requirements
local event = require("event")

local port = 43254
local strength = 32

if not component.modem then
  io.stderr:write("This program requires a modem.\n")
  return 1
end
local m = component.modem

local args, options = shell.parse(...)

m.setStrength(strength)
m.broadcast(port, args[1])