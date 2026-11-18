#!/bin/zsh
# ~/.config/zsh/env.sh: personal environment, sourced from ~/.zshrc
#
# ── Secrets ─────────────────────────────────────────────────────────────
# Kept in the macOS Keychain, not in this file. One-time setup:
#   security add-generic-password -a "$USER" -s jira-api-token -w
# (it prompts for the token, so it never lands in shell history)
export JIRA_API_TOKEN="$(security find-generic-password -a "$USER" -s jira-api-token -w 2>/dev/null)"

# ── PATH ────────────────────────────────────────────────────────────────
typeset -U path                       # drop duplicates, keep first occurrence
sys_paths=(/opt/local/bin /opt/local/sbin /opt/homebrew/opt/python@3.11/libexec/bin)
user_paths=("$HOME/Development/scripts" "$HOME/.rd/bin")
# (N-/) silently skips any directory that doesn't exist
# SYS:PATH:USER
path=(${^sys_paths}(N-/) $path ${^user_paths}(N-/))
export PATH

# ── General ─────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=nvim
export PAGER=less
export LESS='-R -F -i'                # colours, quit if one screen, smart case
export CLICOLOR=1                     # coloured BSD ls
export USER_NAME="newuser"
# ── Project locations ───────────────────────────────────────────────────
export DEV=~/Development
export PROJECTS=$DEV/projects
export PV=$PROJECTS/provision-plus-master
hash -d pv=$PV                        # lets you type  ~pv/server  anywhere

# ── Functions ───────────────────────────────────────────────────────────
f()    { find . -iname "*$1*" "${@:2}"; }            # find files by name
r()    { grep -R --color=auto -n "$1" "${@:2}" .; }  # grep recursively
mkcd() { mkdir -p -- "$1" && cd -- "$1"; }
sizeAndSort() { du -kh -d 1 "${@:-.}" | sort -h; }
# rm -rf with guard rails: refuses empty args, /, ~ and the current dir
removeDir() {
    local d
    for d in "$@"; do
        case "${d:A}" in
            ""|/|"$HOME"|"$PWD") print -u2 "removeDir: refusing to remove '$d'"; return 1 ;;
        esac
    done
    (( $# )) || { print -u2 "usage: removeDir DIR..."; return 1; }
    rm -rfv -- "$@"
}
goToProject() { cd "$PROJECTS/${1:-}"; }
_goToProject() { _files -W "$PROJECTS" -/; }   # tab-completes project folders

# ── Aliases: general ────────────────────────────────────────────────────
alias l='ls -1A'
alias ll='ls -lh'
alias lt='ll -tr'
alias lz='lt -A'
alias rmd=removeDir
alias size=sizeAndSort
alias reloadsh='exec zsh'             # fresh shell; cleaner than re-sourcing

# ── PV+ dev commands ────────────────────────────────────────────────────
alias nr='npm run'
alias nrin='npm --prefix "$PV" run install'
alias nrbl='npm --prefix "$PV" run build.lib'
alias nrsr='npm --prefix "$PV/client-v2" run serve'
alias nrst='npm --prefix "$PV/server" run start'
alias nrtw='npm --prefix "$PV/server" run tsc:watch'
alias nrt1='npm --prefix "$PV/server" run test:unit'
alias nrt2='npm --prefix "$PV/server" run v2:test'
alias pvst='(cd "$PV/server" && npx gulp nodemon)'   # subshell: you stay where you were
alias sc='check-all.sh'

# ── Git ─────────────────────────────────────────────────────────────────
alias bU='git fetch origin --recurse-submodules=yes --progress --prune'
alias mU='git fetch origin master:master --recurse-submodules=yes --progress --prune'
alias mR='git rebase origin/master'

# ── Config files ────────────────────────────────────────────────────────
alias editenv='$EDITOR ~/.config/zsh/env.sh'
alias editkitty='$EDITOR ~/.config/kitty/kitty.conf'
alias editwm='$EDITOR ~/.aerospace.toml'
alias editzsh='$EDITOR ~/.zshrc'
alias editnvimfs='$EDITOR ~/.config/nvim-from-scratch/'
alias editnvimks='$EDITOR ~/.config/nvim-kickstart/'

# ── Neovim ──────────────────────────────────────────────────────────────
alias nvimks='NVIM_APPNAME=nvim-kickstart nvim'
alias nvimfs='NVIM_APPNAME=nvim-from-scratch nvim'
alias nvim-update='nvim --headless "+Lazy! sync" "+MasonUpdate" +qa'
alias nvimks-update='NVIM_APPNAME=nvim-kickstart nvim --headless "+Lazy! sync" +qa'
alias nvimfs-update='NVIM_APPNAME=nvim-from-scratch nvim --headless "+Lazy! sync" +qa'
nvim-update-all() {
    local app
    for app in nvim nvim-kickstart nvim-from-scratch; do
        print -P "%F{cyan}==> $app%f"
        NVIM_APPNAME=$app nvim --headless "+Lazy! sync" +qa
    done
}

# ── Services ────────────────────────────────────────────────────────────
alias mongostart='launchctl start org.mongodb.mongod'
alias mongostop='launchctl stop org.mongodb.mongod'
alias mongostatus='launchctl list | grep -i mongod || echo "mongod not loaded"'
alias redisstart='sudo port load redis'
alias redisstop='sudo port unload redis'
alias redisstatus='sudo launchctl list | grep -i redis || echo "redis not loaded"'

# ── Kitty ───────────────────────────────────────────────────────────────
if [[ $TERM == xterm-kitty ]]; then
    alias icat='kitten icat'            # show images in the terminal
    alias kdiff='kitten diff'           # side-by-side diff with syntax colour
    alias s='kitten ssh'                # ssh that copies kitty's terminfo across
fi

# ── Directory jumps ─────────────────────────────────────────────────────
alias config='cd ~/.config'
alias scripts='cd $DEV/scripts'
alias dev=goToProject
alias pvd='cd /data'
alias pvm='cd $PV'
alias pvc='cd $PV/client'
alias pvc2='cd $PV/client-v2'
alias pvl='cd $PV/lib'
alias pvs='cd $PV/server'

# Completion for goToProject/dev (needs compinit to have run in .zshrc first)
(( $+functions[compdef] )) && compdef _goToProject goToProject

