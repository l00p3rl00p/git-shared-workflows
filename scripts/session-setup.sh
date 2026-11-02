#!/usr/bin/env bash
# Session setup: installs the lint, type, and code-navigation tools at session start.
# Runs from .claude/settings.json. Installs the latest release of each tool; no pins.
# A failed install is reported and does not stop the others.
set -uo pipefail
log() { echo "[session-setup] $*"; }
run() {
  if "$@" >/dev/null 2>&1; then log "ok: $*"; else log "FAILED: $*"; fi
}

# Python: lint, type checks, graph library, syntax trees, language server.
# (ast is part of Python's standard library and needs no install.)
run python3 -m pip install --quiet --break-system-packages \
  ruff ty yamllint networkx tree-sitter tree-sitter-python tree-sitter-rust \
  tree-sitter-typescript tree-sitter-bash pyright

# Node: TypeScript compiler, TypeScript language server, ast-grep.
run npm install -g --silent typescript vtsls @ast-grep/cli

# Rust: rust-analyzer, clippy, rustfmt.
run rustup component add rust-analyzer clippy rustfmt

# Shell lint.
run apt-get install -y -q shellcheck

log "done"
