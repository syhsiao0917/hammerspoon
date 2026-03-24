
hs.alert.show("load init.lua")

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

-- reload config
hs.hotkey.bind({"cmd","alt","ctrl"}, "0", function() hs.reload() end)


-- -- setup app launcher
-- 查看當前的app 名字: 注意，app 大小寫 要一樣
-- print(hs.application.frontmostApplication():name())
--
hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl", "shift"}

configValidator.validateAppModules(appModules)
launcher.register(hyper, launcherConfig)

----
hs.hotkey.bind( hyper_shift , "tab", windowActions.toggleFocusedWindowSize )
globalSidebar.setup(hyper, "`")
globalSidebar.setup(hyper, "1")

hotkeyManager.registerRemaps(appRegistry.remaps(appModules))
globalSidebar.configure(appRegistry.sidebarMappings(appModules))
snippetEngine.configure(snippetConfig)


hotkeyManager.start()
snippetEngine.start()

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
