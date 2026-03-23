# Hammerspoon Config

這是一個個人用的 [Hammerspoon](https://www.hammerspoon.org/) 設定專案，主要提供：

- 快速啟動常用 App
- 重新載入 Hammerspoon 設定
- 在特定 App 中做快捷鍵重映射
- 快速切換目前視窗的大小與位置
- 基本的文字 snippet 展開

## 主要功能

`init.lua` 是入口檔，負責註冊快捷鍵、載入 `util.lua`，並監看 `~/.hammerspoon/` 目錄變更後自動重新載入。

目前建議將 `~/.hammerspoon` 直接連到這個 repo，讓 Hammerspoon 實際使用這份設定。

`util.lua` 提供共用功能，包括：

- `map`：針對指定 App 啟用專屬快捷鍵重映射
- `WindowTogglier`：切換目前視窗為「接近全螢幕」或「置中較小視窗」
- `setupSnippets` / `startSnippets`：監聽輸入並展開已設定的 snippet
- `start`：監聽目前啟用中的 App，動態套用對應熱鍵

## 快捷鍵

`hyper = cmd + alt + ctrl`

- `hyper + 0`：重新載入 Hammerspoon
- `hyper + 3`：開啟 Finder
- `hyper + s`：開啟 Safari
- `hyper + t`：開啟 MacVim
- `hyper + g`：開啟 Notes
- `hyper + f`：開啟 Notion
- `hyper + shift + tab`：切換目前視窗大小

## App 專屬快捷鍵

- 在 `Obsidian` 中，`ctrl + s` 會送出 `escape`
- 在 `Safari` 中，`ctrl + s` 會送出 `cmd + [`

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

- 在 [`init.lua`](/Users/stanleyshiao/Library/Mobile%20Documents/com~apple~CloudDocs/Work/hammerspoon/init.lua) 的 `util.setupSnippets(...)` 只需要填寫名稱本體，例如 `mail`
- Hammerspoon 會自動把它轉成 `;;mail` 來觸發

如果 snippet 沒有作用，先確認：

- Hammerspoon 已重新載入設定
- macOS 已授權 Hammerspoon 的 Accessibility 權限
