-- notes.lua
-- Apple Notes-specific config.

local name = "Notes"
local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

-- Control + E
-- 本專案改成送出 Option + Cmd + F，也就是搜尋所有筆記
table.insert(remaps, r("ctrl", "e", {"alt", "cmd"}, "f"))

return {
    name = name,
    remaps = remaps,
}
