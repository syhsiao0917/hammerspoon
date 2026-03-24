-- utils/bootstrap.lua
-- Assemble config, validate it, and start all runtime modules.

local M = {}

function M.start(options)
    local appModules = require("config.app_modules")
    local launcherConfig = require("config.launcher_config")
    local snippetConfig = require("config.snippet_config")
    local appRegistry = require("utils.app_registry")
    local configValidator = require("utils.config_validator")
    local globalSidebar = require("utils.global_sidebar")
    local launcher = require("utils.util_launcher")
    local hotkeyManager = require("utils.util_hotkey_manager")
    local snippetEngine = require("utils.util_snippet_engine")
    local windowActions = require("utils.util_window_actions")

    local hyper = options.hyper
    local hyperShift = options.hyper_shift

    configValidator.validateAppModules(appModules)

    launcher.register(hyper, launcherConfig)
    hs.hotkey.bind(hyperShift, "tab", windowActions.toggleFocusedWindowSize)
    globalSidebar.setup(hyper, "`")
    globalSidebar.setup(hyper, "1")

    hotkeyManager.registerRemaps(appRegistry.remaps(appModules))
    globalSidebar.configure(appRegistry.sidebarMappings(appModules))
    snippetEngine.configure(snippetConfig)

    hotkeyManager.start()
    snippetEngine.start()
end

return M
