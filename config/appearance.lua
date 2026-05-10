local wezterm = require("wezterm")
-- local gpu_adapters = require("utils.gpu_adapter")
local custom = require("colors.custom")
local platform = require("utils.platform")()

local window_frame = {
    active_titlebar_bg = "#0F2536",
    inactive_titlebar_bg = "#0F2536"
}

if platform.is_win then
    -- Fancy tab bar height follows the window frame font size on Windows.
    window_frame.font_size = 12.0
end

return {
    term = "xterm-256color",
    animation_fps = 60,
    max_fps = 120,
    front_end = "WebGpu", ---@type 'WebGpu' | 'OpenGL' | 'Software'
    webgpu_power_preference = "HighPerformance",
    -- webgpu_preferred_adapter = gpu_adapters:pick_best(),

    -- color_scheme = 'Ocean (base16)',
    color_scheme = "qimocha",

    -- background
    window_background_opacity = 1.00,
    win32_system_backdrop = "Acrylic",
    window_background_gradient = {
        colors = { "#1D261B", "#261A25" },
        -- Specifices a Linear gradient starting in the top left corner.
        orientation = { Linear = { angle = -45.0 } },
    },
    background = {
        {
            source = { File = wezterm.GLOBAL.background },
            horizontal_align = "Center",
        },
        {
            source = { Color = custom.background },
            height = "100%",
            width = "100%",
            opacity = 0.96,
        },
    },

    -- scrollbar
    enable_scroll_bar = true,
    min_scroll_bar_height = "3cell",
    colors = {
        scrollbar_thumb = "#34354D",
    },

    -- tab bar
    enable_tab_bar = true,
    hide_tab_bar_if_only_one_tab = false,
    use_fancy_tab_bar = true,
    tab_max_width = 40,
    show_tab_index_in_tab_bar = true,
    switch_to_last_active_tab_when_closing_tab = true,

    -- cursor
    default_cursor_style = "BlinkingBlock",
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    cursor_blink_rate = 700,

    -- window
    adjust_window_size_when_changing_font_size = false,
    -- window_decorations = "INTEGRATED_BUTTONS | RESIZE",
    window_decorations = "NONE",
    -- integrated_title_button_style = "Windows",
    integrated_title_button_color = "auto",
    -- integrated_title_button_alignment = "Right",
    -- initial_cols = 180,
    -- initial_rows = 45,
    window_padding = {
        left = 10,
        right = 10,
        top = 5,
        bottom = 7,
    },
    window_close_confirmation = "NeverPrompt",
    window_frame = window_frame,
    inactive_pane_hsb = {
        saturation = 0.9,
        brightness = 0.65,
    },
}
