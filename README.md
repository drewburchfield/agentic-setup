# Agentic CLI Setup

I use four AI coding harnesses. Claude Code is the primary one; Codex CLI, Gemini CLI, and OpenCode fill secondary, tertiary, and fourth roles respectively. All four share a unified skill library through a sync script that runs automatically.

This repo documents the full setup and serves as the portable source of truth for reproducing it on a new machine.

## The Setup

| Harness | Role | Config | MCP Servers |
|---------|------|--------|-------------|
| **Claude Code** | Primary. Plugins, skills, hooks, commands all live here. | `~/.claude/` | 15 servers: Exa, Google-PSE, Granola, HelpScout, Slack, nanobanana, MCP_DOCKER, ChatPRD, 5 claude.ai connectors, 2 plugin MCPs |
| **Codex CLI** | Secondary. Gets skills via symlink. | `~/.codex/` | Docker MCP, Playwright, Pencil, Linear |
| **Gemini CLI** | Tertiary. Gets skills via symlink. | `~/.gemini/` | Docker MCP, Playwright |
| **OpenCode** | Fourth. Gets skills via symlink. | `~/.config/opencode/` | Docker MCP, 4 Z.AI servers (vision, search, reader, zread) |

By the numbers:

- **10** [plugin marketplaces](inventory/marketplaces.md) (Anthropic official, community, and personal)
- **65** [plugins](inventory/plugins.md) providing agents, hooks, LSP integrations, and document tools
- **77** [unique skills](inventory/skills.md) (10 personal + 67 from plugins), all synced across harnesses
- **MCP servers** configured [per-harness](inventory/mcp-servers.md), with Docker MCP Toolkit shared across all harnesses
- **CLI tools** [inventoried](inventory/clis.md) for service integrations, browser automation, and development runtimes
- **Apps and infrastructure** [documented](inventory/apps.md) including Docker Desktop, Obsidian, Superwhisper, and supporting macOS apps

## How Skill Sync Works

Claude Code is the only harness where plugins and skills are installed. The other three get read access to everything through symlinks.

The flow:

```
Claude Code plugins install skills
        │
        ▼
  sync-skills.sh scans ~/.claude/skills/ and ~/.claude/plugins/cache/
        │
        ▼
  Deduplicates by name (personal skills win over plugin skills)
        │
        ▼
  Creates symlinks in ~/.gemini/skills/
                       ~/.codex/skills/
                       ~/.config/opencode/skills/
```

The script runs automatically via a [`SessionStart` hook](config/claude-code/hooks.md) every time Claude Code starts. It's silent (stdout/stderr suppressed) and failure-safe (`|| true`).

To run manually:

```bash
zsh scripts/sync-skills.sh           # sync all skills
zsh scripts/sync-skills.sh --dry-run # preview without changes
```

The [canonical script](scripts/sync-skills.sh) lives in this repo. `~/.claude/scripts/sync-skills.sh` is a symlink pointing here, so edits are automatically version-controlled.

## Day-to-Day Operations

### Adding a personal skill

All skills go through Claude Code. Never use `npx skills add` in project directories; it creates per-agent scaffolding that conflicts with the sync script.

```bash
# 1. Copy or clone the skill into Claude Code's skills directory
cp -r /path/to/skill-name ~/.claude/skills/skill-name
# The skill folder must contain a SKILL.md file.

# 2. Sync to other harnesses (happens automatically on next session start)
zsh ~/dev/agentic-setup/scripts/sync-skills.sh

# 3. Update the inventory
#    Add a row to inventory/skills.md under "Personal Skills"
#    Update the counts in skills.md and this README
```

If the skill comes from an npm package (like `agent-browser`), symlink instead of copying so updates come through:

```bash
ln -s /opt/homebrew/lib/node_modules/agent-browser/skills/agent-browser ~/.claude/skills/agent-browser
```

### Adding a plugin

Plugins are installed through Claude Code's plugin system. They auto-distribute their skills via the sync script.

```bash
# From a marketplace already added:
# Enable the plugin in Claude Code settings or via the CLI.

# From a new marketplace:
claude plugin marketplace add <github-url>
# Then enable individual plugins from the marketplace.
```

After adding, update `inventory/plugins.md` and `inventory/skills.md` with any new skills the plugin provides.

### Adding an MCP server

MCP servers are configured per-harness. See [mcp-servers.md](inventory/mcp-servers.md) for the config file locations and format for each harness.

### What NOT to do

- **Don't use `npx skills add` in project directories.** It scatters `.agent/`, `.claude/`, `.goose/`, `.kiro/`, `.windsurf/`, and `skills/` directories that duplicate what `sync-skills.sh` already handles. If you accidentally do, delete the generated directories.
- **Don't install skills directly into secondary harnesses** (Gemini, Codex, OpenCode). The sync script owns those directories. Any manual additions will be orphaned or cause duplicate warnings.
- **Don't use Gemini's Antigravity skill installer.** It creates a separate `~/.gemini/antigravity/skills/` index that duplicates what the sync script puts in `~/.gemini/skills/`.

## Repository Structure

```
.gitignore                          # Blocks npx skills add scaffolding

scripts/
  └── sync-skills.sh                # The sync script (canonical copy)

inventory/
  ├── skills.md                     # All 77 skills with source, dependencies, and description
  ├── plugins.md                    # All 65 plugins by category
  ├── marketplaces.md               # All 10 marketplaces with git URLs
  ├── mcp-servers.md                # MCP configs for each harness
  ├── clis.md                       # CLI tools for services, automation, and runtimes
  └── apps.md                       # macOS apps and infrastructure supporting the setup

config/
  ├── claude-code/
  │   ├── CLAUDE.md                 # Global instructions
  │   ├── settings-reference.md     # Documented settings (no secrets)
  │   └── hooks.md                  # Hook configuration
  ├── gemini/
  │   └── config-reference.md       # Gemini CLI settings and MCP
  ├── codex/
  │   └── config-reference.md       # Codex CLI settings and MCP
  ├── opencode/
  │   └── config-reference.md       # OpenCode notes
  └── git/
      ├── config-reference.md       # Global git template and security hooks
      └── pre-commit                # Pre-commit hook (credential blocking, .env warning, npm audit)

workflows/
  └── README.md                     # Atomic workflow patterns and how the tools compose

references/
  └── browser-tools-comparison.md   # agent-browser vs dev-browser vs Playwright MCP
```

## Reproducing on a New Machine

### 1. Install the harnesses

```bash
# Claude Code (native installer, no Node.js required)
curl -fsSL https://claude.ai/install.sh | bash

# Gemini CLI (requires Node.js 20+)
npm install -g @google/gemini-cli

# Codex CLI (either Homebrew or npm)
brew install --cask codex
# or: npm i -g @openai/codex

# OpenCode
curl -fsSL https://opencode.ai/install | bash
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

See [mcp-servers.md](inventory/mcp-servers.md) for per-harness configuration. Docker MCP Toolkit is shared across all four harnesses. Claude Code uses Exa via HTTP.

### 6. Copy global instructions and references

```bash
cp ~/dev/agentic-setup/config/claude-code/CLAUDE.md ~/.claude/CLAUDE.md
mkdir -p ~/.claude/references
cp ~/dev/agentic-setup/references/* ~/.claude/references/
```

See the [settings reference](config/claude-code/settings-reference.md) for permissions, environment variables, and other settings to configure.
