#!/bin/bash

# Dotfiles installation script
# Creates symlinks from this repo to the appropriate locations

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR"

# Create backup directory
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

backup_and_link() {
    local src="$1"
    local dest="$2"

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        mkdir -p "$BACKUP_DIR"
        echo "Backing up $dest to $BACKUP_DIR"
        mv "$dest" "$BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -sf "$src" "$dest"
    echo "Linked $src -> $dest"
}

# ZSH
backup_and_link "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# Neovim
backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# Claude
backup_and_link "$DOTFILES_DIR/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
backup_and_link "$DOTFILES_DIR/claude/settings.json" "$HOME/.claude/settings.json"

echo ""
echo "Dotfiles installed successfully!"
echo "If backups were made, they are in: $BACKUP_DIR"
