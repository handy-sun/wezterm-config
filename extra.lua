local Config = require("config")

require("utils.backdrops"):set_files():random()

require("events.right-status").setup()
require("events.left-status").setup()
require("events.tab-title").setup()
require("events.new-tab-button").setup()
require("events.maximize").setup()

local opt = Config:init()
    :append(require("config.appearance"))
    :append(require("config.bindings"))
    :append(require("config.general"))
    :append(require("config.launch"))
    :append(require("config.domains"))

-- Home Manager appends this file after defining the generated `config` table.
for k, v in pairs(opt.options) do
    ---@diagnostic disable-next-line: undefined-global
    config[k] = v
end
