# Wezterm 配置

## 快捷键总结

### 修饰键 (Modifiers)

- **macOS**: `SUPER` = ⌘ (Command), `SUPER_REV` = ⌘ + Ctrl
- **Windows/Linux**: `SUPER` = Alt, `SUPER_REV` = Alt + Ctrl

---

### 通用功能 (Misc)

| 快捷键 | 功能 |
|--------|------|
| Ctrl+F1 | 进入复制模式 (ActivateCopyMode) |
| Ctrl+p | 打开命令面板 (ActivateCommandPalette) |
| Ctrl+F3 | 显示启动器 (ShowLauncher) |
| Ctrl+F4 | 显示标签页启动器 (ShowLauncherArgs - TABS) |
| Ctrl+F5 | 显示工作区启动器 (ShowLauncherArgs - WORKSPACES) |
| Ctrl+F11 | 切换全屏 (ToggleFullScreen) |
| Ctrl+F12 | 显示调试覆盖层 (ShowDebugOverlay) |
| ⌘/Alt+f | 搜索 (Search) |
| ⌘/Alt+u | 选中并打开 URL (QuickSelect - URL) |

---

### 光标移动 (Cursor Movement)

| 快捷键 | 功能 |
|--------|------|
| ⌘/Alt+← | 移动光标到行首 |
| ⌘/Alt+→ | 移动光标到行尾 |
| ⌘/Alt+Backspace | 删除整行 |

---

### 复制粘贴 (Copy/Paste)

| 快捷键 | 功能 |
|--------|------|
| Ctrl+Shift+c | 复制到剪贴板 |
| Ctrl+Insert | 复制到剪贴板 |
| Ctrl+Shift+v | 从剪贴板粘贴 |
| ⌘/Alt+v | 从剪贴板粘贴 |
| Shift+Insert | 从剪贴板粘贴 |

---

### 标签页 (Tabs)

| 快捷键 | 功能 |
|--------|------|
| ⌘/Alt+t | 新建标签页 |
| ⌘/Alt+Ctrl+w | 关闭当前标签页 |
| ⌘/Alt+[ | 切换到上一个标签页 |
| ⌘/Alt+] | 切换到下一个标签页 |
| ⌘/Alt+Ctrl+[ | 向左移动标签页 |
| ⌘/Alt+Ctrl+] | 向右移动标签页 |

---

### 窗口 (Window)

| 快捷键 | 功能 |
|--------|------|
| ⌘/Alt+n | 新建窗口 |

---

### 背景控制 (Background)

| 快捷键 | 功能 |
|--------|------|
| ⌘/Alt+/ | 随机背景 (Random Background) |
| ⌘/Alt+, | 上一个背景 (Previous Background) |
| ⌘/Alt+. | 下一个背景 (Next Background) |
| ⌘/Alt+Ctrl+/ | 选择背景 (Select Background) |

---

### 窗格 (Panes)

| 快捷键 | 功能 |
|--------|------|
| ⌘/Alt+\ | 垂直分割窗格 |
| ⌘/Alt+Ctrl+\ | 水平分割窗格 |
| ⌘/Alt+Enter | 切换窗格缩放状态 |
| ⌘/Alt+w | 关闭当前窗格 |
| ⌘/Alt+Ctrl+k | 激活上方窗格 |
| ⌘/Alt+Ctrl+j | 激活下方窗格 |
| ⌘/Alt+Ctrl+h | 激活左侧窗格 |
| ⌘/Alt+Ctrl+l | 激活右侧窗格 |
| ⌘/Alt+Ctrl+p | 选择窗格 (SwapWithActive) |

---

### 字体大小调整 (Resize Font)

**前缀键**: `Leader` + f (默认: ⌘/Alt+Ctrl+Space, 然后 f)

| 快捷键 | 功能 |
|--------|------|
| k | 增大字体 |
| j | 减小字体 |
| r | 重置字体大小 |
| Esc/q | 退出调整模式 |

---

### 窗格大小调整 (Resize Pane)

**前缀键**: `Leader` + p (默认: ⌘/Alt+Ctrl+Space, 然后 p)

| 快捷键 | 功能 |
|--------|------|
| k | 上移边界 |
| j | 下移边界 |
| h | 左移边界 |
| l | 右移边界 |
| Esc/q | 退出调整模式 |

---

### 鼠标绑定 (Mouse Bindings)

| 鼠标操作 | 功能 |
|----------|------|
| Ctrl+左键点击 | 打开鼠标下的链接 |
| 右键点击 | 粘贴剪贴板内容 |

---

### Leader 键

- **Leader 键**: `⌘/Alt+Ctrl+Space`

---

### 插件依赖

- `backdrops.lua` - 背景管理功能

---

*配置文件: `config/bindings.lua`*
