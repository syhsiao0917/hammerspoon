-- global_sidebar.lua
-- Use one global hotkey to toggle the sidebar for the current app.

local M = {}

local defaultSidebarHotkeys = {
    ["Finder"] = {mods = {"alt", "cmd"}, key = "s"},
    ["Mail"] = {mods = {"ctrl", "cmd"}, key = "s"},
    ["Reminders"] = {mods = {"alt", "cmd"}, key = "s"},
    ["Keychain Access"] = {mods = {"ctrl", "cmd"}, key = "s"},
    ["Safari"] = {mods = {"ctrl", "cmd"}, key = "1"},
    ["Notion"] = {mods = {"cmd"}, key = "\\"},
    ["Visual Studio Code"] = {mods = {"cmd"}, key = "b"},
    ["Code"] = {mods = {"cmd"}, key = "b"},
    ["Slack"] = {mods = {"cmd"}, key = "."},
    ["Arc"] = {mods = {"cmd"}, key = "s"},
}

local defaultUnsupportedApps = {
    ["Notes"] = "Apple Notes has folders/sidebar UI, but I have not recorded a reliable default toggle shortcut yet.",
    ["Preview"] = "Preview has a PDF sidebar, but I have not recorded a reliable default toggle shortcut yet.",
    ["Microsoft Edge"] = "Edge has sidebar-related shortcuts, but not a confirmed generic sidebar toggle shortcut in this config.",
    ["Music"] = "Music has a sidebar, but I have not recorded a reliable default toggle shortcut yet.",
    ["Podcasts"] = "Podcasts has a sidebar, but I have not recorded a reliable default toggle shortcut yet.",
    ["Calendar"] = "Calendar has a calendar list, but I have not recorded a reliable default toggle shortcut yet.",
    ["Photos"] = "Photos has a sidebar, but I have not recorded a reliable default toggle shortcut yet.",
    ["Books"] = "Books has a sidebar, but I have not recorded a reliable default toggle shortcut yet.",
}

local sidebarHotkeys = {}
local unsupportedApps = {}
local ignoredApps = {}
local triggerBindings = {}
local keyListener = nil

local function copyTable(source)
    local result = {}
    for key, value in pairs(source) do
        result[key] = value
    end
    return result
end

local function currentAppName()
    local app = hs.application.frontmostApplication()
    if not app then return nil end
    return app:name()
end

function M.toggle()
    local appName = currentAppName()
    if not appName then
        return false
    end

    local shortcut = sidebarHotkeys[appName]
    if shortcut then
        hs.eventtap.keyStroke(shortcut.mods, shortcut.key, 0)
        return true
    end

    if ignoredApps[appName] then
        return false
    end

    local reason = unsupportedApps[appName]
    if reason then
        print("[global_sidebar] " .. reason)
        return false
    end

    return false
end

function M.configure(sidebarMappings, unsupported, ignored)
    sidebarHotkeys = copyTable(defaultSidebarHotkeys)
    unsupportedApps = copyTable(defaultUnsupportedApps)
    ignoredApps = copyTable(ignored or {})

    for appName, shortcut in pairs(sidebarMappings or {}) do
        sidebarHotkeys[appName] = shortcut
        unsupportedApps[appName] = nil
        ignoredApps[appName] = nil
    end

    for appName, reason in pairs(unsupported or {}) do
        if not sidebarHotkeys[appName] then
            unsupportedApps[appName] = reason
        end
    end
end

local function normalizeMods(mods)
    local normalized = {}
    for _, mod in ipairs(mods or {}) do
        normalized[mod] = true
    end
    return normalized
end

local function modsMatch(eventFlags, bindingMods)
    local expected = normalizeMods(bindingMods)
    local relevantFlags = {
        cmd = not not eventFlags.cmd,
        alt = not not eventFlags.alt,
        ctrl = not not eventFlags.ctrl,
        shift = not not eventFlags.shift,
        fn = not not eventFlags.fn,
    }

    for modName, isPressed in pairs(relevantFlags) do
        if isPressed ~= not not expected[modName] then
            return false
        end
    end

    return true
end

local function ensureListener()
    if keyListener then
        keyListener:stop()
    end

    keyListener = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
        local keyName = hs.keycodes.map[event:getKeyCode()]
        local flags = event:getFlags()

        for _, binding in ipairs(triggerBindings) do
            if binding.key == keyName and modsMatch(flags, binding.mods) then
                return M.toggle()
            end
        end

        return false
    end)

    keyListener:start()
end

function M.setup(mods, key)
    table.insert(triggerBindings, {mods = mods, key = key})
    ensureListener()
end

M.configure()

return M
