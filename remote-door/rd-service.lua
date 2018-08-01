local colors = require("colors")
local component = require("component")
local shell = require("shell")
local sides = require("sides")
local event = require("event")

-- Configuration
local port = 43254
local side = sides.right
local kill_cmd = "kserver"

if not component.isAvailable("redstone") then
  io.stderr:write("This program requires a redstone card or redstone I/O block.\n")
  return 1
end
local rs = component.redstone

if not component.isAvailable("modem") then
  io.stderr:write("This program requires a network or wireless card.")
  return 1
end
local m = component.modem

-- Intro

print("****************************")
print("* Remote Iron Door Service *")
print("****************************")

print("Starting service...")

-- Start service

m.open(port)

if m.isOpen(port) then print("Door service is listening on port => " .. port) end

local running = nil

while running ~= kill_cmd do
  local _, _, from, port, _, message = event.pull("modem_message")

  message = tostring(message)
  running = message

  if message == "open" then
    rs.setOutput(side, 15)
  end

  if message == "close" then
    rs.setOutput(side, 0)
  end
end