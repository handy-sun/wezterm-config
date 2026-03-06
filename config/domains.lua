local platform = require("utils.platform")()

if platform.is_win then
    return {
        unix_domains = {},
        wsl_domains = {
            {
                name = "WSL:Ubuntu-20.04",
                distribution = "Ubuntu-20.04",
                default_cwd = "~",
                default_prog = { "zsh", "-l" },
            },
        },
    }
else
    return {
        unix_domains = {},
    }
end
