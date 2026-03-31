-- utils/bootstrap.lua
-- Assemble config, validate it, and start all runtime modules.

local M = {}

function M.start(options)
    local clipboardCapture = require("utils.util_clipboard_capture")
    local appRegistry = require("utils.app_registry")
    local appLoader = require("utils.util_app_loader")
    local configValidator = require("utils.config_validator")
    local globalSidebar = require("utils.global_sidebar")
    local launcher = require("utils.util_launcher")
    local modifierIndicator = require("utils.util_modifier_indicator")
    local hotkeyManager = require("utils.util_hotkey_manager")
    local snippetEngine = require("utils.util_snippet_engine")
    local windowActions = require("utils.util_window_actions")

    local hyper = options.hyper
    local hyperShift = options.hyper_shift
    local appModules = appLoader.load()
    local clipboardCaptureConfig = options.clipboard_capture_config
    local launcherConfig = options.launcher_config or {}
    local snippetConfig = options.snippet_config or {}

    configValidator.validateAppModules(appModules)

    launcher.register(hyper, launcherConfig)
    hs.hotkey.bind(hyperShift, "tab", windowActions.toggleFocusedWindowSize)
    modifierIndicator.start(hyperShift)
    globalSidebar.setup(hyper, "`")
    globalSidebar.setup(hyper, "1")
    clipboardCapture.configure(clipboardCaptureConfig or {})

    hotkeyManager.registerRemaps(appRegistry.remaps(appModules))
    globalSidebar.configure(appRegistry.sidebarMappings(appModules))
    snippetEngine.configure(snippetConfig)

    clipboardCapture.start()
    hotkeyManager.start()
    snippetEngine.start()
end

return M
