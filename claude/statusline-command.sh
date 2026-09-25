#!/usr/bin/env bash
# Claude Code status line — mirrors a p10k-style prompt feel
# Receives JSON on stdin from Claude Code

input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
# Abbreviate home directory as ~
cwd="${cwd/#$HOME/\~}"

model=$(echo "$input" | jq -r '.model.display_name // ""')

# Effort level — prefer what Claude Code sends, then env, then settings
# (per-model modelSettings override beats the top-level effortLevel)
effort=$(echo "$input" | jq -r '.effort.level // .effort_level // (.effort | strings) // empty')
[ -z "$effort" ] && effort="${CLAUDE_CODE_EFFORT_LEVEL:-}"
if [ -z "$effort" ]; then
  model_id=$(echo "$input" | jq -r '.model.id // ""' | sed 's/\[.*\]$//')
  proj_dir=$(echo "$input" | jq -r '.workspace.project_dir // .workspace.current_dir // .cwd // ""')
  for f in "$proj_dir/.claude/settings.local.json" "$proj_dir/.claude/settings.json" "$HOME/.claude/settings.json"; do
    [ -f "$f" ] || continue
    effort=$(jq -r --arg m "$model_id" '.modelSettings[$m].effortLevel // .effortLevel // empty' "$f" 2>/dev/null)
    [ -n "$effort" ] && break
  done
fi

# Context window usage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Git branch — skip optional locks so we never block the prompt
branch=""
raw_cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
if [ -n "$raw_cwd" ] && [ -d "$raw_cwd" ]; then
  branch=$(git -C "$raw_cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
fi

# Build the status line using ANSI colors
# Kanagawa-inspired palette via 256-color codes
reset="\033[0m"
bold="\033[1m"
col_user="\033[38;5;108m"   # dragonGreen
col_host="\033[38;5;108m"   # dragonGreen
col_cwd="\033[38;5;110m"    # dragonBlue
col_branch="\033[38;5;180m" # dragonYellow
col_model="\033[38;5;139m"  # dragonPink
col_ctx="\033[38;5;109m"    # dragonAqua
col_effort="\033[38;5;173m" # dragonOrange
col_dim="\033[38;5;244m"    # dragonGray3

line=""
line+="${col_user}${bold}${user}${reset}"
line+="${col_dim}@${reset}"
line+="${col_host}${host}${reset}"
line+="${col_dim} in ${reset}"
line+="${col_cwd}${cwd}${reset}"

if [ -n "$branch" ]; then
  line+="${col_dim} on ${reset}"
  line+="${col_branch}${branch}${reset}"
fi

line+="${col_dim} | ${reset}"
line+="${col_model}${model}${reset}"

if [ -n "$effort" ]; then
  line+="${col_dim} effort:${reset}"
  line+="${col_effort}${effort}${reset}"
fi

if [ -n "$used_pct" ]; then
  used_int=$(printf "%.0f" "$used_pct")
  line+="${col_dim} ctx:${reset}"
  line+="${col_ctx}${used_int}%${reset}"
fi

printf "%b" "$line"
