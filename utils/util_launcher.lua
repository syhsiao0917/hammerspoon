-- utils/util_launcher.lua
-- Register app launcher hotkeys from config.

local M = {}

function M.register(mods, launcherConfig)
    local app = hs.application.launchOrFocus

    for _, launcher in ipairs(launcherConfig or {}) do
        hs.hotkey.bind(mods, launcher.key, function()
            app(launcher.app)
        end)
    end
end

return M
