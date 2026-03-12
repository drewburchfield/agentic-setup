# Apps & Infrastructure

macOS apps and infrastructure that support the agentic setup.

## Infrastructure

| App | Role in Setup | Description |
|-----|---------------|-------------|
| [Docker Desktop](https://www.docker.com/products/docker-desktop/) | Runs MCP servers via Docker MCP Toolkit and master_mcp | Container runtime. The Docker MCP Toolkit gateway (`docker mcp gateway run`) is piped into all 4 harnesses. master_mcp orchestrates additional Dockerized MCP servers (Google-PSE, nanobanana, Slack, obsidian-graph-mcp, Atlassian). |
| [Obsidian](https://obsidian.md/) | Hosts the Knowledge Vault, accessed by MCP_DOCKER's Obsidian service | Markdown-based knowledge management app. Read/write, search, and periodic notes are exposed to all harnesses through the Docker MCP Toolkit. |
| [Sprites](https://sprites.dev/) | Isolated execution environment for running Claude Code or AI-generated code | Stateful sandbox environments from Fly.io. Hardware-isolated Linux computers with checkpoint/restore. Used when you want Claude Code running in a fully isolated environment rather than on your local machine - useful for exploratory work, untrusted code, or situations where local environment pollution is a concern. |
| [1Password](https://1password.com/) | Credential store accessed by the `op` CLI and 1password-management plugin | Password manager and secrets infrastructure. Used through developer workflows including service accounts, environment variable injection, SSH key management, and secret references across projects. The CLI (`op`) and 1password-management plugin provide credential lookups, vault operations, and secure secret sharing. |

## Knowledge Management

| Component | Description |
|-----------|-------------|
| [Knowledge Vault](https://github.com/drewburchfield/knowledge-vault) | A personal knowledge base built in Obsidian that combines two complementary frameworks. **Zettelkasten** handles collection: atomic, densely linked notes that grow organically through connections rather than rigid hierarchies. **CORE** (Collect, Organize, Reflect, Express) handles the lifecycle: capturing raw inputs, structuring them into the Zettelkasten, surfacing patterns through periodic review, and producing outputs from accumulated knowledge. Together they create a system where every note is both a standalone idea and a node in a larger network. (Repo and documentation coming soon.) |
| [obsidian-graph-mcp](https://github.com/drewburchfield/obsidian-graph-mcp) | Graph database companion to the Knowledge Vault. Provides semantic knowledge graph navigation using AI-powered vector embeddings (Voyage Context-3) and PostgreSQL with pgvector. Tightly coupled with the vault by design: every note is both a markdown file in Obsidian and a vector-embedded node in the graph. Exposed as an MCP server, giving all AI harnesses semantic search and graph traversal over the vault. |

## AI Infrastructure

| App | Description |
|-----|-------------|
| [OpenRouter](https://openrouter.ai/) | Unified API gateway for ad hoc access to models across providers (OpenAI, Anthropic, Google, Meta, Mistral, and others). Used for quick model comparisons, testing new releases, and accessing models not available through primary harnesses. |
| [VibeProxy](https://github.com/automazeio/vibeproxy) | macOS menu bar app that routes AI coding tool requests through existing Claude, ChatGPT, Gemini, and other subscriptions. Local proxy on port 8317, handles OAuth and token management automatically. |
| [Devin](https://devin.ai/) | AI software engineer from Cognition. Used for PR reviews via the quality-gate skill (Devin Review categorizes issues by severity and auto-fixes flagged bugs). Also provides [DeepWiki](https://deepwiki.com/) for AI-generated documentation of any GitHub repo, plus internal codebase wikis with architecture diagrams for private repos. |
| [CodeRabbit](https://coderabbit.ai/) | AI-powered code review for pull requests. Automated line-by-line review comments, security analysis, and summary generation on GitHub PRs. |
| [VibeTunnel](https://github.com/amantus-ai/vibetunnel) | Turn any browser into a terminal and command agents remotely. |

## AI Harnesses

Listed in priority order. All share a unified skill library through the sync script.

| Harness | Priority | Description |
|---------|----------|-------------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | Primary | Plugins, skills, hooks, commands, and MCP servers all live here. Source of truth for the setup. |
| [Codex CLI](https://github.com/openai/codex) | Secondary | OpenAI's coding agent. Gets skills via symlink. |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | Tertiary | Google's coding agent. Gets skills via symlink. |
| [OpenCode](https://opencode.ai/) | Fourth | Multi-model coding agent. Gets skills via symlink. |

## Terminals

| App | Description |
|-----|-------------|
| [Warp](https://www.warp.dev/) | AI-native terminal |
| [CMUX](https://www.cmux.dev/) | Native macOS terminal built on libghostty (the Ghostty rendering engine). Vertical tabs with git branch context, notification rings for agent attention, split panes for parallel agent work, embedded browser, and socket API for automation. |

## Editors

| App | Description |
|-----|-------------|
| [VS Code](https://code.visualstudio.com/) | Primary code editor |
| [Sublime Text](https://www.sublimetext.com/) | Lightweight text editor for quick edits |
| [Typora](https://typora.io/) | WYSIWYG Markdown editor for reading and writing documentation |

## Voice & Transcription

| App | Description |
|-----|-------------|
| [Superwhisper](https://superwhisper.com/) | Voice-to-text transcription using local Whisper models. Used for dictating into any text field on macOS. Paired with [macos-mic-keepwarm](https://github.com/drewburchfield/macos-mic-keepwarm) to eliminate push-to-talk activation delay on Bluetooth headsets. |

## Productivity & Communication

| App | Role in Setup | Description |
|-----|---------------|-------------|
| [Things 3](https://culturedcode.com/things/) | Task database accessed by the `clings` CLI and things skill | Personal task management |
| [Slack](https://slack.com/) | Channels exposed via the Slack MCP server | Team communication |
| [Linear](https://linear.app/) | Issues exposed via the Linear plugin MCP | Project and issue tracking |
| [Raycast](https://www.raycast.com/) | Launcher and automation | Extensible launcher with clipboard history, snippets, and scripts |

## Design & Prototyping

Beyond agentic CLIs, these tools handle UI design, prototyping, and image generation. For design work within the agentic workflow itself, the combination of a coding CLI + braintrust plugin + frontend-design skill + nanobanana (image generation) covers most needs.

| Tool | Description |
|------|-------------|
| [Pencil](https://pencil.li/) | Visual design with MCP integration for AI-driven design workflows. The Pencil app auto-exposes an MCP server when running, providing tools for batch design, style guides, screenshots, and layout inspection of `.pen` files. Accessed on Claude Code and Codex CLI. |
| [Stitch](https://stitch.withgoogle.com/) | Google Labs experiment that generates UI designs and frontend code from text prompts or image uploads (whiteboard sketches, screenshots). Exports to Figma or clean frontend code. Powered by Gemini. |
| [v0](https://v0.dev/) | Vercel's AI UI generator. Generates React components with Tailwind from text prompts. Copy-paste into Next.js projects or deploy directly. |
| [Lovable](https://lovable.dev/) | AI-powered full-stack app builder. Generates working apps from natural language descriptions with deployment included. |
| [Paper](https://builtwithpaper.com/) | AI prototyping tool with full creative control. Exports production-ready Kotlin Compose Multiplatform code for iOS, Android, desktop, and web. Designed for handoff to developers or AI coding tools. |
