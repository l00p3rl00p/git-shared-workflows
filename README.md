# Git Shared Workflows

**Reusable GitHub Actions for consistent, verifiable builds and code checks.**

[![GitHub Actions](https://img.shields.io/badge/Automation-GitHub_Actions-FF1744?style=flat-square&logo=githubactions&logoColor=white)](.github/workflows/)
[![DSH](https://img.shields.io/badge/DSH-Plugin_Packaging-00D6C2?style=flat-square)](.github/workflows/dsh-acc-package.yml)
[![YAML](https://img.shields.io/badge/Configuration-YAML-6853B7?style=flat-square&logo=yaml&logoColor=white)](workflows/)

[Getting started](#getting-started) · [Workflow catalog](#workflow-catalog) · [README template](README.template.md) · [Contributing](CONTRIBUTING.md)

## What this repository provides

Two ways to share checks:

- **Reusable workflow:** call the strict ACC package pipeline directly from another repository. One maintained workflow validates, packages, checks its SHA-256, installs into a clean DSH profile, and uploads the tarball, checksum and source commit.
- **Copyable workflows:** copy individual language, shell, secrets, or Compose checks from [`workflows/`](workflows/) when they apply to a repository.

These workflows run in GitHub Actions runners, **not** on a user's Mac or deployed Docker stack. Successful CI installation into a temporary DSH profile does not establish live Web UI operation.

## Getting started

### Call the strict ACC package workflow

Put this in `.github/workflows/acc-package.yml` in the target repository:

```yaml
name: Verify ACC package
on:
  push:
    branches: [main]
  pull_request:
  workflow_dispatch:

permissions:
  contents: read

jobs:
  package:
    uses: l00p3rl00p/git-shared-workflows/.github/workflows/dsh-acc-package.yml@main
    with:
      plugin_path: "."
```

For a monorepo, set `plugin_path: "plugins/dsh-auto-code-correct"`. To verify the authoritative ACC repository from another repository without copying its source, set:

```yaml
    with:
      source_repository: l00p3rl00p/dsh-auto-code-correct
      source_ref: main
      plugin_path: "."
```

The reusable workflow runs `pnpm install --frozen-lockfile` and `pnpm run verify` (lint, formatting, types, tests, build, browser-bundle/package contract). It packs the **tested commit**, records the full Git commit SHA and SHA-256 checksum, verifies the archive before and after a clean official DSH profile install, and publishes those three files together as a GitHub Actions artifact. It does **not** deploy or install into a running QDev container.

**Rule:** Test → Commit → Package → Verify SHA → Install. Use the uploaded tarball from the passing commit; do not build an uncommitted local substitute.

### Copy a standalone check

```sh
mkdir -p .github/workflows
cp path/to/git-shared-workflows/workflows/lint-python.yml .github/workflows/
git add .github/workflows/lint-python.yml
git commit -m "Add Python checks"
git push
```

## Workflow catalog

| Check | File | Requirements |
| --- | --- | --- |
| **ACC source → installable DSH plugin** | [Reusable ACC verification](.github/workflows/dsh-acc-package.yml) | ACC package, pnpm lockfile, `verify` script; called from a workflow |
| Self-test of shared ACC workflow | [Verify ACC package](.github/workflows/verify-acc-package.yml) | Uses canonical public ACC source |
| Python Ruff and ty | [lint-python](workflows/lint-python.yml) | Python source |
| Rust format and Clippy | [lint-rust](workflows/lint-rust.yml) | Cargo project |
| TypeScript typecheck | [lint-typescript](workflows/lint-typescript.yml) | Node package and lockfile |
| ShellCheck and YAML | [lint-shell-yaml](workflows/lint-shell-yaml.yml) | Shell/YAML files |
| Docker Compose validation | [compose-validate](workflows/compose-validate.yml) | Compose project |
| Secret scanning | [gitleaks](workflows/gitleaks.yml) | Git repository |
| AST, Tree-sitter and NetworkX | [verify-structural-tools](workflows/verify-structural-tools.yml) | Python installed by workflow |

Only workflows in `.github/workflows/` execute in this repository. Files in `workflows/` are templates to copy into adopting repositories.

## Repository guide

| Resource | Purpose |
| --- | --- |
| [Environment](ENVIRONMENT.md) | How the copyable checks run |
| [Contributing](CONTRIBUTING.md) | Adoption and README conventions |
| [README template](README.template.md) | Optional presentation pattern; use real repo facts |
| [QDocker Compose](https://github.com/l00p3rl00p/qdocker-compose) | Deployment repository consuming the shared package checks |
| [Quatrus Scratchpad](https://github.com/l00p3rl00p/quatrus-scratchpad) | Experimental plugin source and archived packages |
| [ACC](https://github.com/l00p3rl00p/dsh-auto-code-correct) | Authoritative ACC source |

Copyable workflow files are independent snapshots. Only the reusable workflow stays connected to this repository's current implementation through its `uses:` reference.
