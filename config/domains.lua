local platform = require("utils.platform")()

if platform.is_win then
    return {
        unix_domains = {},
        wsl_domains = {
            {
                name = "WSL:NixOS",
                distribution = "nixos", --- 这个值是 wsl.exe -l -v 输出的 distribution 名称
                default_cwd = "~",
            },
            {
                name = "WSL:ArchLinux",
                distribution = "arch",
                default_cwd = "~",
            },
        },
    }
else
    return {
        unix_domains = {},
    }
end
