#!/usr/bin/env python3
"""Claude Code status line — powerline-style pill segments.

Layout (chevron-separated pills, matching the reference design):
  [ ~/.claude ] > [ Opus 5 ] > [ 5h 17% ] > [ 7d 14% ] > [ ctx 5% ] > [ (cycle) 16:15 ] >
       blue        surface1     sapphire       mauve       yellow          green

Pill colors are the Catppuccin Mocha palette (https://catppuccin.com/palette),
rendered as 24-bit truecolor so the exact hex values are preserved.
"""

import json
import sys
import os
import time

# ── Powerline glyph & ANSI helpers ──────────────────────────────────────────
CHEVRON = ""   # Nerd Font "right-pointing pill" separator
RESET   = "\033[0m"


def bg(rgb):
    r, g, b = rgb
    return f"\033[48;2;{r};{g};{b}m"


def fg(rgb):
    r, g, b = rgb
    return f"\033[38;2;{r};{g};{b}m"


# ── Segment colors (Catppuccin Mocha, 24-bit RGB) ───────────────────────────
BASE = (30, 30, 46)     # Mocha "Base" — dark pill text
TEXT = (205, 214, 244)  # Mocha "Text" — light pill text

COL_CWD   = ((137, 180, 250), BASE)  # Blue pill,     Base text
COL_MODEL = ((69, 71, 90), TEXT)     # Surface1 pill, Text text
COL_5H    = ((116, 199, 236), BASE)  # Sapphire pill, Base text
COL_7D    = ((203, 166, 247), BASE)  # Mauve pill,    Base text
COL_CTX   = ((249, 226, 175), BASE)  # Yellow pill,   Base text
COL_RESET = ((166, 227, 161), BASE)  # Green pill,    Base text


def fmt_pct_tight(pct):
    if pct is None:
        return "?"
    return f"{int(round(float(pct)))}%"


def model_short(display_name, model_id):
    name = display_name or model_id or "?"
    if name.startswith("Claude "):
        name = name[len("Claude "):]
    return name


CWD_MAX_LEN = 40  # keep the cwd pill from blowing up the whole prompt


def format_cwd(cwd, max_len=CWD_MAX_LEN):
    """Shorten cwd for display, collapsing $HOME to '~' and truncating deep paths.

    Once collapsed the path is short-circuited if it already fits. Otherwise
    intermediate directory components are abbreviated to their first
    character (fish/p10k style), keeping the leaf directory fully readable,
    e.g. '~/projects/foo/bar/baz/qux' -> '~/p/f/b/b/qux'. If that's still too
    long the leaf itself is middle-truncated with an ellipsis.
    """
    if not cwd:
        return None
    home = os.path.expanduser("~")
    if cwd == home:
        return "~"
    if cwd.startswith(home + os.sep):
        display = "~" + cwd[len(home):]
    else:
        display = cwd

    if len(display) <= max_len:
        return display

    prefix = ""
    path = display
    if path.startswith("~/"):
        prefix = "~/"
        path = path[2:]
    elif path.startswith("/"):
        prefix = "/"
        path = path[1:]

    parts = [p for p in path.split("/") if p]
    if not parts:
        return display[:max_len]

    leaf = parts[-1]
    abbreviated = [p[0] for p in parts[:-1]] + [leaf]
    result = prefix + "/".join(abbreviated)

    if len(result) <= max_len:
        return result

    # Still too long (e.g. a very long leaf name) — middle-ellipsize the leaf.
    head_parts = "/".join(abbreviated[:-1])
    fixed_len = len(prefix) + len(head_parts) + (1 if head_parts else 0)
    budget = max(3, max_len - fixed_len)
    if len(leaf) > budget:
        half = (budget - 1) // 2
        leaf = leaf[:half] + "…" + leaf[len(leaf) - (budget - 1 - half):]
    sep = "/" if head_parts else ""
    return prefix + head_parts + sep + leaf


def soonest_reset(*epochs):
    """Return the nearest future reset epoch among the given ones (None-safe)."""
    now = time.time()
    future = [e for e in epochs if e and e > now]
    return min(future) if future else None


def fmt_reset_clock(epoch):
    """Wall-clock local time the window resets at, 24h format, e.g. '16:15'."""
    if not epoch:
        return None
    return time.strftime("%H:%M", time.localtime(int(epoch)))


def build_segments(data):
    cwd = data.get("cwd") or (data.get("workspace") or {}).get("current_dir")
    cwd_disp = format_cwd(cwd)

    ctx = data.get("context_window") or {}
    ctx_pct = ctx.get("used_percentage")

    rate = data.get("rate_limits") or {}
    five = rate.get("five_hour") or {}
    seven = rate.get("seven_day") or {}
    five_pct, five_reset = five.get("used_percentage"), five.get("resets_at")
    seven_pct, seven_reset = seven.get("used_percentage"), seven.get("resets_at")

    model_info = data.get("model") or {}
    model = model_short(model_info.get("display_name"), model_info.get("id"))

    segments = []
    if cwd_disp:
        segments.append((COL_CWD, f" {cwd_disp} "))
    segments.append((COL_MODEL, f" {model} "))

    if five_pct is not None:
        segments.append((COL_5H, f" 5h {fmt_pct_tight(five_pct)} "))
    if seven_pct is not None:
        segments.append((COL_7D, f" 7d {fmt_pct_tight(seven_pct)} "))
    if ctx_pct is not None:
        segments.append((COL_CTX, f" ctx {fmt_pct_tight(ctx_pct)} "))

    reset_epoch = soonest_reset(five_reset, seven_reset)
    reset_clock = fmt_reset_clock(reset_epoch)
    if reset_clock:
        segments.append((COL_RESET, f" ↻ {reset_clock} "))

    return segments


def render(segments):
    out = []
    for i, ((bg_code, fg_code), text) in enumerate(segments):
        out.append(bg(bg_code) + fg(fg_code) + text + RESET)
        next_bg = segments[i + 1][0][0] if i + 1 < len(segments) else None
        if next_bg is not None:
            out.append(fg(bg_code) + bg(next_bg) + CHEVRON + RESET)
        else:
            out.append(fg(bg_code) + CHEVRON + RESET)
    return "".join(out)


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        data = {}

    print(render(build_segments(data)))


if __name__ == "__main__":
    main()
