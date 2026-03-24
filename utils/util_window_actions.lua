-- util_window_actions.lua
-- Window-related actions and helpers.

local M = {}

hs.window.animationDuration = 0.1

function M.toggleFocusedWindowSize()
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

return M
