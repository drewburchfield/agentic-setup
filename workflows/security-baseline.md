# Security Baseline

A layered approach to running Claude Code safely. Each tier adds coverage - you don't need all of them, but they're ordered from highest leverage to most involved.

## Tier 1: Behavior Constraints

The first line of defense is constraining what Claude can do before it does anything.

**CLAUDE.md guardrails** - Global instructions that shape Claude's behavior in every session. Key patterns: require confirmation before touching more than 2-3 files, read before writing, never skip pre-commit hooks (`--no-verify`). These don't block Claude mechanically but they significantly reduce misinterpretation of vague instructions. See [config/claude-code/CLAUDE.md](../config/claude-code/CLAUDE.md).

**Permission settings** - Claude Code's `settings.json` supports `allowedTools` and `deniedTools` arrays to explicitly block specific tools, and `defaultMode` to control how aggressively Claude auto-executes. Restricting dangerous tools (e.g., certain Bash patterns) or requiring confirmation by default is worth configuring early. See [config/claude-code/settings-reference.md](../config/claude-code/settings-reference.md).

**Avoid `--dangerously-skip-permissions`** - This flag disables all permission checks and lets Claude run without any confirmation prompts. Don't use it as a default workflow. It exists for fully automated pipelines where you've already validated the context, not for interactive development.

**Understand Claude's access model** - Claude Code starts in the directory you launch it from, but it can escape: referencing files outside the working directory, calling external APIs via MCP servers, executing shell commands, and more. The more precisely you write instructions, the less surface area for misinterpretation. Vague instructions in a broadly-permissioned environment are the most common source of unintended actions.

## Tier 2: Commit-Time Checks

Catches problems at the moment code is committed, regardless of how it was written.

**Global pre-commit hook** - Runs on every commit across all projects. Checks for:
- Credential patterns (AWS keys, GitHub tokens, OpenAI keys, JWTs, and others)
- `.env` files staged for commit (warns and prompts, doesn't auto-block)
- High/critical vulnerabilities in npm dependencies when `package.json` changes

See [config/git/pre-commit](../config/git/pre-commit). Wire it globally via git's template directory system (`git config --global init.templateDir ~/.git-templates`). See [git config reference](../config/git/config-reference.md) for setup instructions.

## Tier 3: Runtime Guards

Active during Claude Code sessions, intercepting or flagging problems as they happen.

**Safety Net plugin** - Intercepts destructive commands (file deletion, force pushes, database drops, and similar) and stops Claude before execution. Very effective at catching cases where Claude is technically following instructions but about to do something irreversible. Install from [kenryu42/claude-code-safety-net](https://github.com/kenryu42/claude-code-safety-net).

**codeguard-security plugin** - Integrates Project CodeGuard's secure coding rules into Claude's workflow. Flags vulnerability patterns as code is written rather than after the fact. Install from [cosai-oasis/project-codeguard](https://github.com/cosai-oasis/project-codeguard).

**PreToolUse hooks** - Claude Code fires a `PreToolUse` event before every tool call. You can intercept specific tool calls with shell commands - for example, blocking Bash commands matching certain patterns, or logging all file writes to a specific directory. More involved to set up but gives fine-grained control. See [config/claude-code/hooks.md](../config/claude-code/hooks.md).

## Tier 4: Post-Code Review

Catches what slips through during active development. Run before merging.

**pr-review-toolkit plugin** - Runs multiple specialized agent reviewers against a pull request in parallel. Each agent catches different classes of issues. Good as a lightweight review gate before the full pipeline.

**quality-gate skill** - The full review cycle. Combines agent reviews, Devin Review (severity-categorized issue detection with auto-fixes), and CodeRabbit (line-by-line comments and security analysis) in parallel, then runs remediation loops until reviews pass. The most thorough option - use it on anything going to production.

## Tier 5: Isolation

For when running Claude on your local machine isn't acceptable.

**Sprites** - Hardware-isolated Linux environments from Fly.io with checkpoint/restore. Run Claude Code inside a Sprite instead of locally. The entire agent and any code it generates execute in an isolated environment that can't affect your local machine. Good for exploratory work, untrusted codebases, or situations where local environment pollution is a real concern. See [sprites.dev](https://sprites.dev/).

## Recommended Starting Point

If you're setting this up fresh, start with Tier 1 and Tier 2 - they cover the most ground with the least overhead. Add Safety Net and codeguard-security from Tier 3 next. The PR review pipeline is worth adding once you're shipping code regularly.
