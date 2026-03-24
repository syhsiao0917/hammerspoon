-- obsidian.lua
-- Obsidian-specific config.

return {
    name = "Obsidian",
    sidebarNote = "Obsidian supports sidebar commands, but its sidebar hotkeys are usually user-assigned rather than a fixed default.",
    remaps = {
        {
            fromMods = {"ctrl"},
            fromKey = "s",
            toMods = {},
            toKey = "escape",
        },
    },
}
