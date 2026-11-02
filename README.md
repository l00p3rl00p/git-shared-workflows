<div align="center">

# Git Shared Workflows

### Consistent checks. Clear repositories.

**Reusable GitHub Actions checks and a polished README presentation convention for every repository that adopts them.**

[![GitHub Actions](https://img.shields.io/badge/Automation-GitHub%20Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white)](workflows/)
[![YAML](https://img.shields.io/badge/Configuration-YAML-6853B7?style=flat-square&logo=yaml&logoColor=white)](workflows/)
[![Shell](https://img.shields.io/badge/Checks-Shell%20%2B%20Languages-367C46?style=flat-square&logo=gnubash&logoColor=white)](workflows/)
[![License](https://img.shields.io/badge/License-See%20LICENSE-436477?style=flat-square)](LICENSE)

[![Python](https://img.shields.io/badge/Python-Ruff%20%2B%20ty-178A94?style=flat-square&logo=python&logoColor=white)](workflows/lint-python.yml)
[![Rust](https://img.shields.io/badge/Rust-fmt%20%2B%20Clippy-178A94?style=flat-square&logo=rust&logoColor=white)](workflows/lint-rust.yml)
[![TypeScript](https://img.shields.io/badge/TypeScript-tsc-178A94?style=flat-square&logo=typescript&logoColor=white)](workflows/lint-typescript.yml)

**[Use checks](#use-it) · [Workflow catalog](#whats-inside) · [README template](README.template.md) · [Contributor guidance](CONTRIBUTING.md)**

</div>

---

## What you need

| | Dependency | Purpose |
| --- | --- | --- |
| **Required** | GitHub repository with GitHub Actions enabled | Executes copied workflows in the destination repository |
| **Optional** | Local Git | Copies and commits files from your checkout |

No action runs automatically just by browsing this repository. These are self-contained files to copy to the destination repo. Nothing here changes application code.

## What's inside

| File | Checks | Needs in the destination repo |
| --- | --- | --- |
| [`lint-python.yml`](workflows/lint-python.yml) | Ruff lint/format and ty type checking | Python source |
| [`lint-rust.yml`](workflows/lint-rust.yml) | `cargo fmt --check`, `cargo clippy` (warnings fail) | `Cargo.toml` |
| [`lint-typescript.yml`](workflows/lint-typescript.yml) | `tsc --noEmit` after `npm ci` | `package.json` and lockfile |
| [`lint-shell-yaml.yml`](workflows/lint-shell-yaml.yml) | ShellCheck and yamllint | Shell or YAML files |
| [`compose-validate.yml`](workflows/compose-validate.yml) | `docker compose config` | Compose files and required variables |
| [`gitleaks.yml`](workflows/gitleaks.yml) | Secret scanning in Git history | Nothing additional |

## Use it

Copy only the checks applicable to the repository:

```sh
mkdir -p .github/workflows
cp path/to/git-shared-workflows/workflows/lint-python.yml .github/workflows/
git add .github/workflows/lint-python.yml
git commit -m "Add Python checks"
git push
```

**Along with adopting the checks, give the destination README the same clear front page:** use [README.template.md](README.template.md) and follow [CONTRIBUTING.md](CONTRIBUTING.md). Inspect the actual target repo first; use factual badges, real links, required vs optional dependencies, a short component overview, and its working commands. Do **not** copy a fictional generic technology stack into another project.

## Project navigation

| Need | Source |
| --- | --- |
| Reusable workflow files | [workflows/](workflows/) |
| README presentation skeleton | [README.template.md](README.template.md) |
| Workflow adoption and README conventions | [CONTRIBUTING.md](CONTRIBUTING.md) |
| Operating details for shared checks | [ENVIRONMENT.md](ENVIRONMENT.md) |
| Working visual example | [Q Docker Compose README](https://github.com/l00p3rl00p/qdocker-compose/blob/main/README.md) |

Each workflow copy is independent; copying files does not create an ongoing update channel. The shared README style is a convention, not a background automation.
