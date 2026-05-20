local Config = require("config")
-- local wezterm = require("wezterm")

local opt = Config:init()
    :append(require("config.appearance"))
    :append(require("config.bindings"))
    :append(require("config.general"))
    :append(require("config.launch"))
    :append(require("config.domains"))

require('utils.backdrops')
   -- :set_images_dir(require('wezterm').home_dir .. '/Pictures/Wallpapers/')
   :scan_images_dir()
   :random()

require('events.left-status').setup()
require('events.right-status').setup({ date_format = '%a %H:%M:%S' })
require('events.tab-title').setup({
   hide_active_tab_unseen = true,
   unseen_icon = 'numbered_box',
   show_progress = true,
})
require('events.new-tab-button').setup()
require('events.gui-startup').setup()

-- Home Manager appends this file after defining the generated `config` table.
for k, v in pairs(opt.options) do
    ---@diagnostic disable-next-line: undefined-global
    config[k] = v
end
