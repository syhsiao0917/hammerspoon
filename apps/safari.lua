-- safari.lua
-- Safari-specific config.

local name = "Safari"
local appConfig = require("utils.util_app_config")
local r = appConfig.remap
local remaps = {}

-- Control + S
-- 本專案改成送出 Cmd + [，也就是回上一頁
table.insert(remaps, r("ctrl", "s", "cmd", "["))

return {
    name = name,
    sidebar = {mods = {"ctrl", "cmd"}, key = "1"},
    remaps = remaps,
}
