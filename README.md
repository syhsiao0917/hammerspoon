# Hammerspoon Config

這是一個個人用的 [Hammerspoon](https://www.hammerspoon.org/) 設定專案，主要提供：

- 快速啟動常用 App
- 重新載入 Hammerspoon 設定
- 在特定 App 中做快捷鍵重映射
- 快速切換目前視窗的大小與位置

## 主要功能

`init.lua` 是入口檔，負責註冊快捷鍵、載入 `util.lua`，並監看 `~/.hammerspoon/` 目錄變更後自動重新載入。

`util.lua` 提供共用功能，包括：

- `map`：針對指定 App 啟用專屬快捷鍵重映射
- `WindowTogglier`：切換目前視窗為「接近全螢幕」或「置中較小視窗」
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
