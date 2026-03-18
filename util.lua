-- util.lua
hs.alert.show("load util.lua")
local M = {}

local press = hs.eventtap.keyStroke
local remapTable = {}

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


-- App 切換邏輯與啟動
function M.updateHotkeys(appName)
    for _, appRules in pairs(remapTable) do
        for _, hk in ipairs(appRules) do hk:disable() end
    end
    if remapTable[appName] then
        for _, hk in ipairs(remapTable[appName]) do hk:enable() end
    end
end

function M.start()
    hs.application.watcher.new(function(name, event)
        if event == hs.application.watcher.activated then M.updateHotkeys(name) end
    end):start()
    
    local current = hs.window.focusedWindow()
    if current then M.updateHotkeys(current:application():name()) end
end

return M
