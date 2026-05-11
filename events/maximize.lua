local wezterm = require("wezterm")
local mux = wezterm.mux

local M = {}

function M.setup()
    wezterm.on("gui-startup", function(cmd)
        local _, _, window = mux.spawn_window(cmd or {})
        window:gui_window():maximize()
    end)
end

return M
