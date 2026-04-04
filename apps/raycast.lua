-- raycast.lua
-- Raycast-specific config.

local name = "Raycast"
local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

table.insert(remaps, r({"cmd", "alt", "ctrl"}, "v", {"alt"}, "return"))

return {
    name = name,
    ignoreSidebarToggle = true,
    remaps = remaps,
}
