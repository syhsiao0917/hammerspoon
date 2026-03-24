-- obsidian.lua
-- Obsidian-specific config.

local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

table.insert(remaps, r("ctrl", "s", "", "escape"))

return {
    name = "Obsidian",
    sidebarNote = "Obsidian supports sidebar commands, but its sidebar hotkeys are usually user-assigned rather than a fixed default.",
    remaps = remaps,
}
