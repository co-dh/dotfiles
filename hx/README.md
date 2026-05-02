# Helix themes for Kakoune (via tree-sitter)

This directory provides Helix-quality syntax highlighting in Kakoune
using [kak-tree-sitter](https://sr.ht/~hadronized/kak-tree-sitter/).

## Install

### 1. Install kak-tree-sitter

```bash
# Arch
paru -S kak-tree-sitter

# Other distros
cargo install kak-tree-sitter ktsctl
```

### 2. Install tree-sitter grammars & queries

```bash
# Install languages you use (queries come from Helix)
ktsctl sync rust python haskell javascript typescript go lua bash toml json nix markdown

# Or install all supported languages
ktsctl sync -a
```

### 3. Configure Kakoune

Add to `~/.config/kak/kakrc` — **before** your colorscheme:

```
eval %sh{ kak-tree-sitter -dks --init $kak_session }
colorscheme catppuccin_mocha
```

To keep `show-matching` working alongside tree-sitter highlighting:

```
define-command -override tree-sitter-user-after-highlighter %{
  add-highlighter -override buffer/show-matching show-matching
}
```

### 4. Install themes

Copy `.kak` files from this directory to `~/.config/kak/colors/`:

```bash
cp ~/dotfiles/hx/*.kak ~/.config/kak/colors/
```

Restart Kakoune and switch themes with `colorscheme <name>`.

### 5. Interactive theme picker

The `kak-themes` script lets you preview themes live with fzf:

```bash
~/dotfiles/hx/kak-themes
```

Scroll through themes — each selection applies to Kakoune instantly.
Press Enter to keep the current selection.

## Converting new Helix themes

The `helix-theme2kak` script converts Helix TOML themes to kak-tree-sitter
format:

```bash
./helix-theme2kak /usr/lib/helix/runtime/themes/new_theme.toml new_theme.kak
cp new_theme.kak ~/.config/kak/colors/
```

To batch-convert all Helix themes:

```bash
for f in /usr/lib/helix/runtime/themes/*.toml; do
  name=$(basename "$f" .toml)
  ./helix-theme2kak "$f" "$name.kak"
done
```

## Notes

- Queries (highlight rules) come directly from the Helix editor repo
- Theme inheritance (`inherits = "parent"`) is resolved recursively
- Palette names are sanitized to Kakoune-compatible `[a-zA-Z0-9_]` format
- `#RRGGBBAA` hex values are converted to Kakoune's `rgba:` format
- Sub-face cascading is applied automatically (`ts_keyword_control_conditional`
  inherits from `ts_keyword_control` etc.)

## Files

| File | Purpose |
|------|---------|
| `*.kak` | Converted kak-tree-sitter themes (173) |
| `helix-theme2kak` | Converter: Helix TOML → kak-tree-sitter `.kak` |
| `kak-themes` | Interactive fzf theme switcher |
