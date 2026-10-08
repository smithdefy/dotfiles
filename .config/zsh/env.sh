#!/bin/zsh

# Company Jira API Token
export JIRA_API_TOKEN="ATATT3xFfGF0vAn7N8B-l5mVcB5va5iUWnoJzmQ6JDONIFMkVmRRLC3fP5XXTkxJ6h7BjbT3H_hS5xhCcH1b4RfyWBWWMgdaF7t4l2Aq2vFGKyBApUIQ6IdGNyN85J5wgTf0HRftj0xiiCa3Fc4Mu0S4paMz9xDpN39eAop9rAvR3GR8XymrTPs=C7389ACB"

# System Paths 
sys_paths=("/opt/homebrew/opt/python@3.11/libexec/bin")

# User Paths
user_paths=("$HOME/Development/scripts" "$HOME/.rd/bin")

path+=($sys_paths $user_paths)

# Set PATH with ordering: SYS:PATH:USER
#export PATH=$(dedup "$(join SYS_PATHS[@]):$PATH:$(join USER_PATHS[@])")

export EDITOR='nvim'

# Owner
export USER_NAME="newuser"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# remove directory
function removeDir() { rm -fvr "$1" }

# size of contents in dir and sort
function sizeAndSort() { du -kh -d 1 "$@" | sort -h }

function goToProject() {
    if [ -z $1 ]
    then
        cd ~/Development/projects
    else
        cd ~/Development/projects/$1
    fi
}

function goToMaster() {
    goToProject 'provision-plus-master'
}

function goToClient() {
    goToProject 'provision-plus-master/client'
}

function goToClientV2() {
    goToProject 'provision-plus-master/client-v2'
}

function goToLib() {
    goToProject 'provision-plus-master/lib'
}

function goToServer() {
    goToProject 'provision-plus-master/server'
}

function goToData() {
    cd /data
}

# 
# Aliases
#

#General
alias l='ls -1A'
alias ll='ls -lh'
alias lt='ll -tr'
alias lz='lt -A'
alias oldbrew=/usr/local/bin/brew
alias rmd=removeDir
alias size=sizeAndSort

# PV+ dev commands
alias nr='npm run' 
alias nrin='npm --prefix ~/Development/projects/provision-plus-master run install'
alias nrbl='npm --prefix ~/Development/projects/provision-plus-master run build.lib'
alias nrsr='npm --prefix ~/Development/projects/provision-plus-master/client-v2 run serve'
alias nrst='npm --prefix ~/Development/projects/provision-plus-master/server run start'
alias nrtw='npm --prefix ~/Development/projects/provision-plus-master/server run tsc:watch'
alias nrt1='npm --prefix ~/Development/projects/provision-plus-master/server run test:unit'
alias nrt2='npm --prefix ~/Development/projects/provision-plus-master/server run v2:test'
alias pvst='cd ~/Development/projects/provision-plus-master/server && npx gulp nodemon'
alias sc='check-all.sh' 

# Git
alias bU='git fetch origin --recurse-submodules=yes --progress --prune'
alias mU='git fetch origin master:master --recurse-submodules=yes --progress --prune'
alias mR='git rebase origin/master'

# Config 
alias editenv="nvim ~/.config/zsh/env.sh"
alias editkitty="nvim ~/.config/kitty/kitty.conf"
alias editwm="nvim ~/.aerospace.toml"
alias editzsh="nvim ~/.zshrc"
alias editnvimfs="nvim ~/.config/nvim-from-scratch/."
alias editnvimks="nvim ~/.config/nvim-kickstart/."

# Neovim
alias nvim-update='nvim --headless "+Lazy! sync" +qa'
alias nvimks='NVIM_APPNAME="nvim-kickstart" nvim'
alias nvimks-update='nvimks --headless "+Lazy! sync" +qa'
alias nvimfs='NVIM_APPNAME="nvim-from-scratch" nvim'
alias nvimfs-update='nvimfs --headless "+Lazy! sync" +qa'

# Services
alias mongostart='launchctl start org.mongodb.mongod'
alias mongostop='launchctl stop org.mongodb.mongod'
alias redisstart='brew services start redis'
alias redisstop='brew services stop redis'
alias redisstatus='brew services list | grep redis'

# Reload shell environment
alias reloadsh="source ~/.zshrc"

# 
# Directory aliases 
#
alias config='cd ~/.config'
alias scripts='cd ~/Development/scripts'
alias dev=goToProject
alias pvd=goToData
alias pvm=goToMaster
alias pvc=goToClient
alias pvc2=goToClientV2
alias pvl=goToLib
alias pvs=goToServer

