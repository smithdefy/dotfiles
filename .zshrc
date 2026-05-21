# Created by newuser for 5.9
DISABLE_MAGIC_FUNCTIONS=true
ABBR_SET_EXPANSION_CURSOR=1

# Addtions to PATH
export PATH="$HOME/.atuin/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/kitty.app/bin:$PATH"
export PATH="$HOME/Development/scripts:$PATH"
export PATH="/opt/python3.12/lib/python3.12/site-packages:$PATH"

# Environment Variables
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"

# Core options for speed & usability
setopt autocd extendedglob nomatch notify
setopt histignorealldups histignorespace incappendhistory sharehistory

# Completions
autoload -Uz compinit && compinit

# Plugins (clone or use manager)
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-abbr/zsh-abbr.zsh
# or zsh-autocomplete, zsh-abbr, etc.

# Modern tools
eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"

# Fuzzy Finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fnm
FNM_PATH="/home/nsmith/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell zsh)"
fi

# Use Fast Node Manager to install NodeJS on directory change
eval "$(fnm env --use-on-cd)"

# Starship at the very end
eval "$(starship init zsh)"
