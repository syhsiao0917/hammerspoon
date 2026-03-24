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
    ["Obsidian"] = "Obsidian supports sidebar commands, but its sidebar hotkeys are usually user-assigned rather than a fixed default.",
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
        hs.alert.show("No active app")
        return
    end

    local shortcut = sidebarHotkeys[appName]
    if shortcut then
        hs.eventtap.keyStroke(shortcut.mods, shortcut.key, 0)
        return
    end

    local reason = unsupportedApps[appName]
    if reason then
        hs.alert.show(appName .. ": no mapped sidebar toggle")
        print("[global_sidebar] " .. reason)
        return
    end

    hs.alert.show(appName .. ": no sidebar mapping")
end

function M.configure(sidebarMappings, unsupported)
    sidebarHotkeys = copyTable(defaultSidebarHotkeys)
    unsupportedApps = copyTable(defaultUnsupportedApps)

    for appName, shortcut in pairs(sidebarMappings or {}) do
        sidebarHotkeys[appName] = shortcut
        unsupportedApps[appName] = nil
    end

    for appName, reason in pairs(unsupported or {}) do
        if not sidebarHotkeys[appName] then
            unsupportedApps[appName] = reason
        end
    end
end

function M.setup(mods, key)
    hs.hotkey.bind(mods, key, M.toggle)
end

M.configure()

return M
