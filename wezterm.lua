local Config = require("config")
local wezterm = require("wezterm")
require("utils.backdrops"):set_files():random()

require("events.right-status").setup()
require("events.left-status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()

local opt = Config:init()
    :append(require("config.appearance"))
    :append(require("config.bindings"))
    :append(require("config.fonts"))
    :append(require("config.general"))
    :append(require("config.launch"))
    :append(require("config.domains"))

local has_cus, cus_fun = pcall(require, "custom")
if has_cus then
    local cus_tab = cus_fun()
    wezterm.log_warn("cus_tab: ", cus_tab)
    return opt:append(cus_tab).options
else
    return opt.options
end
