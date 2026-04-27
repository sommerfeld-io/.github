# GitHub Copilot Instructions

## Commit Messages: Conventional Commits

Always use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) for every commit message.

**Format:** `<type>[optional scope]: <description>`

| Type | Effect | When to use |
|------|--------|-------------|
| `fix` | PATCH release | Patches a bug |
| `feat` | MINOR release | Introduces a new feature |
| `BREAKING CHANGE` footer | MAJOR release | Introduces a breaking API change |
| `build`, `chore`, `ci`, `docs`, `style`, `refactor`, `perf`, `test` | No release | All other changes |

**Rules:**
- A scope may be added in parentheses for extra context: `feat(parser): add ability to parse arrays`
- Breaking changes must include `BREAKING CHANGE:` in the footer: `feat!: drop support for Node 6`
- Commit message titles must also match the project pattern: `^(fix|feat|build|chore|ci|docs|style|refactor|perf|test)/[a-z0-9._-]+$`

## Project Overview

This is the **`sommerfeld-io` organization's `.github` meta-repository**. It serves as:
- Fallback community health files (PR templates, issue templates, code of conduct) for all org repos without their own `.github/` directory
- Reusable GitHub Actions workflow library referenced by other repositories
- Conventions and standards for all `sommerfeld-io` projects

Key docs: [Development Guide](../docs/development-guide.md) | [Contributing](../CONTRIBUTING.md)

## Development Commands

All tasks run via [Taskfile](https://taskfile.dev) (`taskfile.yml`). Linting is executed through Docker Compose services — no local tool installs needed.

```bash
task lint        # Run all linters (yaml, workflows, filenames, folders, markdown-links)
task cleanup     # Stop containers, prune volumes, remove generated artifacts
```

Individual linters:
```bash
docker compose up lint-yaml --exit-code-from lint-yaml
docker compose up lint-workflows --exit-code-from lint-workflows
docker compose up lint-filenames --exit-code-from lint-filenames
docker compose up lint-folders --exit-code-from lint-folders
docker compose up lint-markdown-links --exit-code-from lint-markdown-links
```

## Naming & File Conventions

**Commit messages and PR/branch titles** must match: `^(fix|feat|build|chore|ci|docs|style|refactor|perf|test)/[a-z0-9._-]+$`

**File naming** (enforced by `ls-lint`):
- `.yml`, `.yaml`, `.md`, `.sh`, `.json`, `.conf` → `kebab-case`
- `Dockerfile` → `PascalCase`
- Config dotfiles (`.gitignore`, `.env`) → `lowercase`

**Folder structure** is enforced by `folderslint` (see `.folderslintrc`). Allowed top-level directories include `.devcontainer/`, `.github/`, `.vscode/`, `assets/`, `docs/`, `profile/`.

## Release Automation

Releases are fully automated via `semantic-release` triggered by CI on `main`. Git tags are **never created manually**. Versioning follows [SemVer](https://semver.org) driven by commit types.
