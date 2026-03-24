-- safari.lua
-- Safari-specific config.

local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

table.insert(remaps, r("ctrl", "s", "cmd", "["))

return {
    name = "Safari",
    sidebar = {mods = {"ctrl", "cmd"}, key = "1"},
    remaps = remaps,
}
