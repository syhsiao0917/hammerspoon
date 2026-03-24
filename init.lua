
hs.alert.show("load init.lua")

local bootstrap = require("utils.bootstrap")

-- reload config
hs.hotkey.bind({"cmd","alt","ctrl"}, "0", function() hs.reload() end)

hyper = {"cmd","alt","ctrl"}
hyper_shift = {"cmd","alt","ctrl", "shift"}

bootstrap.start({
    hyper = hyper,
    hyper_shift = hyper_shift,
})

hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", hs.reload):start()
