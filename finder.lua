-- finder.lua
-- Finder 專屬快捷鍵設定
--
-- 這個檔案只放 Finder 相關內容：
-- 1. Finder 預設快捷鍵參考（以 Finder 專屬、非 global shortcut 為主）
-- 2. 這個專案對 Finder 的自訂 remap
--
-- 來源：
-- Apple Support - Mac keyboard shortcuts
-- https://support.apple.com/en-lamr/102650
--
-- 注意：
-- 1. 不同 macOS 版本、語系、鍵盤配置下，部分快捷鍵可能不同。
-- 2. 最準確仍以 Finder 選單列顯示的快捷鍵為準。

-- ====================
-- Finder 專屬預設快捷鍵
-- ====================

-- Cmd + N
-- 開新 Finder 視窗

-- Cmd + T
-- 開新分頁

-- Shift + Cmd + N
-- 建立新資料夾

-- Control + Cmd + N
-- 將目前選取項目建立為新資料夾

-- Cmd + D
-- 複製所選項目（Duplicate）

-- Cmd + Delete
-- 將所選項目移到垃圾桶

-- Shift + Cmd + Delete
-- 清空垃圾桶

-- Option + Shift + Cmd + Delete
-- 直接清空垃圾桶，不顯示確認視窗

-- Cmd + I
-- 取得資訊

-- Option + Cmd + I
-- 顯示 Inspector

-- Cmd + O
-- 開啟所選項目

-- Cmd + Down
-- 開啟所選項目或進入所選資料夾

-- Cmd + Up
-- 回到上一層資料夾

-- Cmd + R
-- 若選到 alias，顯示其原始檔案

-- Space
-- Quick Look 預覽所選項目

-- Cmd + Y
-- 使用 Quick Look 預覽

-- Cmd + F
-- 在 Finder 視窗中開始搜尋

-- Cmd + G
-- 前往資料夾

-- Cmd + E
-- 卸載所選磁碟或卷宗

-- Cmd + 1
-- 以圖示顯示

-- Cmd + 2
-- 以列表顯示

-- Cmd + 3
-- 以欄位顯示

-- Cmd + 4
-- 以圖庫顯示

-- Cmd + J
-- 顯示檢視選項

-- Option + Cmd + P
-- 顯示或隱藏預覽面板

-- Option + Cmd + S
-- 顯示或隱藏側邊欄

-- Shift + Cmd + P
-- 顯示或隱藏預覽

-- Shift + Cmd + .
-- 顯示或隱藏隱藏檔案

-- Option + Cmd + C
-- 複製所選項目的路徑名稱

-- Cmd + 點選視窗標題
-- 顯示目前資料夾的完整路徑階層

-- Shift + Cmd + A
-- 前往 Applications

-- Shift + Cmd + C
-- 前往 Computer

-- Shift + Cmd + D
-- 前往 Desktop

-- Shift + Cmd + F
-- 前往 Recents

-- Shift + Cmd + G
-- 前往資料夾

-- Shift + Cmd + H
-- 前往 Home

-- Shift + Cmd + I
-- 前往 iCloud Drive

-- Option + Cmd + L
-- 前往 Downloads

-- Shift + Cmd + O
-- 前往 Documents

-- Shift + Cmd + R
-- 前往 AirDrop

-- Shift + Cmd + U
-- 前往 Utilities

-- ====================
-- 專案自訂 Finder 快捷鍵
-- ====================

-- Cmd + D
-- 預設是 Duplicate
-- 本專案改成送出 Cmd + Delete，也就是把所選項目移到垃圾桶

return {
    name = "Finder",
    sidebar = {mods = {"alt", "cmd"}, key = "s"},
    remaps = {
        {
            app = "Finder",
            fromMods = {"cmd"},
            fromKey = "d",
            toMods = {"cmd"},
            toKey = "delete",
        },
    },
}
