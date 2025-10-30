#!/usr/bin/env python3
from __future__ import annotations

import argparse
from collections import OrderedDict
from dataclasses import dataclass
from pathlib import Path

THEME_SUFFIX = ".toml"

try:
    import tomllib
except ModuleNotFoundError:  # pragma: no cover
    import tomli as tomllib  # type: ignore

MODIFIERS = {
    "bold": "+b",
    "italic": "+i",
    "dim": "+d",
    "underlined": "+u",
    "underline": "+u",
    "crossed_out": "+s",
    "strikethrough": "+s",
    "reversed": "+r",
}

FACE_ALIASES = {
    "ui.background": "Default",
    "ui.text": "DefaultText",
    "ui.text.focus": "DefaultFocus",
    "ui.text.info": "InformationText",
    "ui.cursor": "PrimaryCursor",
    "ui.cursor.primary": "SecondaryCursor",
    "ui.cursor.match": "MatchingChar",
    "ui.selection": "PrimarySelection",
    "ui.linenr": "LineNumbers",
    "ui.linenr.selected": "LineNumberCursor",
    "ui.cursorline.primary": "LineHighlight",
    "ui.statusline": "StatusLine",
    "ui.statusline.inactive": "StatusLineInfo",
    "ui.statusline.normal": "StatusLineModeNormal",
    "ui.statusline.insert": "StatusLineModeInsert",
    "ui.statusline.select": "StatusLineModeSelect",
    "ui.menu": "MenuForeground",
    "ui.menu.selected": "MenuBackground",
    "ui.popup": "Information",
    "ui.popup.info": "MenuInfo",
    "ui.help": "InfoBlock",
    "ui.window": "BufferPadding",
    "ui.gutter": "Gutter",
    "ui.virtual.ruler": "ColumnRuler",
    "ui.virtual.whitespace": "Whitespace",
    "warning": "ts_warning",
    "error": "ts_error",
    "info": "ts_info",
    "hint": "ts_hint",
    "diagnostic.warning": "DiagnosticWarning",
    "diagnostic.error": "DiagnosticError",
    "diagnostic.info": "DiagnosticInfo",
    "diagnostic.hint": "DiagnosticHint",
    "diagnostic.unnecessary": "ts_comment_unused",
    "diagnostic.deprecated": "ts_markup_strikethrough",
    "diff.plus": "ts_diff_plus",
    "diff.minus": "ts_diff_minus",
    "diff.delta": "ts_diff_delta",
    "diff.delta.moved": "ts_diff_delta_moved",
}

DIAG_KEYS = {"warning", "error", "info", "hint"}


@dataclass
class FaceStyle:
    fg: str | None
    bg: str | None
    modifiers: list[str]

    def kak_spec(self) -> str:
        spec = ""
        if self.fg:
            spec = self.fg
        if self.bg:
            if spec:
                spec = f"{spec},{self.bg}"
            else:
                spec = f",{self.bg}"
        if self.modifiers:
            spec = f"{spec}{''.join(self.modifiers)}"
        return spec or '""'


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Convert Helix TOML theme to Kakoune faces."
    )
    parser.add_argument("theme", type=Path, help="Helix theme TOML file")
    parser.add_argument(
        "-o",
        "--output",
        type=Path,
        help="Output Kakoune script (*.kak); defaults to /tmp/<name>.kak",
    )
    return parser.parse_args()


def load_theme(path: Path, seen: set[Path] | None = None) -> tuple[OrderedDict[str, str], OrderedDict[str, dict]]:
    if seen is None:
        seen = set()
    if path in seen:
        raise ValueError(f"Cyclic inheritance detected at {path}")
    seen.add(path)

    with path.open("rb") as fh:
        raw = tomllib.load(fh)

    inherits = raw.pop("inherits", None)
    palette: OrderedDict[str, str] = OrderedDict()
    styles: OrderedDict[str, dict] = OrderedDict()

    if inherits:
        inherit_name = inherits if inherits.endswith(THEME_SUFFIX) else f"{inherits}{THEME_SUFFIX}"
        base_path = path.parent / inherit_name
        parent_palette, parent_styles = load_theme(base_path.resolve(), seen)
        palette.update(parent_palette)
        styles.update(parent_styles)

    local_palette = raw.pop("palette", {})
    palette.update(OrderedDict(local_palette))

    for key, value in raw.items():
        if isinstance(value, dict):
            styles[key] = value
        else:
            styles[key] = value  # allow aliasing/list forms if present

    return palette, styles


def hex_to_rgb(color: str) -> str:
    value = color.strip().lstrip("#").lower()
    if len(value) == 3:
        value = "".join(ch * 2 for ch in value)
    elif len(value) == 4:
        value = "".join(ch * 2 for ch in value)
    elif len(value) == 7:
        value = value + value[-1]
    elif len(value) not in (6, 8):
        if len(value) < 6:
            value = value.ljust(6, value[-1] if value else "0")
        elif len(value) not in (6, 8):
            value = value[:8]

    if len(value) == 6:
        return f"rgb:{value}"
    if len(value) == 8:
        return f"rgba:{value}"
    raise ValueError(f"Unsupported color value: {color}")


def resolve_color(value: str | None, palette: dict[str, str], depth: int = 0) -> str | None:
    if not value:
        return None

    if depth > len(palette) + 5:
        raise ValueError(f"Color resolution recursion depth exceeded for '{value}'")

    ref = palette.get(value, value)
    if isinstance(ref, str):
        clean = ref.strip()
        if not clean:
            return None
        if clean in palette and clean != value:
            return resolve_color(clean, palette, depth + 1)
        lower = clean.lower()
        if lower == "transparent":
            return "rgba:00000000"
        if lower == "default":
            return "default"
        if lower.startswith("#"):
            try:
                return hex_to_rgb(lower)
            except ValueError:
                return clean
        if lower.startswith("rgb"):
            return clean
        if lower.startswith("hsl"):
            return clean
        return clean
    return str(ref)


def to_face_name(key: str) -> str:
    if key in FACE_ALIASES:
        return FACE_ALIASES[key]
    clean = (
        key.replace(".", "_")
        .replace("-", "_")
        .replace("/", "_")
        .replace(" ", "_")
    )
    if clean.startswith("ui_"):
        return clean
    if clean.startswith("ts_"):
        return clean
    if clean.startswith("diagnostic_"):
        return f"ts_{clean}"
    if clean.startswith("markup_"):
        return f"ts_{clean}"
    if clean.startswith("diff_"):
        return f"ts_{clean}"
    if clean in {"type", "constructor", "constant", "string", "comment", "variable",
                 "keyword", "function", "tag", "namespace", "special", "module",
                 "attribute", "operator", "label", "punctuation"}:
        return f"ts_{clean}"
    if clean in DIAG_KEYS:
        return f"ts_{clean}"
    return f"ts_{clean}"


def extract_style(raw: dict, palette: dict[str, str]) -> FaceStyle:
    fg = resolve_color(raw.get("fg"), palette)
    bg = resolve_color(raw.get("bg"), palette)
    modifiers = []
    for item in raw.get("modifiers", []):
        mapped = MODIFIERS.get(item)
        if mapped and mapped not in modifiers:
            modifiers.append(mapped)
    underline = raw.get("underline")
    if isinstance(underline, dict):
        if "+u" not in modifiers:
            modifiers.append("+u")
        color = underline.get("color")
        if color and not fg:
            fg = resolve_color(color, palette)
    return FaceStyle(fg=fg, bg=bg, modifiers=modifiers)


def classify_group(key: str) -> str:
    if key.startswith("ui."):
        return "UI"
    if key.startswith("diagnostic") or key in DIAG_KEYS:
        return "Diagnostics"
    return "Tree-sitter"


def write_kakoune(
    palette: dict[str, str],
    faces: OrderedDict[str, tuple[str, FaceStyle]],
    output: Path,
    source: Path,
) -> None:
    lines: list[str] = []
    lines.append(f"# Generated from {source}")
    lines.append("# Converted by hx2kak.py")
    lines.append("")
    lines.append("# Palette")
    for name, color in palette.items():
        resolved = resolve_color(color, palette)
        if not resolved:
            continue
        lines.append(f'declare-option str {name} "{resolved}"')
    lines.append("")
    groups: OrderedDict[str, list[str]] = OrderedDict(
        [("UI", []), ("Diagnostics", []), ("Tree-sitter", [])]
    )
    for face_name, (group, style) in faces.items():
        spec = style.kak_spec()
        groups.setdefault(group, [])
        groups[group].append(f'set-face global {face_name} {spec}')
    for group, group_lines in groups.items():
        if not group_lines:
            continue
        lines.append(f"# {group}")
        lines.extend(group_lines)
        lines.append("")
    output.write_text("\n".join(lines).rstrip() + "\n")


def main() -> None:
    args = parse_args()
    theme_path = args.theme.resolve()
    palette, styles = load_theme(theme_path)
    faces: OrderedDict[str, tuple[str, FaceStyle]] = OrderedDict()
    for key, raw in styles.items():
        if isinstance(raw, str):
            raw = {"fg": raw}
        elif isinstance(raw, list):
            continue
        elif not isinstance(raw, dict):
            continue
        group = classify_group(key)
        face_name = to_face_name(key)
        style = extract_style(raw, palette)
        if face_name in faces:
            existing_group, _ = faces[face_name]
            group = existing_group
        faces[face_name] = (group, style)
    out_path = (
        args.output.resolve()
        if args.output
        else Path("/tmp") / f"{theme_path.stem}.kak"
    )
    write_kakoune(palette, faces, out_path, theme_path)


if __name__ == "__main__":
    main()
