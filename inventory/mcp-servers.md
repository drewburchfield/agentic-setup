# MCP Servers Inventory

15 MCP servers configured for Claude Code, plus additional servers on other harnesses. Google Workspace access (Gmail, Calendar, Drive, Docs, Sheets) is handled by the [gog CLI](https://github.com/drewburchfield/gogcli-safe) rather than MCP servers.

## Docker MCP Toolkit

[Docker MCP Toolkit](https://docs.docker.com/desktop/features/gordon-mcp/) is piped into all 4 harnesses via `docker mcp gateway run`. It bundles these services in a single gateway:

- **Obsidian** - Obsidian MCP connected to Knowledge Vault (read/write, search, periodic notes)
- **YouTube Transcript** - Video info, timed transcripts
- **Time** - Current time, timezone conversion
- **Fetch** - HTTP fetching
- **Sequential Thinking** - Structured reasoning
- **Code Mode** - Code execution context

## Claude Code (15 servers)

Three sources (8 user, 5 claude.ai, 2 plugin): user-level config, claude.ai remote connectors, and built-in plugin MCPs.

### User MCPs (`~/.claude.json`)

| Server | Type | Source | Description |
|--------|------|--------|-------------|
| ChatPRD | HTTP (remote) | 3rd party: [chatprd.ai](https://app.chatprd.ai) | Product requirements document generation |
| exa | HTTP (remote) | 3rd party: [exa.ai](https://exa.ai) | Neural search and answer API |
| Google-PSE | stdio | 3rd party, Dockerized via [master_mcp](https://github.com/drewburchfield/master_mcp). Upstream: [@adenot/mcp-google-search](https://github.com/adenot/mcp-google-search) | Google Programmable Search Engine |
| helpscout | stdio | Custom: [drewburchfield/help-scout-mcp-server](https://github.com/drewburchfield/help-scout-mcp-server) | HelpScout customer support conversations |
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://docs.docker.com/desktop/features/gordon-mcp/) (see above) | Gateway for Obsidian, YouTube, time, fetch, sequential thinking, code mode |
| nanobanana | stdio | 3rd party, Dockerized via [master_mcp](https://github.com/drewburchfield/master_mcp). Upstream: [zhongweili/nanobanana-mcp-server](https://github.com/zhongweili/nanobanana-mcp-server) | AI image generation and editing |
| granola | HTTP (remote) | 3rd party: [granola.ai](https://granola.ai/) (`https://mcp.granola.ai/mcp`) | AI meeting notes: query, list, and get meeting transcripts |
| slack | stdio | 3rd party, Dockerized via [master_mcp](https://github.com/drewburchfield/master_mcp). Upstream: [korotovsky/slack-mcp-server](https://github.com/korotovsky/slack-mcp-server) | Slack channel history, search, thread replies |

### claude.ai Remote Connectors

Managed through the claude.ai account, not local config files.

| Server | Status | Upstream |
|--------|--------|----------|
| claude.ai HubSpot | needs auth | [HubSpot MCP](https://www.hubspot.com/) |
| claude.ai Linear | connected | [Linear MCP](https://linear.app/) |
| claude.ai Mermaid Chart | connected | [Mermaid Chart MCP](https://www.mermaidchart.com/) |
| claude.ai Sentry | needs auth | [Sentry MCP](https://sentry.io/) |
| claude.ai Zapier (Gmail and more) | needs auth | [Zapier MCP](https://zapier.com/) |

### Built-in Plugin MCPs

Provided automatically by installed plugins.

| Server | Source Plugin | Upstream |
|--------|-------------|----------|
| plugin:context7:context7 | context7 | [context7.com](https://context7.com/) |
| plugin:linear:linear | linear | [linear.app](https://linear.app/) |

## Gemini CLI

**Config:** `~/.gemini/settings.json`

| Server | Type | Source |
|--------|------|--------|
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://docs.docker.com/desktop/features/gordon-mcp/) |
| Playwright | stdio | 3rd party: [playwright.dev](https://playwright.dev/) via `npx @playwright/mcp@latest` |

## Codex CLI

**Config:** `~/.codex/config.toml`

| Server | Type | Source |
|--------|------|--------|
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://docs.docker.com/desktop/features/gordon-mcp/) |
| Playwright | stdio | 3rd party: [playwright.dev](https://playwright.dev/) via `npx @playwright/mcp@latest` |
| pencil | stdio | 3rd party: [Pencil app](https://pencil.li/) (bundled MCP server binary) |
| linear | remote | 3rd party: [linear.app](https://linear.app/) (`https://mcp.linear.app/mcp`) |

## OpenCode

**Config:** `~/.config/opencode/opencode.json`

| Server | Type | Source |
|--------|------|--------|
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://docs.docker.com/desktop/features/gordon-mcp/) |
| zai-vision | local | 3rd party: [Z.AI](https://docs.z.ai/devpack/tool/opencode) via `npx @z_ai/mcp-server` |
| zai-search | remote | 3rd party: [Z.AI](https://docs.z.ai/devpack/tool/opencode) (`https://api.z.ai/api/mcp/web_search_prime/mcp`) |
| zai-reader | remote | 3rd party: [Z.AI](https://docs.z.ai/devpack/tool/opencode) (`https://api.z.ai/api/mcp/web_reader/mcp`) |
| zai-zread | remote | 3rd party: [Z.AI](https://docs.z.ai/devpack/tool/opencode) (`https://api.z.ai/api/mcp/zread/mcp`) |

## Infrastructure: master_mcp

[master_mcp](https://github.com/drewburchfield/master_mcp) orchestrates Dockerized MCP servers via docker-compose. Several of the Claude Code user MCP servers above run through it, alongside custom services.

| Service | Description | Upstream |
|---------|-------------|----------|
| google-search | Google Programmable Search Engine | [adenot/mcp-google-search](https://github.com/adenot/mcp-google-search) |
| nanobanana | AI image generation and editing | [zhongweili/nanobanana-mcp-server](https://github.com/zhongweili/nanobanana-mcp-server) |
| slack-mcp | Slack channel history, search, thread replies | [korotovsky/slack-mcp-server](https://github.com/korotovsky/slack-mcp-server) |
| [obsidian-graph-mcp](https://github.com/drewburchfield/obsidian-graph-mcp) | Semantic knowledge graph companion to the [Knowledge Vault](https://github.com/drewburchfield/knowledge-vault). Vector embeddings via Voyage Context-3 with PostgreSQL+pgvector for graph navigation and semantic search over the vault. | Custom |
| atlassian | Jira and Confluence. Supports multiple workspace instances. | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian) |

## Summary by Harness

| Harness | Total Servers | Unique to This Harness |
|---------|--------------|----------------------|
| Claude Code | 15 | ChatPRD, exa, Google-PSE, granola, helpscout, nanobanana, slack, MCP_DOCKER, 5 claude.ai connectors, 2 plugin MCPs |
| Gemini CLI | 2 | - |
| Codex CLI | 4 | pencil, linear |
| OpenCode | 5 | zai-vision, zai-search, zai-reader, zai-zread |
