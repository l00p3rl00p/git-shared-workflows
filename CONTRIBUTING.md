# Contributing and adopting shared workflows

This repository provides copyable CI checks **and a consistent README presentation pattern**. When pulling shared workflows into another repository, also apply the README header convention from [README.template.md](README.template.md) to that repository's README. This is a presentation update, **not** permission to replace authoritative documentation or invent prerequisites.

1. Inspect the target repository's README, code/build manifests, actual workflow configuration, license, and existing documentation.
2. Copy only the applicable checks from [workflows/](workflows/) into its `.github/workflows/` directory. These are separate GitHub Actions files; they do not automatically install anything.
3. Adapt the **top of its existing README** using [README.template.md](README.template.md): centered project title and one-line purpose; a first row of verified platform/language/license badges; optional second row of *verified* integrations; short clickable navigation to real existing sections or files.
4. Present **required** vs **optional** dependencies accurately, describe what the repository contains, and retain working usage commands. Never infer a required OS, CPU architecture, CLI, service, or health status from a logo. Language badges describe technologies actually used in that repository, not just its larger ecosystem.
5. Preserve the remainder of the README's important operating instructions and links, consolidate duplicated prose in place, and keep the target repository's existing authoritative sources authoritative. No new documentation source of truth.
6. Validate badge URLs and Markdown targets, ensure links resolve, confirm commands from source configuration, check that no placeholder text remains, and preview GitHub-rendered Markdown. Do not add a passing CI badge unless a real workflow supports it.

**Style:** restrained, consistent shields.io `flat-square` badges; SVG logos where available; clickable links, not pretend interactive tabs. Keep custom images in the target repo's `.github/assets/` only if needed. No generator, build dependency, or new workflow required. For a visual example, see [Q Docker Compose](https://github.com/l00p3rl00p/qdocker-compose/blob/main/README.md).

Workflow adoption and README formatting are two parts of the same repository-onboarding convention; the README treatment accompanies workflow copying even though it is not an executable GitHub Action.
