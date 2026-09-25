#!/usr/bin/env bash
# Tracks Claude Code state per tmux pane and rolls it up onto the window tab.
#   claude-status.sh <working|waiting|done|clear>   — called from Claude Code hooks
#   claude-status.sh refresh <window-id>            — recompute a window (tmux hooks)

# Hooks pipe JSON on stdin; drain it so Claude never blocks on us
[ -t 0 ] || cat >/dev/null

state=$1

if [ "$state" = refresh ]; then
  win=$2
else
  [ -n "$TMUX_PANE" ] || exit 0
  if [ "$state" = clear ]; then
    tmux set -pu -t "$TMUX_PANE" @claude_state 2>/dev/null
  else
    tmux set -p -t "$TMUX_PANE" @claude_state "$state" 2>/dev/null
  fi
  win=$(tmux display -p -t "$TMUX_PANE" '#{window_id}' 2>/dev/null)
fi
[ -n "$win" ] || exit 0

# Most urgent pane wins: waiting > working > done
states=$(tmux list-panes -t "$win" -F '#{@claude_state}' 2>/dev/null)
case $states in
  *waiting*) status='#[fg=#c4746e]▲' ;;  # needs you — permission/input
  *working*) status='#[fg=#c4b28a]●' ;;  # busy
  *done*)    status='#[fg=#8a9a7b]✓' ;;  # finished its turn
  *)         status='' ;;
esac

if [ -n "$status" ]; then
  tmux set -w -t "$win" @claude_status "$status" 2>/dev/null
else
  tmux set -wu -t "$win" @claude_status 2>/dev/null
fi
exit 0
