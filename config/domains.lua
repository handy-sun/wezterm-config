return {
    -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
    ssh_domains = {},

    -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
    unix_domains = {},

    -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
    wsl_domains = {
        {
            name = "WSL:Ubuntu",
            distribution = "Ubuntu20.04",
            -- username = "root",
            default_cwd = "~",
            -- default_prog = { "fish", "-l" },
        },
    },
}
