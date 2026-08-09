![Agentic Setup](https://ghrb.waren.build/banner?header=![iterm2]+Agentic+Setup&subheader=A+reproducible+system+for+building+with+AI+agents&bg=1a1a2e&color=e0e0e0&support=true)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/drewburchfield/agentic-setup)

Two years of daily work with AI coding agents, distilled into a reproducible system. This repo is the full inventory: what's installed, how the pieces connect, and the patterns that work. It also serves as the portable source of truth for reproducing the setup on a new machine.

## The Setup

| Harness | Role | MCP Servers |
|---------|------|-------------|
| [**Claude Code**](https://docs.anthropic.com/en/docs/claude-code) | Primary. Plugins, skills, hooks, commands all live here. | Broadest set: [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/) gateway + search, image, design, comms, and notes servers ([details](inventory/mcp-servers.md)) |
| [**Codex CLI**](https://github.com/openai/codex) | Secondary. Skills via skills.sh (universal path). | [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/) gateway + Playwright, Pencil, Linear, and extras ([details](inventory/mcp-servers.md)) |
| [**Antigravity (`agy`)**](https://antigravity.google/) | Tertiary. Gemini models in a VS Code-based agentic IDE. Skills via skills.sh (universal path). | None configured yet (uses Gemini's built-in tools) |
| [**OpenCode**](https://opencode.ai/) | Fourth. Skills via skills.sh (universal path). | [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/) gateway + [Z.AI](https://docs.z.ai/devpack/tool/opencode) (vision / search / reader / zread) |
| [**Grok**](https://x.ai/) | Fifth. xAI's `grok` CLI (default model `grok-build`), with its own [xAI plugin marketplace](https://github.com/xai-org/plugin-marketplace). Skills via skills.sh (universal path). | [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/) gateway + search, image, notes, and personal servers ([details](inventory/mcp-servers.md)) |

## By the Numbers

| | Count | What |
|:--:|------:|------|
| 🏪 | **15** | [Plugin marketplaces](inventory/marketplaces.md) (Anthropic official, community, and personal) |
| 🔌 | **74** | [Plugins](inventory/plugins.md) providing agents, hooks, LSP integrations, and document tools |
| ⚡ | **16** | [Keep-set skills](inventory/skills.md) managed by [skills.sh](https://skills.sh) across all harnesses (plus plugin-provided skills); the long tail is a `find-skills` backstop |
| 🌐 | **12+** | [MCP servers](inventory/mcp-servers.md) configured per-harness, [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) shared across harnesses |
| 🔧 | **30+** | [CLI tools](inventory/clis.md) for service integrations, browser automation, and development runtimes |
| 🖥️ | **20+** | [Apps and infrastructure](inventory/apps.md) including Docker Desktop, Obsidian, Superwhisper, and supporting macOS apps |

## Workflows

Patterns for how the tools compose together. These are atomic building blocks, not rigid pipelines. See [workflows/README.md](workflows/README.md) for details.

| Pattern | What It Does |
|---------|-------------|
| **Multi-Model Consultation** | Peer CLIs (agy, Codex, Grok, OpenCode, Claude) review hard problems in parallel via the [braintrust](https://github.com/drewburchfield/braintrust) plugin |
| **Local Quality Gate** | [project-bootstrap](https://github.com/drewburchfield/project-bootstrap) multi-harness Review Suite with `--local` for early issue detection |
| **PR Review Pipeline** | Full review combining agent reviews, [Devin](https://devin.ai/) Review, and [CodeRabbit](https://coderabbit.ai/) in parallel |
| **Design & Prototyping** | Agentic CLI + frontend-design skill + [nanobanana](https://github.com/zhongweili/nanobanana-mcp-server), or external tools ([Stitch](https://stitch.withgoogle.com/), [v0](https://v0.dev/), [Lovable](https://lovable.dev/), [Paper](https://builtwithpaper.com/), [Pencil](https://pencil.li/)) |
| **Security** | Layered: pre-commit credential scanning, codeguard-security plugin, full PR review pipeline. See [security baseline](workflows/security-baseline.md) |
| **Knowledge Capture** | [Kindling](https://github.com/drewburchfield/kindling) with Zettelkasten + CODE + PARA, semantic search via [obsidian-graph](https://github.com/drewburchfield/obsidian-graph) (Voyage Context-3 + pgvector) |
| **Skill Distribution** | [skills.sh](https://skills.sh) installs each skill to all harnesses at once (`skills add -a ...`); canonical store at `~/.agents/skills/`, Claude Code symlinked in |
| **Setup Audit** | First-principles review of source of truth, reproducibility, drift detection, and tutorial gaps. See [setup audit](workflows/setup-audit.md) |
| **Agent Terminal** | [cmux](https://cmux.com) workspace-per-agent terminal: session resume for all harnesses, per-harness colors, one-click persistent remote sessions with live titles. See [cmux guide](workflows/cmux-remote-agents.md) |
| **Multi-Account Claude Resume** | Main + additional Claude logins as parallel sticky seats (not account switching); cmux quit/reopen keeps each tab’s `CLAUDE_CONFIG_DIR`. See [multi-account resume](workflows/cmux-claude-multi-account-resume.md) and [`scripts/claude-multi-account/`](scripts/claude-multi-account/) |

## Configuration Reference

Per-harness configuration, global instructions, hooks, and security settings.

| Config | What |
|--------|------|
| [Claude Code](config/claude-code/) | [CLAUDE.md](config/claude-code/CLAUDE.md) global instructions, [settings](config/claude-code/settings-reference.md), [hooks](config/claude-code/hooks.md) |
| [Codex CLI](config/codex/config-reference.md) | Settings, MCP servers, trusted projects |
| [Antigravity (`agy`)](config/antigravity/config-reference.md) | Settings, MCP config, Gemini models |
| [OpenCode](config/opencode/config-reference.md) | Settings, MCP servers |
| [Grok](config/grok/config-reference.md) | Settings, models, xAI marketplace, MCP servers |
| [Git](config/git/) | Global [pre-commit hook](config/git/pre-commit) (credential blocking, .env warning, npm audit) |

## References

| Reference | What |
|-----------|------|
| [Browser tools comparison](references/browser-tools-comparison.md) | Command-by-command matrix: agent-browser (~130) vs dev-browser (~79) vs Claude-in-Chrome (~39) vs Playwright MCP (~42) |

---

## How Skills Are Managed

Skills are managed with [skills.sh](https://skills.sh) (`npx skills`): one tool, every
harness. No homegrown sync layer, no privileged harness.

`skills add` installs to a canonical store at `~/.agents/skills/`; Codex, Antigravity, OpenCode,
and Grok read from there directly (the universal path), and Claude Code gets a symlink from
`~/.claude/skills/`. `skills update` refreshes from each skill's source.

```
  private repo (drewburchfield/skills, SSH)  +  public catalog (skills.sh)
                             |
                             v
   npx skills add ... -a claude-code -a codex -a opencode -a antigravity
                             |
                             v
   canonical: ~/.agents/skills/<name>   (Codex / Antigravity / OpenCode / Grok read here)
                             |
                             v
   symlink:   ~/.claude/skills/<name> -> ../../.agents/skills/<name>
```

Personal skills live in a private repo; the public keep-set installs from public sources;
everything else is left to [`find-skills`](https://skills.sh) as a just-in-time backstop.
See [skills.md](inventory/skills.md).

<details>
<summary><strong>Reproducing on a new machine</strong></summary>

<br>

### 1. Install the harnesses

```bash
curl -fsSL https://claude.ai/install.sh | bash          # Claude Code
brew install --cask codex                                # Codex CLI
curl -fsSL https://opencode.ai/install | bash            # OpenCode
# Antigravity (agy): download from https://antigravity.google/  (Gemini models)
# Grok CLI (grok):   see https://x.ai / https://github.com/xai-org
```

### 2. Clone this repo

```bash
git clone https://github.com/drewburchfield/agentic-setup.git ~/dev/agentic-setup
```

### 3. Install skills

```bash
# personal skills (private repo, all harnesses)
npx skills add git@github.com:drewburchfield/skills.git --skill '*' -g \
  -a claude-code -a codex -a opencode -a antigravity -y

# public keep-set
npx skills add vercel-labs/skills --skill find-skills -g -a claude-code -a codex -a opencode -a antigravity -y
npx skills add mattpocock/skills --skill grill-me --skill handoff -g -a claude-code -a codex -a opencode -a antigravity -y
npx skills add steipete/clawdis --skill bear-notes -g -a claude-code -a codex -a opencode -a antigravity -y
npx skills add jacob-bd/notebooklm-mcp-cli --skill nlm-skill -g -a claude-code -a codex -a opencode -a antigravity -y
```

See [skills.md](inventory/skills.md) for the full keep-set and sources.

### 4. Install plugins

See [plugins.md](inventory/plugins.md) for the full list. Marketplaces are added with `claude plugin marketplace add <url>`, then individual plugins are enabled in settings.

### 5. Configure MCP servers

See [mcp-servers.md](inventory/mcp-servers.md) for per-harness configuration. [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) is shared across harnesses.

### 6. Copy global instructions and references

```bash
cp ~/dev/agentic-setup/config/claude-code/CLAUDE.md ~/.claude/CLAUDE.md
mkdir -p ~/.claude/references
cp ~/dev/agentic-setup/references/* ~/.claude/references/
```

See the [settings reference](config/claude-code/settings-reference.md) for permissions, environment variables, and other settings to configure.

</details>

<details>
<summary><strong>Day-to-day operations</strong></summary>

<br>

### Adding a skill

```bash
# from any source: GitHub shorthand, full URL, git@ SSH, or a local path
npx skills add <owner/repo> --skill <name> -g \
  -a claude-code -a codex -a opencode -a antigravity -y

# update everything / discover on demand
npx skills update -g
npx skills find <query>
```

Personal skills go into the private `drewburchfield/skills` repo, then install from there.
Global (`-g`) installs land in the canonical `~/.agents/skills/` and reach every harness.

### Adding a plugin

```bash
claude plugin marketplace add <github-url>    # add a new marketplace
# Then enable individual plugins from the marketplace
```

### Adding an MCP server

MCP servers are configured per-harness. See [mcp-servers.md](inventory/mcp-servers.md) for config file locations and format.

### What NOT to do

- **Don't hand-copy skills into `~/.claude/skills/`.** Let skills.sh own them so every harness stays in sync and updatable.
- **Don't install skills per-harness by hand.** Use `skills add -a <agents>` so the canonical `~/.agents/skills/` stays the single source.
- **Don't commit personal skills to this public repo.** They live in the private `drewburchfield/skills` repo.

</details>
