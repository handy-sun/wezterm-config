local wezterm = require("wezterm")

---@class ConfigBuilder
---@field options Config
local Config = {}
Config.__index = Config

---Initialize Config
---@return ConfigBuilder
function Config:init()
    local config = setmetatable({ options = {} }, self)
    return config
end

---Append to `Config.options`
---@param new_options table new options to append
---@return ConfigBuilder
function Config:append(new_options)
    for k, v in pairs(new_options) do
        self.options[k] = v
    end
    return self
end

-- function Config:append(new_options)
--     for k, v in pairs(new_options) do
--         if self.options[k] ~= nil then
--             wezterm.log_warn(
--                 "Duplicate config option detected: ",
--                 { old = self.options[k], new = new_options[k] }
--             )
--         else
--             self.options[k] = v
--         end
--     end
--     return self
-- end

return Config
