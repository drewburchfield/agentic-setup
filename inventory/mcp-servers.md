# MCP Servers Inventory

MCP servers across 5 harnesses. The [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/)
gateway is shared everywhere. **Generic / public servers are named; client- or personal-specific
servers are generalized** (this is a public repo). Google Workspace (Gmail, Calendar, Drive,
Docs, Sheets) is handled by the [gog CLI](https://github.com/drewburchfield/gogcli-safe), not an
MCP server.

## Docker MCP Toolkit (shared across all harnesses)

[Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) is piped in via
`docker mcp gateway run`. It bundles, in a single gateway:

- **Obsidian** — read/write, search, periodic notes (connected to [Kindling](https://github.com/drewburchfield/kindling))
- **YouTube Transcript** — video info, timed transcripts
- **Time** — current time, timezone conversion
- **Fetch** — HTTP fetching
- **Sequential Thinking** — structured reasoning
- **Code Mode** — code execution context

## Generic / public servers

Public tools wired into one or more harnesses:

| Server | Type | Source | Used by |
|--------|------|--------|---------|
| Exa | HTTP (remote) | [exa.ai](https://exa.ai) | Claude |
| Google-PSE | stdio (via [master_mcp](https://github.com/drewburchfield/master_mcp)) | [adenot/mcp-google-search](https://github.com/adenot/mcp-google-search) | Claude, Grok |
| nanobanana | stdio (via master_mcp) | [zhongweili/nanobanana-mcp-server](https://github.com/zhongweili/nanobanana-mcp-server) | Claude, Grok |
| ChatPRD | HTTP (remote) | [chatprd.ai](https://app.chatprd.ai) | Claude |
| granola | HTTP (remote) | [granola.ai](https://granola.ai/) | Claude, Codex |
| devin | remote | [Cognition Devin](https://devin.ai/) | Claude |
| NotebookLM | stdio | [danielcorin/nlm](https://github.com/danielcorin/nlm) | Claude, Grok |
| macos-mcp | stdio | macOS system integration | Claude, Codex, Grok |
| Pencil | app-exposed | [pencil.li](https://pencil.li/) | Claude, Codex, OpenCode, Grok |
| Playwright | stdio | [playwright.dev](https://playwright.dev/) | Codex, Grok |
| Linear | remote / plugin | [linear.app](https://linear.app/) | Claude, Codex |
| context7 | plugin | [context7.com](https://context7.com/) | Claude |
| Z.AI (vision, search, reader, zread) | local / remote | [Z.AI](https://docs.z.ai/devpack/tool/opencode) | OpenCode |
| Docker MCP gateway | stdio | (Docker MCP Toolkit, above) | all |

## Personal / client-specific (generalized)

Wired in per-harness but not enumerated by client or workspace name:

- **Slack (multiple workspaces)** — Claude, Codex
- **Customer-support MCP** (custom) — Claude, Grok
- **Private knowledge-graph** (consulting; [obsidian-graph](https://github.com/drewburchfield/obsidian-graph)) — Claude, Codex, Grok
- **iMessage MCP** — Claude, Grok
- **Notes / vault MCPs** (Bear, Obsidian vault) — Claude, Grok

## Per-harness summary

| Harness | MCP servers |
|---------|-------------|
| **Claude Code** | Broadest set: Docker gateway + the generic servers above + the full personal/client set |
| **Codex** | Docker gateway, Playwright, Pencil, Linear, granola, macos-mcp, node_repl + Slack + private knowledge-graph |
| **Antigravity** | None configured yet (`~/.gemini/antigravity/mcp_config.json` is empty); uses Gemini's built-in tools |
| **OpenCode** | Docker gateway, Pencil, Z.AI (vision / search / reader / zread) |
| **Grok** | Docker gateway + Google-PSE, nanobanana, NotebookLM, macos-mcp, Playwright, Pencil + personal/client set |

## Infrastructure: master_mcp

[master_mcp](https://github.com/drewburchfield/master_mcp) orchestrates Dockerized MCP servers
via docker-compose. Several of the servers above run through it, alongside custom services:

| Service | Description | Upstream |
|---------|-------------|----------|
| google-search | Google Programmable Search Engine | [adenot/mcp-google-search](https://github.com/adenot/mcp-google-search) |
| nanobanana | AI image generation and editing | [zhongweili/nanobanana-mcp-server](https://github.com/zhongweili/nanobanana-mcp-server) |
| slack | Slack history, search, thread replies (per workspace) | [korotovsky/slack-mcp-server](https://github.com/korotovsky/slack-mcp-server) |
| [obsidian-graph](https://github.com/drewburchfield/obsidian-graph) | Semantic knowledge-graph companion to [Kindling](https://github.com/drewburchfield/kindling): Voyage Context-3 embeddings + PostgreSQL/pgvector for graph navigation and semantic search | Custom |
| atlassian | Jira and Confluence (multi-instance) | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian) |
