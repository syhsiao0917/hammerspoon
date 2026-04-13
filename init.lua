
hs.alert.show("load init.lua")

local bootstrap = require("utils.bootstrap")
local windowActions = require("utils.util_window_actions")

-- reload config
hs.hotkey.bind({"cmd","alt","ctrl"}, "0", function() hs.reload() end)

hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl", "shift"}

hs.hotkey.bind(hyper, "tab", windowActions.toggleFocusedWindowSize)

local launcherConfig = {
    {key = "3", app = "Finder"},
    {key = "s", app = "Safari"},
    {key = "t", app = "MacVim"},
    {key = "g", app = "Notes"},
    {key = "f", app = "Notion"},
    {key = "c", app = "Visual Studio Code"},
    {key = "x", app = "Codex"},


}

local snippetConfig = {
    mail = "syhsiao0917@gmail.com",
    gh = "https://github.com/syhsiao0917",
    name = "syhsiao0917",
    d = function()
        return os.date("%Y%m%d")
    end,
}

local clipboardCaptureConfig = {
    bindings = {
        {target_app = "Notes", hotkey = {mods = hyper, key = "n"}},
        {
            target_app = "Obsidian Daily Note",
            hotkey = {mods = hyper, key = "o"},
            open_url = "obsidian://daily",
            create_delay = 0.8,
            paste_delay = 0.2,
            after_paste_delay = 0.1,
            before_paste = function()
                hs.eventtap.keyStroke({"cmd"}, "down", 0)
                hs.eventtap.keyStroke({}, "return", 0)
                hs.eventtap.keyStroke({}, "return", 0)
            end,
            after_paste = function()
                hs.eventtap.keyStroke({}, "return", 0)
                hs.eventtap.keyStroke({}, "return", 0)
            end,
        },
    },
}

bootstrap.start({
    hyper = hyper,
    hyper_shift = hyper_shift,
    clipboard_capture_config = clipboardCaptureConfig,
    launcher_config = launcherConfig,
    snippet_config = snippetConfig,
})

-- hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
