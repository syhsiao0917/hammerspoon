
hs.alert.show("load init.lua")

local util = require("util") -- util.lua
local finder = require("finder")
local globalSidebar = require("global_sidebar")

-- reload config
hs.hotkey.bind({"cmd","alt","ctrl"}, "0", function() hs.reload() end)


-- -- setup app launcher
-- 查看當前的app 名字: 注意，app 大小寫 要一樣
-- print(hs.application.frontmostApplication():name())
--
hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl", "shift"}

local app = hs.application.launchOrFocus

hs.hotkey.bind( hyper , "3", function() app("Finder") end)
hs.hotkey.bind( hyper , "s", function() app("Safari") end)
hs.hotkey.bind( hyper , "t", function() app("MacVim") end)
hs.hotkey.bind( hyper , "g", function() app("Notes") end)
hs.hotkey.bind( hyper , "f", function() app("Notion") end)

----
hs.hotkey.bind( hyper_shift , "tab", util.WindowTogglier )
globalSidebar.setup(hyper, "`")
globalSidebar.setup(hyper, "1")




util.map("Obsidian", {"ctrl"}, "s", {}, "escape")
util.map("Safari",   {"ctrl"}, "s", {"cmd"}, "[")
finder.setup(util)

util.setupSnippets({
    mail = "syhsiao0917@gmail.com",
    gh = "https://github.com/syhsiao0917",
    name = "syhsiao0917",
})


util.start()

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
