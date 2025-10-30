# Generated from /home/dh/repo/helix/runtime/themes/fleet_dark.toml
# Converted by hx2kak.py

# Palette
declare-option str White "rgb:ffffff"
declare-option str Gray 120 "rgb:d1d1d1"
declare-option str Gray 110 "rgb:c2c2c2"
declare-option str Gray 100 "rgb:a0a0a0"
declare-option str Gray 90 "rgb:898989"
declare-option str Gray 80 "rgb:767676"
declare-option str Gray 70 "rgb:5d5d5d"
declare-option str Gray 60 "rgb:484848"
declare-option str Gray 50 "rgb:383838"
declare-option str Gray 40 "rgb:333333"
declare-option str Gray 30 "rgb:2d2d2d"
declare-option str Gray 20 "rgb:292929"
declare-option str Gray 15 "rgb:1f1f1f"
declare-option str Gray 10 "rgb:181818"
declare-option str Black "rgb:000000"
declare-option str Blue 110 "rgb:6daaf7"
declare-option str Blue 100 "rgb:4d9bf8"
declare-option str Blue 90 "rgb:3691f9"
declare-option str Blue 80 "rgb:1a85f6"
declare-option str Blue 70 "rgb:0273eb"
declare-option str Blue 60 "rgb:0c6ddd"
declare-option str Blue 50 "rgb:195eb5"
declare-option str Blue 40 "rgb:194176"
declare-option str Blue 30 "rgb:163764"
declare-option str Blue 20 "rgb:132c4f"
declare-option str Blue 10 "rgb:0b1b32"
declare-option str Red 80 "rgb:ec7388"
declare-option str Red 70 "rgb:ea4b67"
declare-option str Red 60 "rgb:d93953"
declare-option str Red 50 "rgb:ce364d"
declare-option str Red 40 "rgb:c03248"
declare-option str Red 30 "rgb:a72a3f"
declare-option str Red 20 "rgb:761b2d"
declare-option str Red 10 "rgb:390813"
declare-option str Green 50 "rgb:4ca988"
declare-option str Green 40 "rgb:3ea17f"
declare-option str Green 30 "rgb:028764"
declare-option str Green 20 "rgb:134939"
declare-option str Green 10 "rgb:081f19"
declare-option str Yellow 60 "rgb:f8ab17"
declare-option str Yellow 50 "rgb:e1971b"
declare-option str Yellow 40 "rgb:b5791f"
declare-option str Yellow 30 "rgb:7c511a"
declare-option str Yellow 20 "rgb:5a3a14"
declare-option str Yellow 10 "rgb:281806"
declare-option str Purple 20 "rgb:c07bf3"
declare-option str Purple 10 "rgb:b35def"
declare-option str Blue "rgb:87c3ff"
declare-option str Blue Light "rgb:add1de"
declare-option str Coral "rgb:cc7c8a"
declare-option str Cyan "rgb:82d2ce"
declare-option str Cyan Dark "rgb:779e9e"
declare-option str Lime "rgb:a8cc7c"
declare-option str Orange "rgb:e09b70"
declare-option str Pink "rgb:e394dc"
declare-option str Violet "rgb:af9cff"
declare-option str Yellow "rgb:ebc88d"

# UI
set-face global Default ,rgb:181818
set-face global StatusLine rgb:d1d1d1,rgb:292929
set-face global StatusLineModeNormal rgb:d1d1d1,rgb:292929
set-face global StatusLineInfo rgb:898989
set-face global StatusLineModeInsert rgb:292929,rgb:3691f9
set-face global StatusLineModeSelect rgb:292929,rgb:f8ab17
set-face global PrimaryCursor +r
set-face global MatchingChar ,rgb:163764
set-face global PrimarySelection ,rgb:383838
set-face global ui_selection_primary ,rgb:194176
set-face global ui_cursorline ,rgb:1f1f1f
set-face global LineNumbers rgb:5d5d5d
set-face global LineNumberCursor rgb:c2c2c2
set-face global Information rgb:d1d1d1,rgb:292929
set-face global BufferPadding rgb:383838
set-face global InfoBlock rgb:d1d1d1,rgb:292929
set-face global MenuForeground rgb:d1d1d1,rgb:292929
set-face global MenuBackground rgb:ffffff,rgb:194176
set-face global ui_menu_scroll rgb:dfdfdf
set-face global DefaultText rgb:d1d1d1
set-face global DefaultFocus rgb:ffffff,rgb:194176
set-face global ui_virtual rgb:898989
set-face global ui_virtual_inlay_hint rgb:5d5d5d
set-face global ColumnRuler ,rgb:292929

# Diagnostics
set-face global ts_hint rgb:767676
set-face global ts_info rgb:a366c4
set-face global ts_warning rgb:facb66
set-face global ts_error rgb:ff5269
set-face global DiagnosticHint rgb:767676+u
set-face global DiagnosticInfo rgb:a366c4+u
set-face global DiagnosticWarning rgb:facb66+u
set-face global DiagnosticError rgb:ff5269+u
set-face global ts_comment_unused +d

# Tree-sitter
set-face global ts_attribute rgb:a8cc7c
set-face global ts_type rgb:87c3ff
set-face global ts_type_return rgb:add1de
set-face global ts_type_parameter rgb:add1de
set-face global ts_constructor rgb:ebc88d
set-face global ts_constant rgb:af9cff
set-face global ts_constant_builtin_boolean rgb:82d2ce
set-face global ts_constant_character rgb:ebc88d
set-face global ts_constant_character_escape rgb:82d2ce
set-face global ts_constant_numeric rgb:ebc88d
set-face global ts_string rgb:e394dc
set-face global ts_string_regexp rgb:82d2ce
set-face global ts_string_special rgb:ebc88d+u
set-face global ts_comment rgb:898989
set-face global ts_variable rgb:d1d1d1
set-face global ts_variable_builtin rgb:cc7c8a
set-face global ts_variable_other_member rgb:af9cff
set-face global ts_label rgb:ebc88d
set-face global ts_keyword rgb:82d2ce
set-face global ts_function rgb:ebc88d
set-face global ts_function_declaration rgb:efefef
set-face global ts_function_macro rgb:a8cc7c
set-face global ts_function_builtin rgb:a8cc7c
set-face global ts_function_special rgb:a8cc7c
set-face global ts_tag rgb:87c3ff
set-face global ts_special rgb:a8cc7c
set-face global ts_namespace rgb:87c3ff
set-face global ts_markup_bold +b
set-face global ts_markup_italic +i
set-face global ts_markup_strikethrough +s
set-face global ts_markup_heading rgb:82d2ce+b
set-face global ts_markup_list rgb:e394dc
set-face global ts_markup_list_numbered rgb:82d2ce
set-face global ts_markup_list_unnumbered rgb:82d2ce
set-face global ts_markup_link_url rgb:e394dc+i+u
set-face global ts_markup_link_text rgb:82d2ce
set-face global ts_markup_link_label rgb:c07bf3
set-face global ts_markup_quote rgb:e394dc
set-face global ts_markup_raw rgb:e394dc
set-face global ts_markup_raw_inline rgb:82d2ce
set-face global ts_markup_raw_block rgb:eb83e2
set-face global ts_diff_plus rgb:4ca988
set-face global ts_diff_minus rgb:ce364d
set-face global ts_diff_delta rgb:1a85f6
