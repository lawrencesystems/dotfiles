#!/bin/bash
set -euo pipefail

# Find all dot files then if the original file exists, create a backup
# Once backed up to {file}.dtbak symlink the new dotfile in place
# Use absolute path to prevent path traversal vulnerabilities
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    if [ -e ~/$filename ]; then
        mv -f ~/$filename{,.dtbak}
    fi
    ln -s "$SCRIPT_DIR/$filename" ~/$filename
done < <(find "$SCRIPT_DIR" -maxdepth 1 -name ".*" -type f -print0)

# Install vim-addons ZSH and ZSH extras
echo "installing extras"

if ! sudo apt update; then
    echo "Error: Failed to update package lists. Do you have sudo privileges?" >&2
    exit 1
fi

if ! sudo apt -y install vim-scripts zsh zsh-syntax-highlighting zsh-autosuggestions; then
    echo "Error: Failed to install packages" >&2
    exit 1
fi

echo "Installed"
echo "use chsh -s /bin/zsh to switch to ZSH shell"
