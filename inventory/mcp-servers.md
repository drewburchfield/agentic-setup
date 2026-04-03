# MCP Servers Inventory

12 MCP servers configured for Claude Code, plus additional servers on other harnesses. Google Workspace access (Gmail, Calendar, Drive, Docs, Sheets) is handled by the [gog CLI](https://github.com/drewburchfield/gogcli-safe) rather than MCP servers.

## Docker MCP Toolkit

[Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) is piped into all 4 harnesses via `docker mcp gateway run`. It bundles these services in a single gateway:

- **Obsidian** - Obsidian MCP connected to [Kindling](https://github.com/drewburchfield/kindling) (read/write, search, periodic notes)
- **YouTube Transcript** - Video info, timed transcripts
- **Time** - Current time, timezone conversion
- **Fetch** - HTTP fetching
- **Sequential Thinking** - Structured reasoning
- **Code Mode** - Code execution context

## Claude Code (12 servers)

Two sources (10 user, 2 plugin): user-level config and built-in plugin MCPs.

### User MCPs (`~/.claude.json`)

| Server | Type | Source | Description |
|--------|------|--------|-------------|
| ChatPRD | HTTP (remote) | 3rd party: [chatprd.ai](https://app.chatprd.ai) | Product requirements document generation |
| exa | HTTP (remote) | 3rd party: [exa.ai](https://exa.ai) | Neural search and answer API |
| Google-PSE | stdio | 3rd party, Dockerized via [master_mcp](https://github.com/drewburchfield/master_mcp). Upstream: [@adenot/mcp-google-search](https://github.com/adenot/mcp-google-search) | Google Programmable Search Engine |
| helpscout | stdio | Custom: [drewburchfield/help-scout-mcp-server](https://github.com/drewburchfield/help-scout-mcp-server) | HelpScout customer support conversations |
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) (see above) | Gateway for Obsidian, YouTube, time, fetch, sequential thinking, code mode |
| nanobanana | stdio | 3rd party, Dockerized via [master_mcp](https://github.com/drewburchfield/master_mcp). Upstream: [zhongweili/nanobanana-mcp-server](https://github.com/zhongweili/nanobanana-mcp-server) | AI image generation and editing |
| granola | HTTP (remote) | 3rd party: [granola.ai](https://granola.ai/) (`https://mcp.granola.ai/mcp`) | AI meeting notes: query, list, and get meeting transcripts |
| slack | stdio | 3rd party, Dockerized via [master_mcp](https://github.com/drewburchfield/master_mcp). Upstream: [korotovsky/slack-mcp-server](https://github.com/korotovsky/slack-mcp-server) | Slack channel history, search, thread replies |
| bluebubbles | stdio | Custom: locally cloned [BlueBubbles MCP server](https://github.com/BlueBubbles/bluebubbles-mcp-server) at `~/.claude/mcp-servers/bluebubbles-mcp-server/` | iMessage integration: send/receive messages, search, contacts, chat management |
| pencil | App-exposed | 3rd party: [Pencil app](https://pencil.li/) (auto-exposed when the app is running) | Visual design tool for .pen files: batch design, screenshots, style guides, layout inspection |

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
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) |
| Playwright | stdio | 3rd party: [playwright.dev](https://playwright.dev/) via `npx @playwright/mcp@latest` |

## Codex CLI

**Config:** `~/.codex/config.toml`

| Server | Type | Source |
|--------|------|--------|
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) |
| Playwright | stdio | 3rd party: [playwright.dev](https://playwright.dev/) via `npx @playwright/mcp@latest` |
| pencil | App-exposed | 3rd party: [Pencil app](https://pencil.li/) (auto-exposed when the app is running) |
| linear | remote | 3rd party: [linear.app](https://linear.app/) (`https://mcp.linear.app/mcp`) |

## OpenCode

**Config:** `~/.config/opencode/opencode.json`

| Server | Type | Source |
|--------|------|--------|
| MCP_DOCKER | stdio | [Docker MCP Toolkit](https://www.docker.com/products/mcp-catalog-and-toolkit/) |
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
| [obsidian-graph](https://github.com/drewburchfield/obsidian-graph) | Semantic knowledge graph companion to [Kindling](https://github.com/drewburchfield/kindling). Vector embeddings via Voyage Context-3 with PostgreSQL+pgvector for graph navigation and semantic search over the vault. | Custom |
| atlassian | Jira and Confluence. Supports multiple workspace instances. | [sooperset/mcp-atlassian](https://github.com/sooperset/mcp-atlassian) |
