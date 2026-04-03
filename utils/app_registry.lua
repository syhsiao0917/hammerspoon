-- utils/app_registry.lua
-- Pure helpers to aggregate app-specific configs.

local M = {}

function M.remaps(apps)
    local remaps = {}

    for _, appConfig in ipairs(apps or {}) do
        if appConfig.remaps then
            for _, remap in ipairs(appConfig.remaps) do
                table.insert(remaps, {
                    app = appConfig.name,
                    fromMods = remap.fromMods,
                    fromKey = remap.fromKey,
                    toMods = remap.toMods,
                    toKey = remap.toKey,
                })
            end
        end
    end

    return remaps
end

function M.sidebarMappings(apps)
    local mappings = {}
    local unsupported = {}
    local ignored = {}

    for _, appConfig in ipairs(apps or {}) do
        if appConfig.ignoreSidebarToggle then
            ignored[appConfig.name] = true
        elseif appConfig.sidebar then
            mappings[appConfig.name] = appConfig.sidebar
        elseif appConfig.sidebarNote then
            unsupported[appConfig.name] = appConfig.sidebarNote
        end
    end

    return mappings, unsupported, ignored
end

return M
