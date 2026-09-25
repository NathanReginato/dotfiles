#!/usr/bin/env bash
# Injects #{@claude_status} into the window tab formats. Run after the theme
# (tmux-kanagawa rewrites the formats when TPM loads it).
dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
marker='#{?@claude_status, #{@claude_status},}'

for opt in window-status-format window-status-current-format; do
  fmt=$(tmux show -gv "$opt")
  case $fmt in *@claude_status*) continue ;; esac
  # Put the indicator right after the window name
  tmux set -g "$opt" "${fmt/\#W/#W$marker}"
done

# A closed pane can take a Claude with it — recompute that window
tmux set-hook -g 'pane-exited[42]' "run-shell -b '$dir/claude-status.sh refresh #{window_id}'"
tmux set-hook -g 'after-kill-pane[42]' "run-shell -b '$dir/claude-status.sh refresh #{window_id}'"
