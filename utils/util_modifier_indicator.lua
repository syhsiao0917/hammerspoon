-- util_modifier_indicator.lua
-- Show a small on-screen badge while a modifier chord is held.

local M = {}

local badgeRect = nil
local badgeText = nil
local badgeTimer = nil
local flagsWatcher = nil
local active = false
local requiredFlags = {}

local function flagsArrayToSet(flags)
    local set = {}

    for _, flag in ipairs(flags or {}) do
        set[flag] = true
    end

    return set
end

local function hasRequiredFlags(flags)
    for flag in pairs(requiredFlags) do
        if not flags[flag] then
            return false
        end
    end

    return true
end

local function ensureBadge()
    if badgeRect and badgeText then
        return
    end

    badgeRect = hs.drawing.rectangle(hs.geometry.rect(0, 0, 64, 28))
    badgeRect:setFill(true)
    badgeRect:setFillColor({red = 0.12, green = 0.12, blue = 0.14, alpha = 0.88})
    badgeRect:setStroke(false)
    badgeRect:setRoundedRectRadii(8, 8)
    badgeRect:setLevel(hs.drawing.windowLevels.overlay)
    badgeRect:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)

    badgeText = hs.drawing.text(hs.geometry.rect(0, 0, 64, 28), "WIN")
    badgeText:setTextColor({white = 1.0, alpha = 0.95})
    badgeText:setTextSize(13)
    badgeText:setLevel(hs.drawing.windowLevels.overlay)
    badgeText:setBehavior(hs.drawing.windowBehaviors.canJoinAllSpaces)
end

local function updateBadgePosition()
    if not active then
        return
    end

    local pos = hs.mouse.absolutePosition()
    local x = pos.x + 14
    local y = pos.y + 18

    badgeRect:setTopLeft({x = x, y = y})
    badgeText:setTopLeft({x = x + 11, y = y + 5})
end

local function showBadge()
    ensureBadge()
    active = true
    updateBadgePosition()
    badgeRect:show()
    badgeText:show()

    if badgeTimer then
        badgeTimer:stop()
    end

    badgeTimer = hs.timer.doEvery(0.05, updateBadgePosition)
end

local function hideBadge()
    active = false

    if badgeTimer then
        badgeTimer:stop()
        badgeTimer = nil
    end

    if badgeRect then
        badgeRect:hide()
    end

    if badgeText then
        badgeText:hide()
    end
end

function M.start(flags)
    requiredFlags = flagsArrayToSet(flags)

    if flagsWatcher then
        flagsWatcher:stop()
    end

    hideBadge()

    flagsWatcher = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, function(event)
        local currentFlags = event:getFlags()

        if hasRequiredFlags(currentFlags) then
            if not active then
                showBadge()
            end
        elseif active then
            hideBadge()
        end

        return false
    end)

    flagsWatcher:start()
end

return M
