#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: install.sh [--dry-run] [HOST_ROOT] [POLICY]

Options:
  --dry-run   Show planned changes without modifying files.
  --source-path <path>
              Source path for StagePilot assets: root/.github|base/.github
              (default: root/.github)
  --cleanup-legacy-base
              Remove legacy base/.github directory under host root.
  -h, --help  Show this help message.

Arguments:
  HOST_ROOT   Target host repository root (default: current directory)
  POLICY      Conflict policy for non-copilot files: replace|preserve|fail
              (default: STAGEPILOT_CONFLICT_POLICY or preserve)
EOF
}

log() {
  printf '[install] %s\n' "$*"
}

fail() {
  printf '[install] ERROR: %s\n' "$*" >&2
  exit 1
}

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

DRY_RUN=0
SOURCE_PATH="root/.github"
CLEANUP_LEGACY_BASE=0
ARGS=()
while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    --source-path)
      [ "$#" -ge 2 ] || fail "--source-path requires a value"
      SOURCE_PATH="$2"
      shift
      ;;
    --cleanup-legacy-base)
      CLEANUP_LEGACY_BASE=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --*)
      fail "Unknown option: $1"
      ;;
    *)
      ARGS+=("$1")
      ;;
  esac
  shift
done

HOST_ROOT="${ARGS[0]:-$(pwd)}"
POLICY="${ARGS[1]:-${STAGEPILOT_CONFLICT_POLICY:-preserve}}"
TARGET_GITHUB="${HOST_ROOT}/.github"
STAGEPILOT_BEGIN="<!-- STAGEPILOT:BEGIN -->"
STAGEPILOT_END="<!-- STAGEPILOT:END -->"

case "${SOURCE_PATH}" in
  root/.github)
    SOURCE_GITHUB="${PACKAGE_ROOT}/.github"
    ;;
  base/.github)
    SOURCE_GITHUB="${PACKAGE_ROOT}/base/.github"
    ;;
  *)
    fail "Invalid source path '${SOURCE_PATH}'. Allowed: root/.github|base/.github"
    ;;
esac

ALLOWLIST_FILE="${PACKAGE_ROOT}/bootstrap/source-allowlist.txt"

case "${POLICY}" in
  replace|preserve|fail)
    ;;
  *)
    fail "Invalid conflict policy '${POLICY}'. Allowed: replace|preserve|fail"
    ;;
esac

[ -d "${SOURCE_GITHUB}" ] || fail "Source package not found: ${SOURCE_GITHUB}"
[ -d "${HOST_ROOT}" ] || fail "Host root not found: ${HOST_ROOT}"
[ -f "${ALLOWLIST_FILE}" ] || fail "Allowlist not found: ${ALLOWLIST_FILE}"

is_allowed_relpath() {
  local rel_path="$1"
  while IFS= read -r raw_line; do
    line="${raw_line%%#*}"
    line="${line%$'\r'}"
    line="$(printf '%s' "${line}" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
    [ -n "${line}" ] || continue

    if [[ "${line}" == */ ]]; then
      [[ "${rel_path}" == "${line}"* ]] && return 0
    else
      [[ "${rel_path}" == "${line}" ]] && return 0
    fi
  done < "${ALLOWLIST_FILE}"

  return 1
}

merge_stagepilot_section() {
  local src_file="$1"
  local dst_file="$2"
  local payload_file
  local output_file

  payload_file="$(mktemp)"
  output_file="$(mktemp)"

  # If source already has marker block, use only that block as payload.
  if grep -Fq "${STAGEPILOT_BEGIN}" "${src_file}" && grep -Fq "${STAGEPILOT_END}" "${src_file}"; then
    awk -v begin="${STAGEPILOT_BEGIN}" -v end="${STAGEPILOT_END}" '
      $0 == begin { in_block=1; next }
      $0 == end { in_block=0; exit }
      in_block { print }
    ' "${src_file}" > "${payload_file}"
  else
    cat "${src_file}" > "${payload_file}"
  fi

  if grep -Fq "${STAGEPILOT_BEGIN}" "${dst_file}" && grep -Fq "${STAGEPILOT_END}" "${dst_file}"; then
    awk -v begin="${STAGEPILOT_BEGIN}" -v end="${STAGEPILOT_END}" -v payload="${payload_file}" '
      $0 == begin {
        print
        while ((getline line < payload) > 0) {
          print line
        }
        in_block=1
        next
      }
      $0 == end {
        in_block=0
        print
        next
      }
      !in_block { print }
    ' "${dst_file}" > "${output_file}"
  else
    cat "${dst_file}" > "${output_file}"
    {
      printf '\n'
      printf '## StagePilot\n'
      printf '%s\n' "${STAGEPILOT_BEGIN}"
      cat "${payload_file}"
      printf '%s\n' "${STAGEPILOT_END}"
    } >> "${output_file}"
  fi

  if [ "${DRY_RUN}" -eq 1 ]; then
    log "[dry-run] merge preview: ${dst_file}"
    if command -v diff >/dev/null 2>&1; then
      diff -u "${dst_file}" "${output_file}" || true
    else
      log "[dry-run] diff command not available; preview skipped for ${dst_file}"
    fi
  else
    cp -a "${output_file}" "${dst_file}"
  fi

  rm -f "${payload_file}" "${output_file}"
}

copied=0
skipped=0
conflicted=0
failed=0
merged=0

mkdir -p "${TARGET_GITHUB}"

while IFS= read -r -d '' src_file; do
  rel_path="${src_file#${SOURCE_GITHUB}/}"

  if ! is_allowed_relpath "${rel_path}"; then
    skipped=$((skipped + 1))
    continue
  fi

  dst_file="${TARGET_GITHUB}/${rel_path}"
  dst_dir="$(dirname "${dst_file}")"

  mkdir -p "${dst_dir}"

  if [ ! -e "${dst_file}" ]; then
    if [ "${DRY_RUN}" -eq 1 ]; then
      log "[dry-run] copy: ${rel_path}"
    else
      cp -a "${src_file}" "${dst_file}"
    fi
    copied=$((copied + 1))
    continue
  fi

  if cmp -s "${src_file}" "${dst_file}"; then
    skipped=$((skipped + 1))
    continue
  fi

  if [ "${rel_path}" = "copilot-instructions.md" ]; then
    merge_stagepilot_section "${src_file}" "${dst_file}"
    merged=$((merged + 1))
    continue
  fi

  conflicted=$((conflicted + 1))

  case "${POLICY}" in
    replace)
      if [ "${DRY_RUN}" -eq 1 ]; then
        log "[dry-run] replace: ${rel_path}"
      else
        cp -a "${src_file}" "${dst_file}"
      fi
      copied=$((copied + 1))
      ;;
    preserve)
      skipped=$((skipped + 1))
      ;;
    fail)
      printf '[install] CONFLICT: %s\n' "${dst_file}" >&2
      failed=1
      ;;
  esac

done < <(find "${SOURCE_GITHUB}" -type f -print0 | sort -z)

if [ "${CLEANUP_LEGACY_BASE}" -eq 1 ]; then
  LEGACY_BASE_DIR="${HOST_ROOT}/base/.github"
  if [ -d "${LEGACY_BASE_DIR}" ]; then
    if [ "${DRY_RUN}" -eq 1 ]; then
      log "[dry-run] delete legacy path: ${LEGACY_BASE_DIR}"
    else
      rm -rf "${LEGACY_BASE_DIR}" || fail "LEGACY_BASE_DELETE_ERROR: failed to remove ${LEGACY_BASE_DIR}"
      log "deleted legacy path: ${LEGACY_BASE_DIR}"
    fi
  else
    log "legacy path not found, skip cleanup: ${LEGACY_BASE_DIR}"
  fi
fi

log "host_root=${HOST_ROOT}"
log "source=${SOURCE_GITHUB}"
log "source_path=${SOURCE_PATH}"
log "allowlist=${ALLOWLIST_FILE}"
log "cleanup_legacy_base=${CLEANUP_LEGACY_BASE}"
log "policy=${POLICY}"
log "copied=${copied} skipped=${skipped} conflicted=${conflicted} merged=${merged}"

if [ "${failed}" -ne 0 ]; then
  if [ "${DRY_RUN}" -eq 1 ]; then
    fail "[dry-run] Conflicts would occur with policy=fail."
  fi
  fail "Conflicts encountered with policy=fail. No bootstrap run."
fi

if [ "${DRY_RUN}" -eq 1 ]; then
  log "[dry-run] Bootstrap step skipped. No files were changed."
  exit 0
fi

BOOTSTRAP_SCRIPT="${PACKAGE_ROOT}/bootstrap/bootstrap.sh"
[ -f "${BOOTSTRAP_SCRIPT}" ] || fail "Bootstrap script not found: ${BOOTSTRAP_SCRIPT}"

/bin/bash "${BOOTSTRAP_SCRIPT}" "${HOST_ROOT}"
log "Install completed successfully."
