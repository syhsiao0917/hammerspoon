-- utils/app_registry.lua
-- Pure helpers to aggregate app-specific configs.

local M = {}

function M.remaps(apps)
    local remaps = {}

    for _, appConfig in ipairs(apps or {}) do
        if appConfig.remaps then
            for _, remap in ipairs(appConfig.remaps) do
                table.insert(remaps, remap)
            end
        end
    end

    return remaps
end

function M.sidebarMappings(apps)
    local mappings = {}
    local unsupported = {}

    for _, appConfig in ipairs(apps or {}) do
        if appConfig.sidebar then
            mappings[appConfig.name] = appConfig.sidebar
        elseif appConfig.sidebarNote then
            unsupported[appConfig.name] = appConfig.sidebarNote
        end
    end

    return mappings, unsupported
end

return M
