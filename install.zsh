#!/usr/bin/env zsh
set -euo pipefail

LIB_DIR="${0:A:h}"
TEMPLATE="$LIB_DIR/tkrc.json"
TKRC="$HOME/.tkrc.json"
ZSHRC="$HOME/.zshrc"
MARKER_BEGIN="# ============================================================ BEGIN TK_RC"
MARKER_END="# ============================================================ END TK_RC"

if ! command -v jq &>/dev/null; then
  echo "install.zsh: jq is required but not found" >&2
  exit 1
fi

# Scaffold ~/.tkrc.json from template if it doesn't exist
if [[ ! -f "$TKRC" ]]; then
  cp "$TEMPLATE" "$TKRC"
  echo "install.zsh: created $TKRC from template — edit it to configure your machine"
else
  echo "install.zsh: $TKRC already exists, skipping scaffold"
fi

# Build the block to inject into ~/.zshrc
block="$MARKER_BEGIN\n"

# Export env vars from ~/.tkrc.json, expanding ~ to $HOME
while IFS='=' read -r key val; do
  # Normalize ~/  to $HOME/ so the path expands correctly when .zshrc is sourced
  [[ "$val" == "~/"* ]] && val="\$HOME/${val#\~/}"
  block+="export ${key}=\"${val}\"\n"
done < <(jq -r '.env | to_entries[] | "\(.key)=\(.value)"' "$TKRC")

# Source each rc file (paths relative to this repo)
while IFS= read -r relpath; do
  block+="source \"\$TK_LIB_DIR/$relpath\"\n"
done < <(jq -r '.source_files[]' "$TKRC")

block+="$MARKER_END"

# Symlink ~/.vimrc if include_vimrc is true
if jq -e '.include_vimrc == true' "$TKRC" > /dev/null 2>&1; then
  VIMRC_SRC="$LIB_DIR/rc/.vimrc"
  VIMRC_DEST="$HOME/.vimrc"
  if [[ -L "$VIMRC_DEST" && "$(readlink "$VIMRC_DEST")" == "$VIMRC_SRC" ]]; then
    echo "install.zsh: ~/.vimrc symlink already in place, skipping"
  elif [[ -e "$VIMRC_DEST" ]]; then
    mv "$VIMRC_DEST" "${VIMRC_DEST}.bak"
    echo "install.zsh: backed up existing ~/.vimrc to ~/.vimrc.bak"
    ln -s "$VIMRC_SRC" "$VIMRC_DEST"
    echo "install.zsh: symlinked ~/.vimrc -> $VIMRC_SRC"
  else
    ln -s "$VIMRC_SRC" "$VIMRC_DEST"
    echo "install.zsh: symlinked ~/.vimrc -> $VIMRC_SRC"
  fi
fi

# Write or replace block in ~/.zshrc
touch "$ZSHRC"
if grep -q "$MARKER_BEGIN" "$ZSHRC"; then
  awk -v begin="$MARKER_BEGIN" -v end="$MARKER_END" -v replacement="$(printf '%s' "$block")" '
    $0 == begin { print replacement; skip=1; next }
    $0 == end   { skip=0; next }
    !skip
  ' "$ZSHRC" > "${ZSHRC}.tmp" && mv "${ZSHRC}.tmp" "$ZSHRC"
  echo "install.zsh: updated existing TK_RC block in $ZSHRC"
else
  printf "\n%b\n" "$block" >> "$ZSHRC"
  echo "install.zsh: appended TK_RC block to $ZSHRC"
fi
