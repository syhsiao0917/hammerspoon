
hs.alert.show("load init.lua")

local bootstrap = require("utils.bootstrap")

-- reload config
hs.hotkey.bind({"cmd","alt","ctrl"}, "0", function() hs.reload() end)

hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl", "shift"}

local launcherConfig = {
    {key = "3", app = "Finder"},
    {key = "s", app = "Safari"},
    {key = "t", app = "MacVim"},
    {key = "g", app = "Notes"},
    {key = "f", app = "Notion"},
    {key = "c", app = "Visual Studio Code"},
    {key = "v", app = "Codex"},


}

local snippetConfig = {
    mail = "syhsiao0917@gmail.com",
    gh = "https://github.com/syhsiao0917",
    name = "syhsiao0917",
}

local clipboardCaptureConfig = {
    target_app = "Notes",
    hotkey = {mods = hyper, key = "n"},
}

bootstrap.start({
    hyper = hyper,
    hyper_shift = hyper_shift,
    clipboard_capture_config = clipboardCaptureConfig,
    launcher_config = launcherConfig,
    snippet_config = snippetConfig,
})

-- hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
