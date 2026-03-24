-- utils/util_app_loader.lua
-- Load app modules automatically from the apps folder.

local M = {}

function M.load()
    local modules = {}
    local moduleNames = {}
    local appsDir = hs.configdir .. "/apps"

    for entry in hs.fs.dir(appsDir) do
        if entry:match("%.lua$") then
            table.insert(moduleNames, "apps." .. entry:gsub("%.lua$", ""))
        end
    end

    table.sort(moduleNames)

    for _, moduleName in ipairs(moduleNames) do
        table.insert(modules, require(moduleName))
    end

    return modules
end

return M
