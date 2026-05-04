# WezTerm Config

## 项目结构

```
wezterm.lua              ← 入口，链式加载所有模块
custom.lua               ← 平台感知 default_prog / launch_menu 覆盖
config/
  init.lua               ← Config 类（builder 模式，Config:append 合并）
  general.lua            ← 通用行为 + hyperlink rules
  appearance.lua         ← 外观/窗口/光标/tab bar 配置
  fonts.lua              ← 字体设置
  bindings.lua           ← 所有按键/鼠标绑定、key tables、leader 键
  launch.lua             ← default_prog + launch_menu（按平台）
  domains.lua            ← unix/wsl domains
colors/
  custom.lua             ← Catppuccin Mocha 变体颜色方案（完整定义）
  qimocha.toml           ← TOML 颜色方案文件
events/
  tab-title.lua          ← format-tab-title 事件处理器
  right-status.lua       ← update-right-status（日期+电量）
  left-status.lua        ← update-left-status（key table/leader 指示）
  new-tab-button.lua     ← new-tab-button-click 处理
utils/
  platform.lua           ← 平台检测（从 wezterm.target_triple）
  cells.lua              ← FormatCells 构建器（segment 格式化）
  math.lua               ← clamp/round 辅助函数
  gpu_adapter.lua        ← GPU adapter 选择（当前未使用）
  backdrops.lua          ← 背景图片控制器
  opts-validator.lua     ← 事件选项 schema 验证器
backdrops/
  voyage.jpg, space.jpg, astro-jelly.jpg
```

---

## 配置项详情

### 1. 字体（fonts.lua）

| 设置 | 值 |
|---|---|
| `font_size` | macOS: `16`，其他: `12` |
| `font` | `wezterm.font_with_fallback({"NotoMono NFM", {family="Maple Mono NF", weight="Medium"}, "Droid Sans Mono", "Consolas"})` |
| `freetype_load_target` | `"Normal"` |
| `freetype_render_target` | `"Normal"` |

### 2. 通用（general.lua）

| 设置 | 值 |
|---|---|
| `automatically_reload_config` | `true` |
| `check_for_updates` | `false` |
| `exit_behavior` | `"CloseOnCleanExit"` |
| `status_update_interval` | `1000` |
| `scrollback_lines` | `5000` |
| `canonicalize_pasted_newlines` | `"CarriageReturn"` |

**Hyperlink Rules**（6 条）：
1. 括号内 URL：`\((\w+://\S+)\)` → `$1`
2. 方括号内 URL：`\[(\w+://\S+)\]` → `$1`
3. 花括号内 URL：`\{(\w+://\S+)\}` → `$1`
4. 尖括号内 URL：`<(\w+://\S+)>` → `$1`
5. 裸 URL：`\b\w+://\S+[)/a-zA-Z0-9-]+` → `$0`
6. 隐式 mailto：`\b\w+@[\w-]+(\.[\w-]+)+\b` → `mailto:$0`

### 3. 外观（appearance.lua）

| 设置 | 值 |
|---|---|
| `term` | `"xterm-256color"` |
| `animation_fps` | `60` |
| `max_fps` | `120` |
| `front_end` | `"WebGpu"` |
| `webgpu_power_preference` | `"HighPerformance"` |
| `color_scheme` | `"qimocha"` |
| `window_background_opacity` | `1.0` |
| `win32_system_backdrop` | `"Acrylic"` |
| `window_background_gradient.colors` | `{"#1D261B", "#261A25"}` |
| `window_background_gradient.orientation` | `{Linear = {angle = -45.0}}` |
| `background[1]` | `{File = wezterm.GLOBAL.background}`, `horizontal_align = "Center"` |
| `background[2]` | `{Color = "#1f1f28"}`, `height = "100%"`, `width = "100%"`, `opacity = 0.96` |
| `enable_scroll_bar` | `true` |
| `min_scroll_bar_height` | `"3cell"` |
| `colors.scrollbar_thumb` | `"#34354D"` |
| `enable_tab_bar` | `true` |
| `hide_tab_bar_if_only_one_tab` | `false` |
| `use_fancy_tab_bar` | `true` |
| `tab_max_width` | `40` |
| `show_tab_index_in_tab_bar` | `true` |
| `switch_to_last_active_tab_when_closing_tab` | `true` |
| `default_cursor_style` | `"BlinkingBlock"` |
| `cursor_blink_ease_in` | `"Constant"` |
| `cursor_blink_ease_out` | `"Constant"` |
| `cursor_blink_rate` | `700` |
| `adjust_window_size_when_changing_font_size` | `false` |
| `window_decorations` | `"INTEGRATED_BUTTONS\|RESIZE"` |
| `integrated_title_button_style` | `"Windows"` |
| `integrated_title_button_color` | `"auto"` |
| `integrated_title_button_alignment` | `"Right"` |
| `initial_cols` | `180` |
| `initial_rows` | `45` |
| `window_padding` | `{left=5, right=10, top=12, bottom=7}` |
| `window_close_confirmation` | `"NeverPrompt"` |
| `window_frame.active_titlebar_bg` | `"#0F2536"` |
| `window_frame.inactive_titlebar_bg` | `"#0F2536"` |
| `inactive_pane_hsb.saturation` | `0.9` |
| `inactive_pane_hsb.brightness` | `0.65` |

### 4. 按键绑定（bindings.lua）

**修饰键**（平台感知）：
- macOS: `SUPER = "SUPER"`, `SUPER_REV = "SUPER|CTRL"`
- Windows/Linux: `SUPER = "ALT"`, `SUPER_REV = "ALT|CTRL"`

**Leader 键**: `Space + SUPER_REV`（即 macOS: SUPER+CTRL+Space，Linux: ALT+CTRL+Space）

**配置**: `disable_default_key_bindings = true`

**快捷键**（31 个）：

| 按键 | 修饰键 | 动作 |
|---|---|---|
| F1 | CTRL | ActivateCopyMode |
| F2 | CTRL | ActivateCommandPalette |
| F3 | CTRL | ShowLauncher |
| F4 | CTRL | ShowLauncherArgs(FUZZY\|TABS) |
| F5 | CTRL | ShowLauncherArgs(FUZZY\|WORKSPACES) |
| F10 | SUPER | Search(CaseInSensitiveString="") |
| F11 | CTRL | ToggleFullScreen |
| F12 | CTRL | ShowDebugOverlay |
| u | SUPER | QuickSelectArgs（5个URL模式，用 wezterm.open_with 打开） |
| LeftArrow | CTRL\|SHIFT | SendString `\u{1b}OH` |
| RightArrow | CTRL\|SHIFT | SendString `\u{1b}OF` |
| Backspace | SUPER | SendString `\u{15}` |
| c | CTRL\|SHIFT | CopyTo("Clipboard") |
| Insert | CTRL | CopyTo("Clipboard") |
| v | CTRL\|SHIFT | PasteFrom("Clipboard") |
| v | SUPER | PasteFrom("Clipboard") |
| Insert | SHIFT | PasteFrom("Clipboard") |
| t | SUPER | SpawnTab("DefaultDomain") |
| w | SUPER_REV | CloseCurrentTab(confirm=false) |
| [ | SUPER | ActivateTabRelative(-1) |
| ] | SUPER | ActivateTabRelative(1) |
| [ | SUPER_REV | MoveTabRelative(-1) |
| ] | SUPER_REV | MoveTabRelative(1) |
| n | SUPER | SpawnWindow |
| / | SUPER | backdrops:random（随机背景） |
| , | SUPER | backdrops:cycle_back（上一张背景） |
| . | SUPER | backdrops:cycle_forward（下一张背景） |
| / | SUPER_REV | InputSelector — "Select Background"（模糊选择） |
| \ | SUPER | SplitVertical(CurrentPaneDomain) |
| \ | SUPER_REV | SplitHorizontal(CurrentPaneDomain) |
| Enter | SUPER | TogglePaneZoomState |
| w | SUPER | CloseCurrentPane(confirm=false) |
| k | SUPER_REV | ActivatePaneDirection("Up") |
| j | SUPER_REV | ActivatePaneDirection("Down") |
| h | SUPER_REV | ActivatePaneDirection("Left") |
| l | SUPER_REV | ActivatePaneDirection("Right") |
| p | SUPER_REV | PaneSelect(alphabet="1234567890", mode="SwapWithActiveKeepFocus") |

**Key Tables**（通过 LEADER 键激活）：

`resize_font`（LEADER → f）：
- k: IncreaseFontSize
- j: DecreaseFontSize
- r: ResetFontSize
- Escape/q: PopKeyTable

`resize_pane`（LEADER → p）：
- k/j/h/l: AdjustPaneSize(方向, 1)
- Escape/q: PopKeyTable

**鼠标绑定**：
- Ctrl+左键 → OpenLinkAtMouseCursor
- 右键 → PasteFrom("Clipboard")

### 5. 启动（launch.lua）

macOS/Linux：
- `default_prog = {"/run/current-system/sw/bin/fish", "-il"}`
- `launch_menu`: Fish, Fish(Private, `-il -P`), Zsh, Bash

Windows：
- `default_prog = {"pwsh", "-NoLogo"}`
- `launch_menu`: PowerShell v7, PowerShell v1, Cmd, GitBash

### 6. Domains（domains.lua）

macOS/Linux: `unix_domains = {}`（空）

Windows: WSL domains（Ubuntu-20.04, NixOS）

### 7. 颜色方案（colors/custom.lua + qimocha.toml）

**qimocha** — Catppuccin Mocha 变体：

基础色：
- `foreground = "#e8ecf4"` (text)
- `background = "#1f1f28"` (base)
- `cursor_bg = "#f5e0dc"` (rosewater)
- `cursor_border = "#f5e0dc"` (rosewater)
- `cursor_fg = "#11111b"` (crust)
- `selection_bg = "#585b70"` (surface2)
- `selection_fg = "#e8ecf4"` (text)

ANSI: `#1E1E1E` `#EC5F66` `#99C794` `#F9AE58` `#6699CC` `#C695C6` `#5FB4B4` `#F7F7F7`

Brights: `#B4B4A6` `#F97B58` `#ACD1A8` `#FAC761` `#85ADD6` `#D8B6D8` `#82C4C4` `#FAFAFA`

Tab bar：
- `background = "rgba(0, 0, 0, 0.4)"`
- active_tab: bg=`#585b70`, fg=`#e8ecf4`
- inactive_tab: bg=`#313244`, fg=`#bac2de`
- inactive_tab_hover: bg=`#313244`, fg=`#e8ecf4`
- new_tab: bg=`#1f1f28`, fg=`#e8ecf4`
- new_tab_hover: bg=`#181825`, fg=`#e8ecf4`, italic=`true`

其他：
- `visual_bell = "#313244"`
- `indexed[16] = "#fab387"` (peach)
- `indexed[17] = "#f5e0dc"` (rosewater)
- `scrollbar_thumb = "#585b70"`
- `split = "#6c7086"`
- `compose_cursor = "#f2cdcd"`

**注意**：TOML 文件 (qimocha.toml) 的 foreground 为 `#d8dfda`，white ANSI/bright 值也略有不同，与 Lua 版本存在细微差异。

### 8. 事件处理器

#### format-tab-title（tab-title.lua）

渲染逻辑：创建 Tab 对象，根据状态（active/hover/default）+ 标记（admin/WSL/unseen output）生成 6 种渲染变体。

Glyphs（nerdfonts）：
- `GLYPH_SCIRCLE_LEFT/RIGHT` — 半圆装饰
- `GLYPH_CIRCLE` — 未见输出标记
- `GLYPH_ADMIN` — 管理员标记（shield）
- `GLYPH_LINUX` — WSL 标记
- `GLYPH_DEBUG` — 调试标记
- `GLYPH_SEARCH` — 搜索标记（🔭）
- `GLYPH_UNSEEN_NUMBERED_BOX/CIRCLE[1..10]` — 数字未见输出标记

Tab 标题颜色：
| 状态 | 背景 | 前景 |
|---|---|---|
| text_default | #45475A | #1C1B19 |
| text_hover | #5D87A3 | #1C1B19 |
| text_active | #74c7ec | #11111B |
| unseen_output_default | #45475A | #FFA066 |
| unseen_output_hover | #5D87A3 | #FFA066 |
| unseen_output_active | #74c7ec | #FFA066 |
| scircle_* | rgba(0,0,0,0.4) | 对应 text 颜色 |

自定义事件：
- `tabs.manual-update-tab-title` — 重命名 tab（InputLine）
- `tabs.reset-tab-title` — 重置手动标题
- `tabs.toggle-tab-bar` — 切换 tab bar 显示

#### update-right-status（right-status.lua）

- 显示日期（`%a %H:%M`）和电量（10级充放电图标）
- 颜色：日期 `#7F82BB`，电量 `#BB49B3`，分隔符 `#786D22`，背景 `#0F2536`
- 分隔符：`" ~ "`

#### update-left-status（left-status.lua）

- 显示当前 key table 名称或 leader 激活状态
- Glyphs: key_table(🔑), key(🗝)
- 颜色：glyph bg=`rgba(0,0,0,0.4)` fg=`#fab387`，text bg=`#fab387` fg=`#1c1b19`

#### new-tab-button-click（new-tab-button.lua）

- 左键 → 默认操作（新 tab）
- 右键 → ShowLauncherArgs（fuzzy 搜索）

### 9. 工具模块

#### backdrops.lua
- 从 `backdrops/` 目录读取图片文件
- `wezterm.GLOBAL.background` 存储当前背景路径
- 方法：random, cycle_forward, cycle_back, set_img, choices（InputSelector 用）
- 通过 `_set_opt` 应用：File source（居中）+ Color overlay（0.96 opacity）

#### cells.lua
- FormatCells 构建器，用于 wezterm.format
- 支持 segment 管理：add/update/render/reset
- 属性：Intensity(Bold/Half/Normal), Italic, Underline

#### platform.lua
- 从 `wezterm.target_triple` 检测 OS
- 返回 `{os, is_win, is_linux, is_mac}`

#### gpu_adapter.lua
- GPU adapter 选择器（当前未使用，代码中被注释）
- 支持 DiscreteGpu > IntegratedGpu > Other > Cpu 优先级

---

## Nix 转换策略

### HM `programs.wezterm` 模块选项

| 选项 | 类型 | 用途 |
|---|---|---|
| `enable` | bool | 启用模块 |
| `package` | package | wezterm 包 |
| `enableBashIntegration` | bool | Bash 集成 |
| `enableZshIntegration` | bool | Zsh 集成 |
| `settings` | attrsOf anything | 声明式配置，通过 `toLua` 序列化 |
| `extraConfig` | lines | 原始 Lua 代码，返回表会合并到 settings 之上 |
| `colorSchemes` | attrsOf TOML | 颜色方案，写入 `colors/<name>.toml` |

### 生成的 wezterm.lua 结构

```lua
local wezterm = require 'wezterm'
local config = wezterm.config_builder and wezterm.config_builder() or {}
local hm_config = <toLua(settings)>
for k, v in pairs(hm_config) do config[k] = v end
local _hm_extra = (function()
  <extraConfig>
end)()
if type(_hm_extra) == "table" then
  for k, v in pairs(_hm_extra) do config[k] = v end
end
return config
```

### 映射方案

| 原始配置 | Nix 目标 | 说明 |
|---|---|---|
| 颜色方案 (custom.lua) | `colorSchemes.qimocha` | TOML 格式 |
| 字体变量 | Nix `let` 变量 | `fontFamily`, `fontSize` |
| 声明式设置 | `settings` | 通过 toLua 序列化 |
| 事件处理器 | `extraConfig` | 需要 `wezterm.GLOBAL`、回调、nerdfonts |
| 背景轮播 (backdrops) | `extraConfig` | 依赖 `wezterm.GLOBAL` 和文件 I/O |
| 按键绑定 | `extraConfig` | 包含 `wezterm.action_callback` 等回调 |
| Key tables | `extraConfig` | 需要 wezterm.action API |
| 平台检测 | `extraConfig` | 运行时检测 |

### 无法用 settings 声明式表达的特性

1. **BackDrops**: `wezterm.GLOBAL` 状态管理、`io.popen` 文件扫描、`window:set_config_overrides` 动态覆盖
2. **Tab title**: 复杂渲染逻辑、nerdfonts glyphs、6 种变体、自定义事件
3. **状态栏**: 电量图标映射、日期格式化、segment 构建
4. **按键回调**: `wezterm.action_callback(function(w, p) ... end)`、backdrops 方法调用
5. **QuickSelect**: 内嵌 `wezterm.open_with` 回调
6. **new-tab-button**: 右键菜单自定义逻辑

### 关键注意事项

- `settings` 中的动作值（如 `SpawnTab`、`ShowLauncherArgs`）需要 `mkLuaInline` 保持为原始 Lua 表达式
- `extraConfig` 的返回表会**浅合并**到 settings 之上（同名 key 整体替换，不递归合并）
- `colorSchemes` 的 TOML 结构外层需要 `colors` 包裹键
- 原始 `qimocha.toml` 的 foreground (`#d8dfda`) 与 Lua 版本 (`#e8ecf4`) 有细微差异，以 Lua 版本为准
