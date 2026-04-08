# Quick directory jumper — targets loaded from ~/.tkrc.json
typeset -gA _GO2_TARGETS=()

if [[ -f "$HOME/.tkrc.json" ]] && command -v jq &>/dev/null; then
  while IFS='=' read -r key val; do
    _GO2_TARGETS[$key]="${(e)val}"
  done < <(jq -r '.go2_targets | to_entries[] | "\(.key)=\(.value)"' "$HOME/.tkrc.json")
fi

go2() {
  if [[ -z "$1" ]]; then
    if (( ${#_GO2_TARGETS} == 0 )); then
      echo "go2: no targets configured (check \$TK_LIB_DIR/tkrc.json)" >&2
      return 1
    fi
    echo "Available targets:"
    for key in ${(ko)_GO2_TARGETS}; do
      printf "  %-12s %s\n" "$key" "${_GO2_TARGETS[$key]}"
    done
    return 0
  fi

  local dest="${_GO2_TARGETS[$1]}"
  if [[ -z "$dest" ]]; then
    echo "go2: unknown target '$1'" >&2
    return 1
  fi

  cd "$dest"
}

_go2_complete() {
  local -a targets=(${(k)_GO2_TARGETS})
  _describe 'target' targets
}

compdef _go2_complete go2
