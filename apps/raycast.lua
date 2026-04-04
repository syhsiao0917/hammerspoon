-- raycast.lua
-- Raycast-specific config.

local name = "Raycast"
local appConfig = require("utils.util_app_config")
local action = appConfig.action
local r = appConfig.remap
local remaps = {}

table.insert(remaps, action({"cmd", "alt", "ctrl"}, "v", function()
    hs.eventtap.keyStroke({"alt"}, "return", 0)
    hs.alert.show("Pasted")
end))

return {
    name = name,
    ignoreSidebarToggle = true,
    remaps = remaps,
}
