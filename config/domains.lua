local wezterm = require("wezterm")
local platform = require("utils.platform")

local ssh_domains = wezterm.default_ssh_domains and wezterm.default_ssh_domains() or {}
local wsl_domains = {}

if platform.is_win and wezterm.default_wsl_domains then
    wsl_domains = wezterm.default_wsl_domains()
end

return {
    ssh_domains = ssh_domains,
    wsl_domains = wsl_domains,
    unix_domains = {},
}
