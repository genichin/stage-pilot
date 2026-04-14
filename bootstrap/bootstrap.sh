#!/usr/bin/env bash

set -euo pipefail

log() {
  printf '[bootstrap] %s\n' "$*"
}

fail() {
  printf '[bootstrap] ERROR: %s\n' "$*" >&2
  exit 1
}

require_linux() {
  if [ "$(uname -s)" != "Linux" ]; then
    fail "This bootstrap script supports Linux only."
  fi
}

HOST_ROOT="${1:-$(pwd)}"

ensure_host_structure() {
  local dirs=(
    ".github"
    ".github/agents"
    ".github/instructions"
    ".github/prompts"
    ".github/runbooks/services"
    ".github/scripts"
    ".github/templates"
    "docs/sdlc/discovery"
    "docs/sdlc/planning"
    "docs/sdlc/design"
    "docs/sdlc/implementation"
    "docs/sdlc/verification"
    "docs/sdlc/release"
    "docs/sdlc/operations"
  )

  for dir in "${dirs[@]}"; do
    mkdir -p "${HOST_ROOT}/${dir}"
  done
}

report_github_structure() {
  log "Host .github structure:"
  if command -v find >/dev/null 2>&1; then
    find "${HOST_ROOT}/.github" -maxdepth 2 -mindepth 1 | sed "s#${HOST_ROOT}/##" | sort
  else
    log "find command not available; skipping structure scan."
  fi
}

has_python_311_or_higher() {
  command -v python3 >/dev/null 2>&1 \
    && python3 -c 'import sys; raise SystemExit(0 if sys.version_info >= (3, 11) else 1)'
}

install_python_311() {
  if has_python_311_or_higher; then
    return 0
  fi
  if command -v apt-get >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1; then
    log "Installing Python 3.11 via apt-get (minimum required: 3.11)."
    sudo apt-get update
    sudo apt-get install -y python3.11
  else
    fail "Python 3.11+ is required. Install it manually or provide apt-get + sudo."
  fi
  has_python_311_or_higher || fail "Python 3.11+ installation check failed."
}

has_node_20() {
  command -v node >/dev/null 2>&1 \
    && node -e 'const [major] = process.versions.node.split(".").map(Number); process.exit(major >= 20 ? 0 : 1);'
}

install_node_20() {
  if has_node_20; then
    return 0
  fi
  if command -v apt-get >/dev/null 2>&1 && command -v sudo >/dev/null 2>&1 && command -v curl >/dev/null 2>&1; then
    log "Installing Node.js 20 LTS via NodeSource (minimum required: v20)."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
  else
    fail "Node.js v20+ is required. Install it manually or provide apt-get + sudo + curl."
  fi
  has_node_20 || fail "Node.js v20+ installation check failed."
}

main() {
  require_linux
  [ -d "${HOST_ROOT}" ] || fail "Host root not found: ${HOST_ROOT}"

  log "Host root: ${HOST_ROOT}"
  ensure_host_structure
  install_python_311
  install_node_20
  report_github_structure
  log "python3: $(python3 --version 2>&1)"
  log "node: $(node --version 2>&1)"
  log "Bootstrap completed successfully."
}

main "$@"
