-- search_shortcuts_reference.lua
-- macOS 常見 App 與筆記類 App 的搜尋快捷鍵研究筆記（註解版）
--
-- 查核日期：2026-03-27
-- 原則：
-- 1. 盡量以官方文件為主。
-- 2. 若同一個 App 有「全域搜尋 / 目前頁搜尋 / 快速開啟」等不同入口，會分開記。
-- 3. 若這次沒有查到官方明確列出的快捷鍵，會如實註明。
-- 4. 不同版本、語系、鍵盤配置下，實際顯示仍以 App 選單列或官方設定頁為準。

-- ====================
-- macOS / Apple 常見 App
-- ====================

-- Spotlight
-- Cmd + Space
-- Open or close the Spotlight window
--
-- Option + Cmd + Space
-- Open a Finder window with the search field selected
-- Source:
-- https://support.apple.com/guide/mac-help/spotlight-keyboard-shortcuts-mh26783/mac

-- Finder
-- Cmd + F
-- Open a Find window, or find items in a document/app
-- Finder 實務上會進入目前 Finder 視窗的搜尋模式。
-- Source:
-- https://support.apple.com/en-asia/guide/mac-studio/apd194062a6d/mac

-- Safari
-- Cmd + F
-- 搜尋目前網頁中的文字（page find）
--
-- Cmd + L
-- 聚焦到 Smart Search field，可用來輸入網址或網頁搜尋關鍵字
-- 我這裡把它列為「搜尋相關入口」，但它不是 page find。
-- Sources:
-- https://support.apple.com/en-asia/guide/mac-studio/apd194062a6d/mac
-- https://support.apple.com/guide/safari/keyboard-shortcuts-and-gestures-cpsh003/mac

-- Notes
-- Option + Cmd + F
-- Search all notes
--
-- Cmd + F
-- Search in the current note
-- Sources:
-- https://support.apple.com/guide/notes/keyboard-shortcuts-and-gestures-apd46c25187e/mac
-- https://support.apple.com/guide/notes/search-your-notes-not18ab658ed/mac

-- Mail
-- Cmd + F
-- Find text in the currently selected email / conversation
--
-- 這次查到的 Apple 官方文件有明確說明信件內文搜尋是 Cmd + F。
-- 但我這次沒有另外查到一頁 Apple 官方文件，明確列出 mailbox-level 搜尋欄的獨立快捷鍵。
-- Source:
-- https://support.apple.com/en-ge/guide/mail/mail14117/mac

-- Music
-- Cmd + F
-- Select the search field
-- Source:
-- https://support.apple.com/guide/music/keyboard-shortcuts-mus1019/mac

-- Calendar
-- 官方文件說明可以使用右上角 search field 搜尋事件。
-- 但我這次沒有查到 Apple 官方明確列出一組 Calendar 專屬搜尋快捷鍵。
-- Source:
-- https://support.apple.com/my-mm/guide/calendar/icl2cc2c76a7/mac

-- Preview
-- 這次查到的 Apple Preview 鍵盤快捷鍵頁沒有明確列出搜尋快捷鍵。
-- 實務上多半會沿用 Cmd + F 的 Find 行為，但我這次沒有在 Apple 官方 Preview 頁面找到明確列示，因此不硬寫成官方結論。
-- Source:
-- https://support.apple.com/en-lamr/guide/preview/cpprvw0003/mac

-- ====================
-- 筆記相關 App
-- ====================

-- Notion
-- Cmd + F
-- Search inside a page
--
-- Cmd + P
-- Open search / jump to a recently viewed page
--
-- Cmd + K
-- Open search（當游標不在 block 內時）
-- Sources:
-- https://www.notion.com/help/keyboard-shortcuts
-- https://www.notion.com/help/search

-- Obsidian
-- Cmd + Shift + F
-- Open vault search / Search plugin
--
-- Cmd + O
-- Open Quick switcher，可用來搜尋並開啟 note
--
-- Cmd + P
-- Open Command palette，可搜尋命令
-- Sources:
-- https://help.obsidian.md/plugins/search
-- https://help.obsidian.md/plugins/quick-switcher
-- https://help.obsidian.md/plugins/command-palette

-- Bear
-- Cmd + F
-- Search all notes
--
-- Cmd + G
-- Move between results inside the selected note
--
-- Cmd + O
-- Quick Open，可搜尋 note、tag、sidebar section
-- Source:
-- https://bear.app/faq/how-to-search-notes-in-bear/

-- Evernote
-- Cmd + K
-- Search（Evernote app 內）
--
-- Shift + Cmd + K
-- Search in Evernote（global）
--
-- Control + Cmd + E
-- Search in Evernote（alias）
--
-- Cmd + F
-- Find within note
-- Source:
-- https://help.evernote.com/hc/en-us/articles/34296687388307-Keyboard-shortcuts

-- OneNote for Mac
-- Cmd + F
-- Find on current page
--
-- Option + Cmd + F
-- Search all open notebooks
-- Source:
-- https://support.microsoft.com/en-us/office/find-and-replace-text-in-notes-34b1f7f8-d327-40c5-8b0c-8419425ed68b

-- Apple Notes / Notion / Obsidian / Bear / Evernote / OneNote 的大致分工可整理成：
--
-- 1. 「目前頁 / 目前筆記搜尋」
--    常見是 Cmd + F
--
-- 2. 「整個工作區 / 整個 vault / 所有筆記搜尋」
--    常見會改成更重的組合，例如：
--    - Option + Cmd + F
--    - Cmd + Shift + F
--    - Cmd + P / Cmd + K
--
-- 3. 「快速開啟 / 快速切換」
--    常見是 Cmd + O 或 Cmd + P
--
-- 這不是統一規則，但用來設計跨 App 一致化 remap 時很有參考價值。
