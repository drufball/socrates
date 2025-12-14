#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

log() {
  printf "[install_deps] %s\n" "$*"
}

die() {
  printf "[install_deps] ERROR: %s\n" "$*" >&2
  exit 1
}

need_cmd() {
  command -v "$1" >/dev/null 2>&1 || die "Missing required command: $1"
}

usage() {
  cat <<'EOF'
Usage: install_deps.sh [--backend] [--frontend]

Defaults to installing both backend (uv) and frontend (npm) deps.

Options:
  --backend   Install only backend deps (uv sync --dev)
  --frontend  Install only frontend deps (npm ci / npm install)
EOF
}

main() {
  local do_backend=1
  local do_frontend=1

  if [[ $# -gt 0 ]]; then
    do_backend=0
    do_frontend=0
    while [[ $# -gt 0 ]]; do
      case "$1" in
        --backend) do_backend=1 ;;
        --frontend) do_frontend=1 ;;
        -h|--help)
          usage
          exit 0
          ;;
        *)
          usage >&2
          die "Unknown argument: $1"
          ;;
      esac
      shift
    done
  fi

  log "Repo root: ${ROOT_DIR}"

  if [[ "${do_backend}" -eq 1 ]]; then
    need_cmd uv
    if [[ ! -f "${ROOT_DIR}/backend/pyproject.toml" || ! -f "${ROOT_DIR}/backend/uv.lock" ]]; then
      die "Expected backend/pyproject.toml and backend/uv.lock to exist"
    fi
    log "Installing backend deps (uv sync --dev)"
    (cd "${ROOT_DIR}/backend" && uv sync --dev)
  fi

  if [[ "${do_frontend}" -eq 1 ]]; then
    need_cmd npm
    if [[ ! -f "${ROOT_DIR}/frontend/package.json" ]]; then
      die "Expected frontend/package.json to exist"
    fi

    if [[ -f "${ROOT_DIR}/frontend/package-lock.json" ]]; then
      log "Installing frontend deps (npm ci)"
      (cd "${ROOT_DIR}/frontend" && npm ci)
    else
      log "Installing frontend deps (npm install)"
      (cd "${ROOT_DIR}/frontend" && npm install)
    fi
  fi

  log "Done"
}

main "$@"
