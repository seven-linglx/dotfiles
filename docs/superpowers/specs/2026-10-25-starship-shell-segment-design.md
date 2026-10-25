# Starship shell 填充色块设计

日期：2026-10-25
状态：已批准

## 背景

`starship.toml` 中 `[shell]` 模块是唯一使用 ANSI 样式 `cyan bold`、且没有背景填充的模块。`$shell` 当前位于 powerline 收尾箭头之后，视觉上孤立。其余模块均采用 `bg:<调色板色> fg:crust` 的填充块风格。

## 目标

让 shell 段成为与其它区域一致的填充色块：

- 使用 `catppuccin_mocha` 调色板的 `mauve` 作为独立色块；
- 位于 `conda`（sapphire）与 `time`（lavender）之间；
- `time` 保持最右侧，收尾箭头不变。

## 设计

### format

将 sapphire → lavender 的直接过渡改为 sapphire → mauve → lavender，并把 `$shell` 移入新块：

```toml
$conda\
[](fg:sapphire bg:mauve)\
$shell\
[](fg:mauve bg:lavender)\
$time\
[ ](fg:lavender)\
$cmd_duration\
$line_break\
$character"""
```

`format` 中其余内容不变。同时删除收尾箭头之后原有的 `$shell`。`$cmd_duration` 保持原位（仍为 `disabled = true`）。

### [shell]

```toml
[shell]
disabled = false
bash_indicator = "🐚bash"
zsh_indicator = "💻zsh"
fish_indicator = "🐟fish"
pwsh_indicator = "🖥️pwsh"
style = "bg:mauve fg:crust"
format = '[ $indicator ]($style)'
```

- `bg:mauve fg:crust` 与其它模块的配色规则一致；
- 新增 `format` 提供左右内边距；各 indicator 去掉末尾空格，避免双空格。

## 非目标

- 不调整 `cmd_duration` 的启用状态或位置；
- 不更换 indicator 的表情符号；
- 不改动其它模块。

## 验证

1. 在 zsh 下运行 `starship prompt`，无配置报错；
2. 渲染顺序为 `conda(sapphire) → 💻zsh(mauve) → time(lavender) → 收尾箭头`；
3. `starship module shell` 的输出带有 mauve 背景，且左右各有空格。
