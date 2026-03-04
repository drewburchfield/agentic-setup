# Workflows

Patterns for how the tools in this setup compose together. These aren't rigid pipelines; they're atomic building blocks that get mixed depending on the task.

This directory is a work in progress. Detailed workflow documentation will be added over time.

## The Building Blocks

### Multi-Model Consultation (Braintrust)

Run all three secondary CLIs (Gemini, Codex, Claude subagent) in parallel for second opinions, architecture review, or research. Each model catches different issues. The braintrust plugin handles invocation, output parsing, and synthesis.

Best for: hard problems, design review, security audits, cross-model code review where the model that wrote the code has blind spots to its own bugs.

### Local Quality Gate

Run the quality-gate skill with the `--local` flag during active development. Catches issues early without the overhead of the full PR review pipeline. Pairs naturally with braintrust consultations when something looks off.

### PR Review Pipeline

The full version of quality review, run when code is ready for merge. Combines multiple review sources in parallel:

- **Agent reviews** via the quality-gate skill (full mode)
- **Devin Review** for severity-categorized issue detection and auto-fixes
- **CodeRabbit** for line-by-line comments and security analysis

Each reviewer catches different classes of issues. The quality-gate skill orchestrates remediation cycles until reviews pass.

### Project Setup

The project-bootstrap skill auto-detects language and sets up quality tooling (ESLint, Prettier, ruff, pyright, etc.) and stop hooks. One command to go from empty repo to configured project.

### Design & Prototyping

Multiple entry points depending on what you're building:

- **Agentic CLI + frontend-design skill**: Design directly in code with the coding harness. The braintrust plugin provides design review (Gemini is strong here). nanobanana handles image generation.
- **External prototyping tools** (Stitch, v0, Lovable, Paper, Pencil): Generate UI designs or working prototypes, then hand off to agentic CLIs for business logic and integration.

Both approaches work for frontend and backend prototyping.

### Security

Layered checks at different points:

- **Every commit**: Global pre-commit hook scans for credential patterns, warns on `.env` files, runs `npm audit` on dependency changes.
- **During development**: Local quality gate and codeguard-security plugin.
- **Every PR**: Full PR review pipeline (quality-gate + Devin + CodeRabbit).
- **Secrets management**: 1Password CLI and plugin for credential lookups, vault operations, and environment variable injection.

### Knowledge Capture

Work produces insights that feed back into the system:

- **Obsidian Knowledge Vault**: Zettelkasten for atomic, linked notes. CORE framework (Collect, Organize, Reflect, Express) for the full lifecycle.
- **obsidian-graph-mcp**: Semantic search and graph traversal over the vault via Voyage Context 3 embeddings, accessible from all harnesses.

### Skill Distribution

Automatic, invisible. Plugins install skills into Claude Code. The sync script runs on every session start and symlinks everything to Codex, Gemini, and OpenCode. No manual steps needed.

### Research

Braintrust parallel research across all three models, plus:

- **Exa MCP** for neural search
- **Google-PSE MCP** for programmatic web search
- **DeepWiki** for understanding open source codebases
- **context7 plugin** for up-to-date library documentation
