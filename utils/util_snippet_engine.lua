-- util_snippet_engine.lua
-- Text expansion engine for ;;-prefixed snippets.

local M = {}

local press = hs.eventtap.keyStroke
local typeText = hs.eventtap.keyStrokes
local snippetPrefix = ";;"
local snippets = {}
local snippetPrefixes = {}
local snippetTap = nil
local snippetBuffer = nil
local snippetMatch = nil
local pendingSemicolon = false
local isExpandingSnippet = false

local function resetBuffer()
    snippetBuffer = nil
    snippetMatch = nil
    pendingSemicolon = false
end

local function deleteTypedTrigger(trigger)
    for _ = 1, #trigger do
        press({}, "delete", 0)
    end
end

local function shouldIgnoreEvent(flags)
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

local function startBuffer()
    snippetBuffer = snippetPrefix
    snippetMatch = nil
    pendingSemicolon = false
end

local function expandSnippet(trigger, expansion)
    local resolvedExpansion = expansion
    if type(expansion) == "function" then
        resolvedExpansion = expansion()
    end

    if type(resolvedExpansion) ~= "string" then
        resolvedExpansion = tostring(resolvedExpansion or "")
    end

    isExpandingSnippet = true
    resetBuffer()

    hs.timer.doAfter(0, function()
        deleteTypedTrigger(trigger)
        typeText(resolvedExpansion)
        isExpandingSnippet = false
    end)
end

local function appendCharacter(chars)
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

    resetBuffer()

    if chars == ";" then
        pendingSemicolon = true
    end
end

function M.configure(definitions)
    prepareSnippets(definitions)
    resetBuffer()
end

function M.start()
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
        if shouldIgnoreEvent(flags) then
            return false
        end

        local keyCode = event:getKeyCode()
        if keyCode == hs.keycodes.map.delete then
            if snippetBuffer then
                if #snippetBuffer <= #snippetPrefix then
                    resetBuffer()
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

            resetBuffer()
            return false
        end

        if snippetBuffer then
            appendCharacter(chars)
            return false
        end

        if chars == ";" then
            if pendingSemicolon then
                startBuffer()
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

return M
