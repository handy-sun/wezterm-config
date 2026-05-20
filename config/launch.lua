local platform = require("utils.platform")

local options = { }

if platform.is_win then
    options.default_prog = { "pwsh", "-NoLogo" }
    options.launch_menu = {
        { label = " PowerShell v7", args = { "pwsh", "-NoLogo" } },
        { label = " PowerShell v1", args = { "powershell", "-NoLogo" } },
        { label = " Cmd", args = { "cmd" } },
        {
            --- install by chocolaty
            label = " GitBash",
            args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
        },
    }
elseif platform.is_mac or platform.is_linux then
    options.default_prog = { "fish", "-il" }
    options.launch_menu = {
        { label = "Fish", args = { "fish", "-il" } },
        { label = "Fish(Private)", args = { "fish", "-il", "-P" } },
        { label = "Zsh", args = { "zsh", "-il" } },
        { label = "Bash", args = { "bash", "-l" } },
    }
end

return options
