
hs.alert.show("load init.lua")

local finder = require("apps.finder")
local safari = require("apps.safari")
local obsidian = require("apps.obsidian")
local bootstrap = require("utils.bootstrap")

-- reload config
hs.hotkey.bind({"cmd","alt","ctrl"}, "0", function() hs.reload() end)

hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl", "shift"}

local appModules = {
    finder,
    safari,
    obsidian,
}

local launcherConfig = {
    {key = "3", app = "Finder"},
    {key = "s", app = "Safari"},
    {key = "t", app = "MacVim"},
    {key = "g", app = "Notes"},
    {key = "f", app = "Notion"},
}

local snippetConfig = {
    mail = "syhsiao0917@gmail.com",
    gh = "https://github.com/syhsiao0917",
    name = "syhsiao0917",
}

bootstrap.start({
    hyper = hyper,
    hyper_shift = hyper_shift,
    app_modules = appModules,
    launcher_config = launcherConfig,
    snippet_config = snippetConfig,
})

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
