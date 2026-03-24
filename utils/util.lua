-- util.lua
-- Thin compatibility layer over specialized core modules.

hs.alert.show("load util.lua")

local hotkeyManager = require("utils.util_hotkey_manager")
local snippetEngine = require("utils.util_snippet_engine")
local windowActions = require("utils.util_window_actions")

local M = {}

M.map = hotkeyManager.map
M.registerRemaps = hotkeyManager.registerRemaps
M.updateHotkeys = hotkeyManager.update

function M.WindowTogglier()
    windowActions.toggleFocusedWindowSize()
end

function M.setupSnippets(definitions)
    snippetEngine.configure(definitions)
end

function M.startSnippets()
    snippetEngine.start()
end

function M.start()
    hotkeyManager.start()
    snippetEngine.start()
end

return M
