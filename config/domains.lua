local platform = require("utils.platform")()

if platform.is_win then
    return {
        ssh_domains = {
            {
                name = "handyMini_qi",
                remote_address = "handy",
                username = "qi",
                ssh_option = {
                    identityfile = "~\\.ssh\\id_ecdsa.pub",
                },
                multiplexing = "None",
            },
            {
                name = "mandev_qi",
                remote_address = "mandev",
                username = "qi",
                ssh_option = {
                    identityfile = "~\\.ssh\\id_ecdsa.pub",
                },
                multiplexing = "None",
            },
        },
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
        ssh_domains = {}, -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
        unix_domains = {}, -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
        wsl_domains = {}, -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
    }
end
