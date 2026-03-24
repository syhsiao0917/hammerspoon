-- app_registry.lua
-- Central place to collect app-specific configs.

local M = {}

local apps = {
    require("finder"),
}

function M.apps()
    return apps
end

function M.remaps()
    local remaps = {}

    for _, appConfig in ipairs(apps) do
        if appConfig.remaps then
            for _, remap in ipairs(appConfig.remaps) do
                table.insert(remaps, remap)
            end
        end
    end

    return remaps
end

function M.sidebarMappings()
    local mappings = {}
    local unsupported = {}

    for _, appConfig in ipairs(apps) do
        if appConfig.sidebar then
            mappings[appConfig.name] = appConfig.sidebar
        elseif appConfig.sidebarNote then
            unsupported[appConfig.name] = appConfig.sidebarNote
        end
    end

    return mappings, unsupported
end

return M
