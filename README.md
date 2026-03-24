# Hammerspoon Config

這是一個個人用的 [Hammerspoon](https://www.hammerspoon.org/) 設定專案，主要提供：

- 快速啟動常用 App
- 重新載入 Hammerspoon 設定
- 在特定 App 中做快捷鍵重映射
- 快速切換目前視窗的大小與位置
- 基本的文字 snippet 展開

## 主要功能

`init.lua` 是入口檔，負責組裝核心模組、註冊全域快捷鍵，並監看 `~/.hammerspoon/` 目錄變更後自動重新載入。

目前建議將 `~/.hammerspoon` 直接連到這個 repo，讓 Hammerspoon 實際使用這份設定。

核心模組：

- [`utils/util_hotkey_manager.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_hotkey_manager.lua)：集中註冊與切換 app-specific remaps
- [`utils/util_snippet_engine.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_snippet_engine.lua)：處理 `;;` snippet 展開
- [`utils/util_window_actions.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_window_actions.lua)：處理視窗相關動作
- [`utils/app_registry.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/app_registry.lua)：聚合 app modules 回傳的設定資料
- [`utils/global_sidebar.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/global_sidebar.lua)：統一處理跨 App 的 sidebar toggle
- [`utils/util.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util.lua)：薄相容層，包住上述核心模組

目前的 app-specific 架構是：

- [`init.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/init.lua) 明確載入要使用的 app modules
- 每個 app module 盡量只回傳資料，例如 [`finder.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/finder.lua)、[`safari.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/safari.lua)、[`obsidian.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/obsidian.lua)
- [`utils/app_registry.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/app_registry.lua) 只負責聚合這些 app config
- [`utils/util_hotkey_manager.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/util_hotkey_manager.lua) 統一註冊 remaps
- [`utils/global_sidebar.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/utils/global_sidebar.lua) 統一處理 sidebar mappings

## 快捷鍵

`hyper = cmd + alt + ctrl`

- `hyper + 0`：重新載入 Hammerspoon
- `hyper + 3`：開啟 Finder
- `hyper + s`：開啟 Safari
- `hyper + t`：開啟 MacVim
- `hyper + g`：開啟 Notes
- `hyper + f`：開啟 Notion
- `hyper + shift + tab`：切換目前視窗大小
- `hyper + ``：依目前 App 送出對應的 sidebar toggle 快捷鍵
- `hyper + 1`：依目前 App 送出對應的 sidebar toggle 快捷鍵

## App 專屬快捷鍵

- 在 `Obsidian` 中，`ctrl + s` 會送出 `escape`
- 在 `Safari` 中，`ctrl + s` 會送出 `cmd + [`
- 在 `Finder` 中，`cmd + d` 會送出 `cmd + delete`

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

如果目前 App 沒有可靠的預設 sidebar toggle，Hammerspoon 會顯示提示，不會送出不確定的快捷鍵。

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

- 在 [`init.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/init.lua) 的 `snippetEngine.configure(...)` 只需要填寫名稱本體，例如 `mail`
- Hammerspoon 會自動把它轉成 `;;mail` 來觸發

如果 snippet 沒有作用，先確認：

- Hammerspoon 已重新載入設定
- macOS 已授權 Hammerspoon 的 Accessibility 權限
