#!/usr/bin/env bash

set -euo pipefail

log() {
  printf '[bootstrap] %s\n' "$*"
}

fail() {
  printf '[bootstrap] ERROR: %s\n' "$*" >&2
  exit 1
}

current_os() {
  uname -s
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
    "docs/discovery"
    "docs/srs"
    "docs/batches"
    "docs/releases"
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

main() {
  os_name="$(current_os)"
  [ -d "${HOST_ROOT}" ] || fail "Host root not found: ${HOST_ROOT}"

  log "Host root: ${HOST_ROOT}"
  ensure_host_structure

  # Intentionally do not install dependencies in bootstrap.
  # This script only prepares the host directory layout.
  log "${os_name} detected. Skipping Python/Node installation by design."

  report_github_structure

  if command -v python3 >/dev/null 2>&1; then
    log "python3: $(python3 --version 2>&1)"
  else
    log "python3: not found"
  fi

  if command -v node >/dev/null 2>&1; then
    log "node: $(node --version 2>&1)"
  else
    log "node: not found"
  fi

  log "Bootstrap completed successfully."
}

main "$@"
