-- notion.lua
-- Notion-specific config.

local name = "Notion"
local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

-- Control + G
-- 本專案改成送出 Cmd + Shift + H，也就是 highlight
table.insert(remaps, r("ctrl", "g", {"cmd", "shift"}, "h"))

-- Control + E
-- 本專案改成送出 Cmd + P，也就是搜尋
table.insert(remaps, r("ctrl", "e", "cmd", "p"))

return {
    name = name,
    sidebar = {mods = {"cmd"}, key = "\\"},
    remaps = remaps,
}
