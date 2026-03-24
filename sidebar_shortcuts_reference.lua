-- sidebar_shortcuts_reference.lua
-- macOS 常見 App 的側邊欄顯示/隱藏快捷鍵參考（註解版）
--
-- 查核日期：2026-03-24
-- 原則：
-- 1. 盡量以 Apple 官方文件為主。
-- 2. 若官方文件有明確列出快捷鍵，就直接記錄。
-- 3. 若官方文件只提到 View 選單可顯示/隱藏，但沒有列快捷鍵，也會註明。
-- 4. 不同 macOS 版本、語系、鍵盤配置下，快捷鍵可能不同；最準仍以 App 選單列為準。

-- ====================
-- 有明確官方快捷鍵的 App
-- ====================

-- Finder
-- Option + Cmd + S
-- Hide or show the Sidebar in Finder windows.
-- Source:
-- https://support.apple.com/en-us/102650

-- Mail
-- Control + Cmd + S
-- Show Sidebar / Hide Sidebar
-- Source:
-- https://support.apple.com/guide/mail/use-the-sidebar-or-favorites-bar-mlhl1178673f/mac

-- Reminders
-- Option + Cmd + S
-- Hide or show sidebar
-- Source:
-- https://support.apple.com/en-afri/guide/reminders/remn19b3424c/mac

-- Keychain Access
-- Control + Cmd + S
-- Hide or show the Keychain Viewer sidebar
-- Source:
-- https://support.apple.com/en-mt/guide/keychain-access/kyca699a9058/mac

-- Notion
-- Cmd + \
-- Open or close the sidebar
-- Source:
-- https://www.notion.com/help/navigate-with-the-sidebar

-- Safari
-- Control + Cmd + 1
-- Show or hide the Bookmarks sidebar
-- Source:
-- https://support.apple.com/guide/safari/keyboard-shortcuts-and-gestures-cpsh003/mac

-- Visual Studio Code
-- Cmd + B
-- Toggle Primary Side Bar visibility
-- Option + Cmd + B
-- Toggle Secondary Side Bar visibility
-- Sources:
-- https://code.visualstudio.com/docs/editor/custom-layout
-- https://code.visualstudio.com/docs/getstarted/keybindings

-- Slack
-- Cmd + .
-- Hide the right sidebar
-- Source:
-- https://slack.com/help/articles/201374536-Slack-keyboard-shortcuts-and-commands

-- Arc
-- Cmd + S
-- Show or hide the sidebar
-- Source:
-- https://resources.arc.net/hc/en-us/articles/20595231349911-Keyboard-Shortcuts

-- Microsoft Edge
-- Cmd + Shift + E
-- Open search in sidebar
-- 我這次查到 Microsoft 官方文件有明確列出這組 sidebar 相關快捷鍵，
-- 但它比較像是「打開側欄中的搜尋」，不是通用的 show/hide sidebar toggle。
-- Source:
-- https://support.microsoft.com/en-us/microsoft-edge/keyboard-shortcuts-in-microsoft-edge-50d3edab-30d9-c7e4-21ce-37fe2713cfad

-- ====================
-- 官方文件提到側邊欄，但未明確列出快捷鍵
-- ====================

-- Notes
-- 官方文件提到：
-- View > Show Folders
-- 但我這次查到的 Apple Notes 文件沒有在該頁明確列出預設鍵盤快捷鍵。
-- Sources:
-- https://support.apple.com/guide/notes/view-your-notes-apd8b73d28be/mac
-- https://support.apple.com/en-euro/guide/notes/apd558a85438/mac
-- https://support.apple.com/en-kg/guide/notes/apd46c25187e/mac

-- Obsidian
-- 官方文件說明：
-- Obsidian 有 left sidebar / right sidebar，也可以用 Command palette 的
-- "Toggle left sidebar" / "Toggle right sidebar" 指令操作。
-- 但我這次查到的官方文件沒有列出一組固定的「預設」側邊欄快捷鍵；
-- 比較像是要由使用者在 Hotkeys 裡自行指派。
-- Sources:
-- https://help.obsidian.md/sidebar
-- https://help.obsidian.md/hotkeys

-- Calendar
-- 官方文件提到：
-- View > Show Calendar List
-- 但我這次查到的 Apple Calendar 文件沒有在該頁明確列出側邊欄 toggle 的快捷鍵。
-- Sources:
-- https://support.apple.com/en-lamr/guide/calendar/icl1006/mac
-- https://support.apple.com/en-hk/guide/calendar/ical002/mac

-- Photos
-- 官方文件顯示 Photos 有 sidebar，但我這次查到的 Apple Photos 文件沒有明確列出
-- 「Show/Hide Sidebar」的鍵盤快捷鍵。
-- Source:
-- https://support.apple.com/kk-kz/guide/photos/pht9b4411b24/mac

-- Preview（看 PDF 時）
-- 官方文件顯示 Preview 在開啟多頁 PDF 時有左側 sidebar，可切換：
-- View > Thumbnails
-- View > Table of Contents
-- View > Hide Sidebar
-- 但我這次查到的 Apple Preview 文件沒有明確列出一組固定的
-- show/hide sidebar 鍵盤快捷鍵。
-- Sources:
-- https://support.apple.com/guide/preview/view-pdfs-and-images-prvw11470/mac
-- https://support.apple.com/guide/preview/keyboard-shortcuts-cpprvw0003/mac

-- Books
-- 官方文件顯示 Books 有 Library sidebar，但我這次查到的 Apple Books 文件沒有明確列出
-- sidebar toggle 的鍵盤快捷鍵。
-- Sources:
-- https://support.apple.com/en-lb/guide/books/ibk0a716cf4-9a70-485b-9835-72e3c7ed6c29/mac
-- https://support.apple.com/guide/books/change-a-books-appearance-ibks8923126d/mac

-- Music
-- 官方文件顯示 Music 有 sidebar / library navigation，
-- 但我這次查到的 Apple Music 鍵盤快捷鍵頁沒有明確列出 sidebar toggle。
-- Source:
-- https://support.apple.com/guide/music/keyboard-shortcuts-mus1019/mac

-- Podcasts
-- 官方文件顯示 Podcasts 有 sidebar / show list，
-- 但我這次查到的 Apple Podcasts 鍵盤快捷鍵頁沒有明確列出 sidebar toggle。
-- Sources:
-- https://support.apple.com/guide/podcasts/keyboard-shortcuts-podcd31cff4/mac
-- https://support.apple.com/en-us/HT212181

-- Chrome
-- Chrome 有部分側欄/面板相關快捷鍵，例如：
-- Option + Cmd + R -> Show reading list
-- 但我這次查到的 Google 官方文件沒有列出一組通用的「show/hide sidebar」快捷鍵。
-- Source:
-- https://support.google.com/chrome/answer/157179?co=GENIE.Platform%3DDesktop&hl=en

-- ====================
-- 可觀察到的命名模式
-- ====================

-- 某些 Apple App 會用以下兩種風格：
--
-- 1. Control + Cmd + S
--    例如 Mail、Keychain Access
--
-- 2. Option + Cmd + S
--    例如 Finder、Reminders
--
-- 但這不是整個 macOS 的統一規則，不能直接假設所有 App 都跟其中一組一致。
