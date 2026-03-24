-- obsidian.lua
-- Obsidian-specific config.

local name = "Obsidian"
local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

-- Control + S
-- 本專案改成送出 Escape，方便快速離開編輯焦點
table.insert(remaps, r("ctrl", "s", "", "escape"))

return {
    name = name,
    sidebarNote = "Obsidian supports sidebar commands, but its sidebar hotkeys are usually user-assigned rather than a fixed default.",
    remaps = remaps,
}
