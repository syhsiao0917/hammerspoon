-- util_clipboard_capture.lua
-- Global hotkey to create a new Apple Notes note from the current clipboard.

local M = {}

local config = nil
local hotkey = nil

local function show(message)
    hs.alert.show(message)
end

local function hasClipboardPayload()
    local text = hs.pasteboard.getContents()
    if type(text) == "string" and text:match("%S") ~= nil then
        return true
    end

    if hs.pasteboard.readImage() ~= nil then
        return true
    end

    local contentTypes = hs.pasteboard.contentTypes() or {}
    return #contentTypes > 0
end

local function triggerNotesCapture()
    if not hasClipboardPayload() then
        show("Clipboard is empty")
        return
    end

    hs.application.launchOrFocus(config.target_app)

    hs.timer.doAfter(config.create_delay, function()
        hs.eventtap.keyStroke({"cmd"}, "n", 0)

        hs.timer.doAfter(config.paste_delay, function()
            hs.eventtap.keyStroke({"cmd"}, "v", 0)
            show("Clipboard captured to Notes")
        end)
    end)
end

function M.configure(options)
    config = {
        target_app = options.target_app or "Notes",
        hotkey = options.hotkey or {mods = {"cmd", "alt", "ctrl"}, key = "n"},
        create_delay = options.create_delay or 0.4,
        paste_delay = options.paste_delay or 0.2,
    }
end

function M.start()
    if not config then
        return
    end

    if hotkey then
        hotkey:delete()
        hotkey = nil
    end

    hotkey = hs.hotkey.bind(config.hotkey.mods, config.hotkey.key, triggerNotesCapture)
end

return M
