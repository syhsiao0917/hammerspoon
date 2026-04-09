# Hammerspoon Config

這是一個個人用的 [Hammerspoon](https://www.hammerspoon.org/) 設定專案，主要提供：

- 快速啟動常用 App
- 重新載入 Hammerspoon 設定
- 在特定 App 中做快捷鍵重映射
- 快速切換目前視窗的大小與位置
- 在按住 `hyper + shift` 時顯示滑鼠旁的移動提示
- 基本的文字 snippet 展開
- 把目前剪貼簿內容一鍵建立成新的 Apple Notes 筆記，或 append 到 Obsidian 的當日日記

## 主要功能

`init.lua` 是入口檔，負責宣告 app modules、launcher、snippets 設定，載入 bootstrap，並監看 `~/.hammerspoon/` 目錄變更後自動重新載入。

目前建議將 `~/.hammerspoon` 直接連到這個 repo，讓 Hammerspoon 實際使用這份設定。

核心模組：

- [`utils/bootstrap.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/bootstrap.lua)：載入 app modules、組裝 config 與 runtime modules，並啟動整個系統
- [`utils/util_app_loader.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_app_loader.lua)：自動掃描 `apps/` 目錄並載入 app modules
- [`utils/util_launcher.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_launcher.lua)：集中註冊 app launcher 快捷鍵
- [`utils/util_hotkey_manager.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_hotkey_manager.lua)：集中註冊與切換 app-specific remaps
- [`utils/util_snippet_engine.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_snippet_engine.lua)：處理 `;;` snippet 展開
- [`utils/util_window_actions.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_window_actions.lua)：處理視窗相關動作
- [`utils/util_clipboard_capture.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_clipboard_capture.lua)：把目前剪貼簿內容送進新的 Apple Notes 筆記，或 append 到 Obsidian 的當日日記
- [`utils/util_modifier_indicator.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_modifier_indicator.lua)：在按住指定 modifier chord 時顯示滑鼠旁提示
- [`utils/app_registry.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/app_registry.lua)：聚合 app modules 回傳的設定資料
- [`utils/config_validator.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/config_validator.lua)：在啟動時驗證 app module schema
- [`utils/global_sidebar.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/global_sidebar.lua)：統一處理跨 App 的 sidebar toggle
- [`utils/util.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util.lua)：薄相容層，包住上述核心模組

目前的 app-specific 架構是：

- [`init.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/init.lua) 明確列出 launcher 與 snippets 等使用者設定
- 每個 app module 盡量只回傳資料，例如 [`apps/finder.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/apps/finder.lua)、[`apps/safari.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/apps/safari.lua)、[`apps/obsidian.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/apps/obsidian.lua)
- app modules 可以透過 [`utils/util_app_config.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_app_config.lua) 的 `remap(...)` helper 用 one-line 方式追加單一步驟 remap，也可以用 `action(...)` 定義一串自訂動作
- [`utils/util_app_loader.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_app_loader.lua) 自動掃描 `apps/` 並載入 app modules
- [`utils/app_registry.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/app_registry.lua) 只負責聚合這些 app config
- [`utils/config_validator.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/config_validator.lua) 先驗證 app config 內容，再進入註冊流程
- [`utils/util_hotkey_manager.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_hotkey_manager.lua) 統一註冊 remaps
- [`utils/global_sidebar.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/global_sidebar.lua) 統一處理 sidebar mappings

參考資料：

- [`references/sidebar_shortcuts_reference.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/references/sidebar_shortcuts_reference.lua)：整理各 App 側邊欄相關快捷鍵的研究筆記

## 快捷鍵

`hyper = cmd + alt + ctrl`

- `hyper + 0`：重新載入 Hammerspoon
- `hyper + 3`：開啟 Finder
- `hyper + s`：開啟 Safari
- `hyper + t`：開啟 MacVim
- `hyper + g`：開啟 Notes
- `hyper + m`：切到 Notion，並貼上目前剪貼簿內容到當前游標位置
- `hyper + n`：開啟 Notes、建立新筆記，並貼上目前剪貼簿內容
- `hyper + o`：開啟 Obsidian 的當日日記，跳到文末，並貼上目前剪貼簿內容
- `hyper + f`：開啟 Notion
- `hyper + x`：開啟 Codex
- `hyper + shift + tab`：切換目前視窗大小
- 按住 `hyper + shift`：在滑鼠旁顯示 `WIN` 提示，方便辨識目前可用滑鼠移動視窗
- `hyper + ``：依目前 App 送出對應的 sidebar toggle 快捷鍵
- `hyper + 1`：依目前 App 送出對應的 sidebar toggle 快捷鍵

## App 專屬快捷鍵

- 在 `Obsidian` 中，`ctrl + s` 會送出 `escape`
- 在 `Obsidian` 中，`ctrl + e` 會送出 `cmd + o`
- 在 `Safari` 中，`ctrl + s` 會送出 `cmd + [`
- 在 `Finder` 中，`cmd + d` 會送出 `cmd + delete`
- 在 `Finder` 中，`ctrl + u` 會送出 `cmd + up`
- 在 `Finder` 中，`ctrl + shift + c` 會複製目前資料夾路徑到剪貼簿
- 在 `Finder` 中，`ctrl + shift + t` 會在目前資料夾開啟 Terminal
- 在 `Finder` 中，`ctrl + c` 會複製目前所選檔案或資料夾路徑到剪貼簿
- 在 `Notes` 中，`ctrl + e` 會送出 `option + cmd + f`
- 在 `Notion` 中，`ctrl + e` 會送出 `cmd + p`
- 在 `Raycast` 中，`hyper + v` 會送出 `option + return`，並顯示 `Pasted`

## App Module Patterns

[`utils/util_app_config.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_app_config.lua) 目前提供兩種 helper：

- `remap(fromMods, fromKey, toMods, toKey, options)`：適合單一步驟快捷鍵重映射
- `action(fromMods, fromKey, callback, options)`：適合需要送出多個動作、顯示提示、加 delay 的情境

`remap(...)` 範例：

```lua
local appConfig = require("utils.util_app_config")
local r = appConfig.remap

table.insert(remaps, r("ctrl", "e", "cmd", "p"))
```

`action(...)` 範例：

```lua
local appConfig = require("utils.util_app_config")
local action = appConfig.action

table.insert(remaps, action({"cmd", "alt", "ctrl"}, "v", function()
    hs.eventtap.keyStroke({"alt"}, "return", 0)
    hs.alert.show("Pasted")
end))
```

如果某個 app 只需要簡單 remap，維持 `remap(...)` 就好；只有在需要一連串動作時再升級成 `action(...)`。

## Global Sidebar Toggle

[`utils/global_sidebar.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/global_sidebar.lua) 提供統一的 sidebar toggle 入口：

- `hyper + ``：依目前前景 App 送出對應的側邊欄快捷鍵
- `hyper + 1`：與 `hyper + `` 相同，作為容錯用的第二組入口

目前已支援：

- Finder
- Mail
- Reminders
- Keychain Access
- Safari
- Notion
- Visual Studio Code
- Slack
- Arc

如果目前 App 有 sidebar mapping，Hammerspoon 會攔下這組快捷鍵並送出對應的側邊欄快捷鍵。

如果目前 App 沒有 sidebar mapping，Hammerspoon 不會攔截，原本的 `hyper + `` / `hyper + 1` 會直接 pass 給該 App。

## Snippets

目前已設定的文字展開：

- `;;mail` -> `syhsiao0917@gmail.com`
- `;;gh` -> `https://github.com/syhsiao0917`
- `;;name` -> `syhsiao0917`

使用方式：

- 直接輸入完整 trigger，例如 `;;mail`
- 在 trigger 後按空白鍵才會展開
- 展開時會把你剛剛輸入的 trigger 與空白一起取代成 snippet 內容
- 目前所有 snippet 都固定使用 `;;` 作為前綴

設定方式：

- 在 [`init.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/init.lua) 的 `snippetConfig` 只需要填寫名稱本體，例如 `mail`
- Hammerspoon 會自動把它轉成 `;;mail` 來觸發

如果 snippet 沒有作用，先確認：

- Hammerspoon 已重新載入設定
- macOS 已授權 Hammerspoon 的 Accessibility 權限

如果 `hyper + n` 或 `hyper + o` 沒有成功貼上內容，先確認：

- macOS 已授權 Hammerspoon 的 Accessibility 權限
- Obsidian 已啟用 Daily notes core plugin
- 前景沒有系統對話框擋住目標筆記 App 接收快捷鍵

如果 `hyper + m` 沒有成功貼到目前 Notion 游標位置，先確認：

- macOS 已授權 Hammerspoon 的 Accessibility 權限
- Notion 視窗目前已開啟，且編輯游標已經在可輸入的位置
- 前景沒有系統對話框擋住 Notion 接收快捷鍵
