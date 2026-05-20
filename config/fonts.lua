local platform = require("utils.platform")
local wezterm = require("wezterm")

local font_size = platform.is_mac and 12 or 9.75

---@type Config
return {
    font_size = platform().is_mac and 16 or 12,
    font = wezterm.font_with_fallback({
        "NotoMono NFM",
        "FiraCode Nerd Font Mono",
        "JetBrains Mono",
        "DejaVu Sans Mono",
        "Droid Sans Mono",
        "Consolas",
    }),

    --ref: https://wezfurlong.org/wezterm/config/lua/config/freetype_pcf_long_family_names.html#why-doesnt-wezterm-use-the-distro-freetype-or-match-its-configuration
    ---@type "Normal"|"Light"|"Mono"|"HorizontalLcd"
    freetype_load_target = "Normal",
    freetype_render_target = "Normal",
}
