# Generated from /home/dh/repo/helix/runtime/themes/acme.toml
# Converted by hx2kak.py

# Palette
declare-option str white "rgb:ffffff"
declare-option str acme_bg "rgb:ffffea"
declare-option str black "rgb:000000"
declare-option str selected "rgb:eeee9e"
declare-option str acme_bar_bg "rgb:aeeeee"
declare-option str acme_bar_inactive "rgb:eaffff"
declare-option str cursor "rgb:444444"
declare-option str red "rgb:a0342f"
declare-option str green "rgb:065905"
declare-option str indent "rgb:aaaaaa"
declare-option str orange "rgb:f0ad4e"
declare-option str gray "rgb:777777"

# UI
set-face global Default ,rgb:ffffea
set-face global DefaultText rgb:000000
set-face global LineNumbers rgb:000000,rgb:ffffea
set-face global LineNumberCursor rgb:000000,rgb:ffffea
set-face global PrimarySelection ,rgb:eeee9e
set-face global ui_cursorline ,rgb:aeeeee
set-face global StatusLine rgb:000000,rgb:aeeeee
set-face global StatusLineInfo rgb:000000,rgb:eaffff
set-face global ui_virtual rgb:aaaaaa
set-face global ColumnRuler ,rgb:aeeeee
set-face global MatchingChar ,rgb:aeeeee
set-face global PrimaryCursor rgb:ffffff,rgb:444444
set-face global ui_debug rgb:f0ad4e
set-face global ui_highlight_frameline ,rgb:da8581
set-face global InfoBlock rgb:000000,rgb:ffffea
set-face global Information rgb:000000,rgb:ffffea
set-face global MenuForeground rgb:000000,rgb:ffffea
set-face global MenuBackground ,rgb:eeee9e
set-face global BufferPadding ,rgb:ffffea
set-face global ui_bufferline rgb:000000,rgb:aeeeee
set-face global ui_bufferline_active rgb:000000,rgb:ffffea

# Diagnostics
set-face global DiagnosticError rgb:ffffff,rgb:a0342f+b
set-face global DiagnosticWarning rgb:000000,rgb:f0ad4e+b
set-face global DiagnosticHint rgb:777777+b
set-face global ts_comment_unused +d
set-face global ts_markup_strikethrough +s

# Tree-sitter
set-face global ts_string rgb:a0342f
set-face global ts_comment rgb:065905
set-face global ts_diff_plus rgb:065905
set-face global ts_diff_delta rgb:aeeeee
set-face global ts_diff_minus rgb:a0342f
