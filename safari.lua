-- safari.lua
-- Safari-specific config.

return {
    name = "Safari",
    sidebar = {mods = {"ctrl", "cmd"}, key = "1"},
    remaps = {
        {
            app = "Safari",
            fromMods = {"ctrl"},
            fromKey = "s",
            toMods = {"cmd"},
            toKey = "[",
        },
    },
}
