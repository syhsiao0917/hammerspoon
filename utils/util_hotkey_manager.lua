-- util_hotkey_manager.lua
-- Centralized app-specific hotkey registration and activation.

local M = {}

local press = hs.eventtap.keyStroke
local remapTable = {}
local activeAppName = nil
local watcher = nil

function M.map(app, mod, key, outMod, outKey)
    local apps = type(app) == "table" and app or {app}

    for _, appName in ipairs(apps) do
        if not remapTable[appName] then
            remapTable[appName] = {}
        end

        table.insert(remapTable[appName], hs.hotkey.new(mod, key, function()
            press(outMod or {}, outKey or key)
        end))
    end
end

function M.registerRemaps(definitions)
    for _, remap in ipairs(definitions or {}) do
        M.map(remap.app, remap.fromMods, remap.fromKey, remap.toMods, remap.toKey)
    end
end

function M.update(appName)
    if appName == activeAppName then
        return
    end

    if activeAppName and remapTable[activeAppName] then
        for _, hotkey in ipairs(remapTable[activeAppName]) do
            hotkey:disable()
        end
    end

    if remapTable[appName] then
        for _, hotkey in ipairs(remapTable[appName]) do
            hotkey:enable()
        end
    end

    activeAppName = appName
end

function M.start()
    if watcher then
        watcher:stop()
    end

    watcher = hs.application.watcher.new(function(name, event)
        if event == hs.application.watcher.activated then
            M.update(name)
        end
    end)

    watcher:start()

    local current = hs.window.focusedWindow()
    if current then
        M.update(current:application():name())
    end
end

return M
