-- util.lua
hs.alert.show("load util.lua")
local M = {}

local press = hs.eventtap.keyStroke
local typeText = hs.eventtap.keyStrokes
local remapTable = {}
local snippetPrefix = ";;"
local snippets = {}
local snippetPrefixes = {}
local snippetTap = nil
local snippetBuffer = nil
local snippetMatch = nil
local activeHotkeyApp = nil
local pendingSemicolon = false
local isExpandingSnippet = false

local function resetSnippetBuffer()
    snippetBuffer = nil
    snippetMatch = nil
    pendingSemicolon = false
end

local function deleteTypedTrigger(trigger)
    for _ = 1, #trigger do
        press({}, "delete", 0)
    end
end

local function shouldIgnoreSnippetEvent(flags)
    return flags.cmd or flags.ctrl or flags.alt or flags.fn
end

local function prepareSnippets(definitions)
    snippets = {}
    snippetPrefixes = {}

    for trigger, expansion in pairs(definitions or {}) do
        local normalized = trigger
        if normalized:sub(1, #snippetPrefix) ~= snippetPrefix then
            normalized = snippetPrefix .. normalized
        end

        snippets[normalized] = expansion

        for i = #snippetPrefix, #normalized do
            snippetPrefixes[normalized:sub(1, i)] = true
        end
    end
end

local function startSnippetBuffer()
    snippetBuffer = snippetPrefix
    snippetMatch = nil
    pendingSemicolon = false
end

local function expandSnippet(trigger, expansion)
    isExpandingSnippet = true
    resetSnippetBuffer()

    hs.timer.doAfter(0, function()
        deleteTypedTrigger(trigger)
        typeText(expansion)
        isExpandingSnippet = false
    end)
end

local function appendSnippetCharacter(chars)
    local candidate = snippetBuffer .. chars

    if snippets[candidate] then
        snippetBuffer = candidate
        snippetMatch = candidate
        return
    end

    if snippetPrefixes[candidate] then
        snippetBuffer = candidate
        snippetMatch = nil
        return
    end

    resetSnippetBuffer()

    if chars == ";" then
        pendingSemicolon = true
    end
end

-- 設定視窗動畫時間
hs.window.animationDuration = 0.1

-- 原有的 map 函式
function M.map(app, mod, key, outMod, outKey)
    local apps = type(app) == "table" and app or {app}
    for _, a in ipairs(apps) do
        if not remapTable[a] then remapTable[a] = {} end
        table.insert(remapTable[a], hs.hotkey.new(mod, key, function()
            press(outMod or {}, outKey or key)
        end))
    end
end

function M.WindowTogglier()

        local win = hs.window.focusedWindow()
        if not win then return end

        local screen = win:screen()
        local frame = screen:frame()
        local f = win:frame()

        local margin = 40
        local pseudoW, pseudoH = frame.w - margin * 2, frame.h - margin * 2
        local pseudoX, pseudoY = frame.x + margin, frame.y + margin

        local centerW, centerH = frame.w * 0.6, frame.h * 0.7
        local centerX, centerY = frame.x + (frame.w - centerW) / 2, frame.y + (frame.h - centerH) / 2

        local threshold = (pseudoW + centerW) / 2

        if f.w < threshold then
            win:setFrame({x = pseudoX, y = pseudoY, w = pseudoW, h = pseudoH})
        else
            win:setFrame({x = centerX, y = centerY, w = centerW, h = centerH})
        end
end

function M.setupSnippets(definitions)
    prepareSnippets(definitions)
    resetSnippetBuffer()
end

function M.startSnippets()
    if snippetTap then
        snippetTap:stop()
        snippetTap = nil
    end

    if next(snippets) == nil then
        return
    end

    snippetTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, function(event)
        if isExpandingSnippet then
            return false
        end

        local flags = event:getFlags()
        if shouldIgnoreSnippetEvent(flags) then
            return false
        end

        local keyCode = event:getKeyCode()
        if keyCode == hs.keycodes.map.delete then
            if snippetBuffer then
                if #snippetBuffer <= #snippetPrefix then
                    resetSnippetBuffer()
                else
                    snippetBuffer = snippetBuffer:sub(1, -2)
                end
            else
                pendingSemicolon = false
            end
            return false
        end

        local chars = event:getCharacters()
        if not chars or chars == "" then
            return false
        end

        if chars:match("%s") then
            if chars == " " and snippetMatch then
                local trigger = snippetMatch
                local expansion = snippets[trigger]
                expandSnippet(trigger, expansion)
                return true
            end

            resetSnippetBuffer()
            return false
        end

        if snippetBuffer then
            appendSnippetCharacter(chars)
            return false
        end

        if chars == ";" then
            if pendingSemicolon then
                startSnippetBuffer()
            else
                pendingSemicolon = true
            end
            return false
        end

        pendingSemicolon = false
        return false
    end)

    snippetTap:start()
end

-- App 切換邏輯與啟動
function M.updateHotkeys(appName)
    if appName == activeHotkeyApp then
        return
    end

    if activeHotkeyApp and remapTable[activeHotkeyApp] then
        for _, hk in ipairs(remapTable[activeHotkeyApp]) do hk:disable() end
    end

    if remapTable[appName] then
        for _, hk in ipairs(remapTable[appName]) do hk:enable() end
    end

    activeHotkeyApp = appName
end

function M.start()
    hs.application.watcher.new(function(name, event)
        if event == hs.application.watcher.activated then M.updateHotkeys(name) end
    end):start()

    local current = hs.window.focusedWindow()
    if current then M.updateHotkeys(current:application():name()) end

    M.startSnippets()
end

return M
