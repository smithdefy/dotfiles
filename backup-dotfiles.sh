#!/usr/bin/env bash
# =============================================================================
# Cross-platform Dotfiles Backup Script (macOS + Ubuntu/Linux)
# =============================================================================

set -euo pipefail

DOTFILES_DIR="${HOME}/dotfiles"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="${DOTFILES_DIR}/backup_${TIMESTAMP}"

# ----------------------------- CONFIGURATION --------------------------------
declare -a DOTFILES=(
    # Shell
    ".bashrc"
    ".zshrc"
    ".zshenv"
    ".profile"
    ".bash_profile"
    ".inputrc"

    # Editors
    ".vimrc"
    ".config/nvim"
    ".config/helix"

    # Terminal
    ".config/kitty"
    ".config/alacritty"
    ".config/wezterm"
    ".tmux.conf"

    # Git & Tools
    ".gitconfig"
    ".gitignore_global"
    ".config/starship.toml"
    ".config/fish"
    ".config/lazygit"

    # Add your own here...
    ".config/nvim-from-scratch"
    ".config/nvim-kickstart"
    ".config/zsh"
)

# ----------------------------------------------------------------------------

echo "=== Dotfiles Backup ==="
echo "OS Detected: $(uname -s)"
echo "Target: ${DOTFILES_DIR}"

mkdir -p "${DOTFILES_DIR}"

# Prefer rsync, fallback to cp
if command -v rsync >/dev/null 2>&1; then
    COPY_CMD="rsync -a --delete"
    echo "Using rsync for copying"
else
    COPY_CMD="cp -a"
    echo "rsync not found, using cp"
fi

for item in "${DOTFILES[@]}"; do
    src="${HOME}/${item}"
    dest="${DOTFILES_DIR}/${item}"

    if [[ -e "${src}" ]]; then
        echo "Backing up: ${item}"
        mkdir -p "$(dirname "${dest}")"

        if [[ -d "${src}" ]]; then
            # Directory backup
            ${COPY_CMD} "${src}/" "${dest}/" 2>/dev/null || {
                echo "  Warning: Partial copy for ${item}"
                cp -a "${src}/." "${dest}/" 2>/dev/null || true
            }
        else
            # File backup
            cp -a "${src}" "${dest}"
        fi
    else
        echo "⚠️  Not found (skipped): ${item}"
    fi
done

echo "✅ Backup completed in ${DOTFILES_DIR}"
echo "Tip: cd ~/dotfiles && git init && git add ."
