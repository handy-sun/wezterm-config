package.path = './?.lua;./?/init.lua;' .. package.path

package.loaded.wezterm = {
   version = '0-unstable-2026-03-31',
   nerdfonts = setmetatable({}, {
      __index = function(_, key)
         return '<' .. key .. '>'
      end,
   }),
   on = function() end,
   log_error = function() end,
}

local tab_title = require('events.tab-title')
local ok, err = pcall(function()
   tab_title.setup({
      hide_active_tab_unseen = true,
      unseen_icon = 'numbered_box',
      show_progress = true,
   })
end)

if not ok then
   error('tab-title setup should accept unstable wezterm versions: ' .. tostring(err))
end
