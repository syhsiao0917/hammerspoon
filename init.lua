
hs.alert.show("load init.lua")

local finder = require("finder")
local safari = require("safari")
local obsidian = require("obsidian")
local appRegistry = require("utils.app_registry")
local globalSidebar = require("utils.global_sidebar")
local hotkeyManager = require("utils.util_hotkey_manager")
local snippetEngine = require("utils.util_snippet_engine")
local windowActions = require("utils.util_window_actions")

local appModules = {
    finder,
    safari,
    obsidian,
}

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
hs.hotkey.bind( hyper_shift , "tab", windowActions.toggleFocusedWindowSize )
globalSidebar.setup(hyper, "`")
globalSidebar.setup(hyper, "1")

hotkeyManager.registerRemaps(appRegistry.remaps(appModules))
globalSidebar.configure(appRegistry.sidebarMappings(appModules))

snippetEngine.configure({
    mail = "syhsiao0917@gmail.com",
    gh = "https://github.com/syhsiao0917",
    name = "syhsiao0917",
})


hotkeyManager.start()
snippetEngine.start()

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
