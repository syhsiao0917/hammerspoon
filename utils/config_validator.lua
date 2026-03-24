-- utils/config_validator.lua
-- Validate app-module config shape early during bootstrap.

local M = {}

local function expectTable(value, name)
    if type(value) ~= "table" then
        error(name .. " must be a table")
    end
end

local function expectString(value, name)
    if type(value) ~= "string" or value == "" then
        error(name .. " must be a non-empty string")
    end
end

local function expectMods(value, name)
    expectTable(value, name)
end

local function validateRemap(remap, appName, index)
    expectTable(remap, string.format("%s.remaps[%d]", appName, index))
    expectMods(remap.fromMods, string.format("%s.remaps[%d].fromMods", appName, index))
    expectString(remap.fromKey, string.format("%s.remaps[%d].fromKey", appName, index))
    expectMods(remap.toMods, string.format("%s.remaps[%d].toMods", appName, index))
    expectString(remap.toKey, string.format("%s.remaps[%d].toKey", appName, index))
end

local function validateSidebar(sidebar, appName)
    expectTable(sidebar, appName .. ".sidebar")
    expectMods(sidebar.mods, appName .. ".sidebar.mods")
    expectString(sidebar.key, appName .. ".sidebar.key")
end

function M.validateAppModules(appModules)
    expectTable(appModules, "appModules")

    local seenNames = {}

    for index, appConfig in ipairs(appModules) do
        expectTable(appConfig, string.format("appModules[%d]", index))
        expectString(appConfig.name, string.format("appModules[%d].name", index))

        if seenNames[appConfig.name] then
            error("Duplicate app module name: " .. appConfig.name)
        end
        seenNames[appConfig.name] = true

        if appConfig.remaps then
            expectTable(appConfig.remaps, appConfig.name .. ".remaps")
            for remapIndex, remap in ipairs(appConfig.remaps) do
                validateRemap(remap, appConfig.name, remapIndex)
            end
        end

        if appConfig.sidebar then
            validateSidebar(appConfig.sidebar, appConfig.name)
        end

        if appConfig.sidebarNote then
            expectString(appConfig.sidebarNote, appConfig.name .. ".sidebarNote")
        end
    end
end

return M
