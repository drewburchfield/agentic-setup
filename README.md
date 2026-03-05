![Agentic Setup](https://ghrb.waren.build/banner?header=![iterm2]+Agentic+Setup&subheader=A+reproducible+system+for+building+with+AI+agents&bg=1a1a2e&color=e0e0e0&support=true)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT) [![Ask DeepWiki](https://deepwiki.com/badge.svg)](https://deepwiki.com/drewburchfield/agentic-setup)

Two years of daily work with AI coding agents, distilled into a reproducible system. This repo is the full inventory: what's installed, how the pieces connect, and the patterns that work. It also serves as the portable source of truth for reproducing the setup on a new machine.

## The Setup

| Harness | Role | MCP Servers |
|---------|------|-------------|
| [**Claude Code**](https://docs.anthropic.com/en/docs/claude-code) | Primary. Plugins, skills, hooks, commands all live here. | 10 servers: [Exa](https://exa.ai), [Google-PSE](https://github.com/adenot/mcp-google-search), [Granola](https://granola.ai/), [HelpScout](https://github.com/drewburchfield/help-scout-mcp-server), [Slack](https://github.com/korotovsky/slack-mcp-server), [nanobanana](https://github.com/zhongweili/nanobanana-mcp-server), [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/), [ChatPRD](https://app.chatprd.ai), 2 plugin MCPs |
| [**Codex CLI**](https://github.com/openai/codex) | Secondary. Gets skills via symlink. | [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/), [Playwright](https://playwright.dev/), [Pencil](https://pencil.li/), [Linear](https://linear.app/) |
| [**Gemini CLI**](https://github.com/google-gemini/gemini-cli) | Tertiary. Gets skills via symlink. | [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/), [Playwright](https://playwright.dev/) |
| [**OpenCode**](https://opencode.ai/) | Fourth. Gets skills via symlink. | [Docker MCP](https://www.docker.com/products/mcp-catalog-and-toolkit/), 4 [Z.AI](https://docs.z.ai/devpack/tool/opencode) servers |

## By the Numbers

| | Count | What |
|:--:|------:|------|
| 🏪 | **10** | [Plugin marketplaces](inventory/marketplaces.md) (Anthropic official, community, and personal) |
| 🔌 | **66** | [Plugins](inventory/plugins.md) providing agents, hooks, LSP integrations, and document tools |
| ⚡ | **78** | [Unique skills](inventory/skills.md) (10 personal + 68 from plugins), synced across all harnesses |
| 🌐 | **10+** | [MCP servers](inventory/mcp-servers.md) configured per-harness, [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) shared across all four |
| 🔧 | **30+** | [CLI tools](inventory/clis.md) for service integrations, browser automation, and development runtimes |
| 🖥️ | **20+** | [Apps and infrastructure](inventory/apps.md) including Docker Desktop, Obsidian, Superwhisper, and supporting macOS apps |

## Workflows

Patterns for how the tools compose together. These are atomic building blocks, not rigid pipelines. See [workflows/README.md](workflows/README.md) for details.

| Pattern | What It Does |
|---------|-------------|
| **Multi-Model Consultation** | Three models (Gemini, Codex, Claude) review every hard problem in parallel via the [braintrust](https://github.com/drewburchfield/braintrust) plugin |
| **Local Quality Gate** | Run the quality-gate skill with `--local` during development for early issue detection |
| **PR Review Pipeline** | Full review combining agent reviews, [Devin](https://devin.ai/) Review, and [CodeRabbit](https://coderabbit.ai/) in parallel |
| **Design & Prototyping** | Agentic CLI + frontend-design skill + [nanobanana](https://github.com/zhongweili/nanobanana-mcp-server), or external tools ([Stitch](https://stitch.withgoogle.com/), [v0](https://v0.dev/), [Lovable](https://lovable.dev/), [Paper](https://builtwithpaper.com/), [Pencil](https://pencil.li/)) |
| **Security** | Layered: pre-commit credential scanning, codeguard-security plugin, full PR review pipeline |
| **Knowledge Capture** | [Obsidian Knowledge Vault](https://github.com/drewburchfield/knowledge-vault) with Zettelkasten + CORE framework, semantic search via [obsidian-graph-mcp](https://github.com/drewburchfield/obsidian-graph-mcp) (Voyage Context-3 + pgvector) |
| **Skill Distribution** | Automatic. Plugins install skills into Claude Code, [sync script](scripts/sync-skills.sh) symlinks to all other harnesses on every session start |

## Configuration Reference

Per-harness configuration, global instructions, hooks, and security settings.

| Config | What |
|--------|------|
| [Claude Code](config/claude-code/) | [CLAUDE.md](config/claude-code/CLAUDE.md) global instructions, [settings](config/claude-code/settings-reference.md), [hooks](config/claude-code/hooks.md) |
| [Codex CLI](config/codex/config-reference.md) | Settings, MCP servers, trusted projects |
| [Gemini CLI](config/gemini/config-reference.md) | Settings, MCP servers, global instructions |
| [OpenCode](config/opencode/config-reference.md) | Settings, MCP servers |
| [Git](config/git/) | Global [pre-commit hook](config/git/pre-commit) (credential blocking, .env warning, npm audit) |

## References

| Reference | What |
|-----------|------|
| [Browser tools comparison](references/browser-tools-comparison.md) | Command-by-command matrix: agent-browser (~130) vs dev-browser (~79) vs Claude-in-Chrome (~39) vs Playwright MCP (~42) |

---

## How Skill Sync Works

The only executable code in this repo. Claude Code is the single source of truth for plugins and skills. The other three harnesses get read access through symlinks.

```
Claude Code plugins install skills
        |
        v
  sync-skills.sh scans ~/.claude/skills/ and ~/.claude/plugins/cache/
        |
        v
  Deduplicates by name (personal skills win over plugin skills)
        |
        v
  Creates symlinks in ~/.gemini/skills/
                       ~/.codex/skills/
                       ~/.config/opencode/skills/
```

The script runs automatically via a [`SessionStart` hook](config/claude-code/hooks.md) every time Claude Code starts. Silent, failure-safe.

```bash
zsh scripts/sync-skills.sh           # sync all skills
zsh scripts/sync-skills.sh --dry-run # preview without changes
```

<details>
<summary><strong>Reproducing on a new machine</strong></summary>

<br>

### 1. Install the harnesses

```bash
curl -fsSL https://claude.ai/install.sh | bash          # Claude Code
npm install -g @google/gemini-cli                        # Gemini CLI
brew install --cask codex                                # Codex CLI
curl -fsSL https://opencode.ai/install | bash            # OpenCode
```

### 2. Clone this repo

```bash
git clone https://github.com/drewburchfield/agentic-setup.git ~/dev/agentic-setup
```

### 3. Wire the sync script

```bash
mkdir -p ~/.claude/scripts
ln -s ~/dev/agentic-setup/scripts/sync-skills.sh ~/.claude/scripts/sync-skills.sh
```

Then add the SessionStart hook to `~/.claude/settings.json` (see [hooks.md](config/claude-code/hooks.md) for the exact JSON).

### 4. Install plugins

See [plugins.md](inventory/plugins.md) for the full list. Marketplaces are added with `claude plugin marketplace add <url>`, then individual plugins are enabled in settings.

### 5. Configure MCP servers

See [mcp-servers.md](inventory/mcp-servers.md) for per-harness configuration. [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) is shared across all four harnesses.

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

### Adding a personal skill

All skills go through Claude Code. Never use `npx skills add` in project directories; it creates per-agent scaffolding that conflicts with the sync script.

```bash
cp -r /path/to/skill-name ~/.claude/skills/skill-name    # must contain SKILL.md
zsh ~/dev/agentic-setup/scripts/sync-skills.sh            # or wait for next session start
```

For npm packages, symlink instead of copying:

```bash
ln -s /opt/homebrew/lib/node_modules/agent-browser/skills/agent-browser ~/.claude/skills/agent-browser
```

### Adding a plugin

```bash
claude plugin marketplace add <github-url>    # add a new marketplace
# Then enable individual plugins from the marketplace
```

### Adding an MCP server

MCP servers are configured per-harness. See [mcp-servers.md](inventory/mcp-servers.md) for config file locations and format.

### What NOT to do

- **Don't use `npx skills add` in project directories.** It scatters `.agent/`, `.claude/`, `.goose/`, `.kiro/`, `.windsurf/`, and `skills/` directories that duplicate what the sync script handles.
- **Don't install skills directly into secondary harnesses.** The sync script owns those directories.
- **Don't use Gemini's Antigravity skill installer.** It creates a separate index that duplicates what the sync script provides.

</details>
