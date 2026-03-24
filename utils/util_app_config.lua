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

function M.remap(fromMods, fromKey, toMods, toKey)
    return {
        fromMods = normalizeMods(fromMods),
        fromKey = fromKey,
        toMods = normalizeMods(toMods),
        toKey = toKey,
    }
end

return M
