# Kanagawa Dragon — custom oh-my-zsh theme
# Colors based on https://github.com/rebelot/kanagawa.nvim (dragon variant)

# Dragon palette as zsh color codes (256-color approximations)
# dragonBlue2  #8ba4b0 → 110
# dragonYellow #c4b28a → 180
# dragonGreen  #87a987 → 108
# dragonRed    #c4746e → 167
# dragonAsh    #737c73 → 243
# dragonOrange #b6927b → 174
# dragonViolet #8992a7 → 103
# dragonWhite  #c5c9c5 → 251

# Git prompt styling
ZSH_THEME_GIT_PROMPT_PREFIX="%{$FG[243]%} on %{$FG[103]%}\ue0a0 "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$FG[167]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$FG[108]%}✓"

# Main prompt
# user@host in directory (on branch)
# ❯
PROMPT='
%{$FG[180]%}%n%{$FG[243]%}@%{$FG[110]%}%m %{$FG[243]%}in %{$FG[108]%}%~%{$reset_color%}$(git_prompt_info)
%{$FG[174]%}❯%{$reset_color%} '

# Right prompt — time
RPROMPT='%{$FG[243]%}%*%{$reset_color%}'
