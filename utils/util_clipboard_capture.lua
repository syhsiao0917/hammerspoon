-- util_clipboard_capture.lua
-- Global hotkeys to create a new note from the current clipboard.

local M = {}

local bindings = {}
local hotkeys = {}

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

local function triggerCapture(binding)
    if not hasClipboardPayload() then
        show("Clipboard is empty")
        return
    end

    if binding.open_url then
        hs.urlevent.openURL(binding.open_url)

        hs.timer.doAfter(binding.create_delay, function()
            if binding.before_paste then
                binding.before_paste()
            end

            hs.timer.doAfter(binding.paste_delay, function()
                hs.eventtap.keyStroke({"cmd"}, "v", 0)

                if binding.after_paste then
                    hs.timer.doAfter(binding.after_paste_delay, function()
                        binding.after_paste()
                    end)
                end

                show("Clipboard captured to " .. binding.target_app)
            end)
        end)
        return
    end

    hs.application.launchOrFocus(binding.target_app)

    hs.timer.doAfter(binding.create_delay, function()
        hs.eventtap.keyStroke({"cmd"}, "n", 0)

        hs.timer.doAfter(binding.paste_delay, function()
            hs.eventtap.keyStroke({"cmd"}, "v", 0)

            if binding.after_paste then
                hs.timer.doAfter(binding.after_paste_delay, function()
                    binding.after_paste()
                end)
            end

            show("Clipboard captured to " .. binding.target_app)
        end)
    end)
end

local function normalizeBinding(options)
    return {
        target_app = options.target_app,
        hotkey = options.hotkey,
        create_delay = options.create_delay or 0.4,
        paste_delay = options.paste_delay or 0.2,
        after_paste_delay = options.after_paste_delay or 0.1,
        open_url = options.open_url,
        before_paste = options.before_paste,
        after_paste = options.after_paste,
    }
end

function M.configure(options)
    local configuredBindings = options.bindings

    if configuredBindings and #configuredBindings > 0 then
        bindings = {}
        for _, binding in ipairs(configuredBindings) do
            table.insert(bindings, normalizeBinding(binding))
        end
        return
    end

    bindings = {
        normalizeBinding({
            target_app = options.target_app or "Notes",
            hotkey = options.hotkey or {mods = {"cmd", "alt", "ctrl"}, key = "n"},
            create_delay = options.create_delay,
            paste_delay = options.paste_delay,
        }),
    }
end

function M.start()
    if #bindings == 0 then
        return
    end

    for _, hotkey in ipairs(hotkeys) do
        hotkey:delete()
    end

    hotkeys = {}

    for _, binding in ipairs(bindings) do
        table.insert(hotkeys, hs.hotkey.bind(binding.hotkey.mods, binding.hotkey.key, function()
            triggerCapture(binding)
        end))
    end
end

return M
