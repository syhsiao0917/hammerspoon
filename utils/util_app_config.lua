-- utils/util_app_config.lua
-- Small helpers for writing app module configs more compactly.

local M = {}

local function normalizeMods(mods)
    if mods == nil or mods == "" then
        return {}
    end

    if type(mods) == "string" then
        return {mods}
    end

    return mods
end

function M.remap(fromMods, fromKey, toMods, toKey, options)
    local remap = {
        fromMods = normalizeMods(fromMods),
        fromKey = fromKey,
        toMods = normalizeMods(toMods),
        toKey = toKey,
    }

    if options then
        for key, value in pairs(options) do
            remap[key] = value
        end
    end

    return remap
end

function M.action(fromMods, fromKey, callback, options)
    local remap = {
        fromMods = normalizeMods(fromMods),
        fromKey = fromKey,
        action = callback,
    }

    if options then
        for key, value in pairs(options) do
            remap[key] = value
        end
    end

    return remap
end

return M
