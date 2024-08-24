-- A slightly altered version of catppucchin mocha
local mocha = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1f1f28",
    mantle = "#181825",
    crust = "#11111b",
}

local colorscheme = {
    foreground = mocha.text,
    background = mocha.base,
    cursor_bg = mocha.rosewater,
    cursor_border = mocha.rosewater,
    cursor_fg = mocha.crust,
    selection_bg = mocha.surface2,
    selection_fg = mocha.text,
    ansi = {
        "#1E1E1E", -- black
        "#EC5F66", -- red
        "#99C794", -- green
        "#F9AE58", -- yellow
        "#6699CC", -- blue
        "#C695C6", -- magenta/purple
        "#5FB4B4", -- cyan
        "#F7F7F7", -- white
    },
    brights = {
        "#B4B4A6", -- black
        "#F97B58", -- red
        "#ACD1A8", -- green
        "#FAC761", -- yellow
        "#85ADD6", -- blue
        "#D8B6D8", -- magenta/purple
        "#82C4C4", -- cyan
        "#FAFAFA", -- white
    },
    tab_bar = {
        background = "rgba(0, 0, 0, 0.4)",
        active_tab = {
            bg_color = mocha.surface2,
            fg_color = mocha.text,
        },
        inactive_tab = {
            bg_color = mocha.surface0,
            fg_color = mocha.subtext1,
        },
        inactive_tab_hover = {
            bg_color = mocha.surface0,
            fg_color = mocha.text,
        },
        new_tab = {
            bg_color = mocha.base,
            fg_color = mocha.text,
        },
        new_tab_hover = {
            bg_color = mocha.mantle,
            fg_color = mocha.text,
            italic = true,
        },
    },
    visual_bell = mocha.surface0,
    indexed = {
        [16] = mocha.peach,
        [17] = mocha.rosewater,
    },
    scrollbar_thumb = mocha.surface2,
    split = mocha.overlay0,
    compose_cursor = mocha.flamingo, -- nightbuild only
}

return colorscheme
