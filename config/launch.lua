local platform = require("utils.platform")()

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
end

return options
