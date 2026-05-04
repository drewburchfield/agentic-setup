# Plugins Inventory

Current as of 2026-05-04. A curated reference of plugins in active use across this setup.

74 plugins across 15 marketplaces. Some load globally in every Claude Code session, others only when working in specific codebases (project-scoped). The setup uses both patterns: globals for everyday work, project-scoped for specialist work that doesn't need to be loaded everywhere.

| Category | Plugin | Marketplace | Source | Description |
|----------|--------|-------------|--------|-------------|
| **Development** | superpowers | superpowers-marketplace | [obra/superpowers](https://github.com/obra/superpowers) | Development workflows: brainstorming, debugging, TDD, code review, worktrees |
| | feature-dev | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/feature-dev) | Guided feature development with codebase understanding |
| | code-review | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-review) | Code review agents for PRs |
| | pr-review-toolkit | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/pr-review-toolkit) | Comprehensive PR review with specialized agents |
| | commit-commands | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/commit-commands) | Git commit, push, and PR commands |
| | ralph-loop | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop) | Ralph Loop iterative development |
| | code-simplifier | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-simplifier) | Code simplification for clarity and maintainability |
| | claude-md-management | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-md-management) | CLAUDE.md auditing and improvement |
| | claude-code-setup | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-code-setup) | Codebase automation recommendations |
| | project-bootstrap | not-my-job | [drewburchfield/project-bootstrap](https://github.com/drewburchfield/project-bootstrap) | Auto-detect language, set up quality tooling, configure hooks |
| | braintrust | not-my-job | [drewburchfield/braintrust](https://github.com/drewburchfield/braintrust) | Multi-model orchestration (Gemini, Codex, Claude) for second opinions and research |
| **Security & Safety** | safety-net | claude-community | [kenryu42/claude-code-safety-net](https://github.com/kenryu42/claude-code-safety-net) | Real-time PreToolUse blocker: intercepts destructive Bash commands (file deletion, force push, database drops) before execution |
| | codeguard-security | project-codeguard | [cosai-oasis/project-codeguard](https://github.com/cosai-oasis/project-codeguard) | Secure coding skill: flags vulnerability patterns as code is written |
| | security-guidance | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/security-guidance) | Security best practices guidance from Anthropic |
| **Design** | impeccable | impeccable | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Design quality toolkit: critique, polish, animate, simplify, harden, audit, and more (18 skills) |
| **Browser & Terminal** | dev-browser | dev-browser-marketplace | [sawyerhood/dev-browser](https://github.com/sawyerhood/dev-browser) | Browser automation with persistent page state |
| | canvas | claude-canvas | [dvdsgl/claude-canvas](https://github.com/dvdsgl/claude-canvas) | Terminal TUI canvases: calendar, document, flight |
| | warp | claude-code-warp | [warpdotdev/claude-code-warp](https://github.com/warpdotdev/claude-code-warp) | Warp terminal integration for Claude Code |
| **Document & Content** | document-skills | anthropic-agent-skills | [anthropics/skills](https://github.com/anthropics/skills/tree/main/document-skills) | Document creation: PDF, DOCX, PPTX, XLSX, and more |
| | example-skills | anthropic-agent-skills | [anthropics/skills](https://github.com/anthropics/skills/tree/main/example-skills) | Example/template versions of document skills |
| | claude-api | anthropic-agent-skills | [anthropics/skills](https://github.com/anthropics/skills/tree/main/claude-api) | Build apps with Claude API / Anthropic SDK (caching, thinking, tool use) |
| | frontend-design | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/frontend-design) | Production-grade frontend interface design |
| | playground | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/playground) | Interactive HTML playground creation |
| **Data** | dbt | dbt-agent-marketplace | [dbt-labs/dbt-agent-skills](https://github.com/dbt-labs/dbt-agent-skills) | Analytics engineering: build models, write SQL transformations, run tests, troubleshoot dbt jobs |
| | rest-api-pipeline | dlthub-ai-workbench | [dlt-hub/dlthub-ai-workbench](https://github.com/dlt-hub/dlthub-ai-workbench) | Build dlt REST API pipelines with debugging and validation |
| | data-exploration | dlthub-ai-workbench | [dlt-hub/dlthub-ai-workbench](https://github.com/dlt-hub/dlthub-ai-workbench) | Explore loaded pipeline data, build marimo notebooks for analysis |
| | init | dlthub-ai-workbench | [dlt-hub/dlthub-ai-workbench](https://github.com/dlt-hub/dlthub-ai-workbench) | dlt onboarding, secrets setup, toolkit dispatch |
| **Language Servers** | pyright-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/pyright-lsp) | Python type checking LSP |
| | typescript-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/typescript-lsp) | TypeScript language server |
| | swift-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/swift-lsp) | Swift language server |
| | gopls-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/gopls-lsp) | Go language server |
| | clangd-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/clangd-lsp) | C/C++ language server |
| | csharp-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/csharp-lsp) | C# language server |
| | jdtls-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/jdtls-lsp) | Java language server |
| | kotlin-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/kotlin-lsp) | Kotlin language server |
| | lua-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/lua-lsp) | Lua language server |
| | php-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/php-lsp) | PHP language server |
| | rust-analyzer-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/rust-analyzer-lsp) | Rust language server (rust-analyzer) |
| **Writing & Style** | elements-of-style | superpowers-marketplace | [obra/elements-of-style](https://github.com/obra/elements-of-style) | Writing guidance based on Strunk's The Elements of Style |
| | learning-output-style | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/learning-output-style) | Interactive learning output style |
| | explanatory-output-style | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/explanatory-output-style) | Explanatory output style mode |
| **Integrations** | context7 | claude-plugins-official | [upstash/context7-mcp](https://github.com/upstash/context7-mcp) | Up-to-date library documentation |
| | linear-cli | linear-cli | [schpet/linear-cli](https://github.com/schpet/linear-cli) | Linear issue management via CLI |
| | superwhisper | superwhisper | [superultrainc/superwhisper-claude-code](https://github.com/superultrainc/superwhisper-claude-code) | Superwhisper voice transcription integration |
| **Plugin & Skill Dev** | plugin-dev | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Plugin development: skills, hooks, agents, commands, MCP |
| | agent-sdk-dev | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/agent-sdk-dev) | Agent SDK application development |
| | superpowers-developing-for-claude-code | superpowers-marketplace | [obra/superpowers-developing-for-claude-code](https://github.com/obra/superpowers-developing-for-claude-code) | Plugin development workflows and Claude Code documentation |
| | hookify | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/hookify) | Hook generation from natural language |
| | skill-creator | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/skill-creator) | Skill creation and deployment |
| | example-plugin | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/example-plugin) | Example/template plugin for plugin development |
| **Personal Utilities** | 1password-management | not-my-job | [drewburchfield/1password-management](https://github.com/drewburchfield/1password-management) | 1Password CLI credential management |
| | openclaw-1password | not-my-job | [drewburchfield/openclaw-1password](https://github.com/drewburchfield/openclaw-1password) | OpenClaw + 1Password SecretRef integration with setup automation |
| | cre-property-research | not-my-job | [drewburchfield/cre-property-research](https://github.com/drewburchfield/cre-property-research) | Commercial real estate property research and market analysis |
| | happenstance-navigator | not-my-job | [drewburchfield/happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Network intelligence: research people, search networks, compound workflows |
| | helpscout-navigator | not-my-job | [drewburchfield/helpscout-navigator](https://github.com/drewburchfield/helpscout-navigator) | HelpScout tool selection, sequencing, and common mistake prevention |
| | linkedin-message-triage | not-my-job | [drewburchfield/linkedin-message-triage](https://github.com/drewburchfield/linkedin-message-triage) | LinkedIn inbox review, solicitation filtering, draft replies |
| | markdown-to-confluence | not-my-job | [drewburchfield/markdown-to-confluence](https://github.com/drewburchfield/markdown-to-confluence) | Convert Markdown to Confluence Storage Format (XHTML-based XML) |
| | readme-craft | not-my-job | [drewburchfield/readme-craft](https://github.com/drewburchfield/readme-craft) | Clean, human-sounding README generation |
| | subscription-cleanse | not-my-job | [drewburchfield/subscription-cleanse](https://github.com/drewburchfield/subscription-cleanse) | Subscription audit from bank CSV + email recon |
| **Knowledge Work** | cowork-plugin-management | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Create, customize, and manage plugins tailored to your organization's tools and workflows |
| | customer-support | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Triage tickets, draft responses, escalate issues, build knowledge base |
| | data | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Write SQL, explore datasets, generate insights, build visualizations and dashboards |
| | design | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Critique, design system management, UX writing, accessibility audits, research synthesis, dev handoff |
| | engineering | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Standups, code review, architecture decisions, incident response, technical documentation |
| | enterprise-search | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Search across all company tools (email, chat, documents, wikis) in one place |
| | finance | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Journal entries, reconciliation, financial statements, variance analysis, audit prep |
| | human-resources | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Recruiting, onboarding, performance reviews, compensation analysis, policy guidance |
| | legal | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Contract review, NDA triage, compliance workflows, legal briefs, precedent research |
| | marketing | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Content creation, campaign planning, performance analysis, brand voice, competitor tracking |
| | operations | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Vendor management, process documentation, change management, capacity planning |
| | partner-built | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Partner plugins: Apollo (sales prospecting), Brand Voice, Common Room (GTM), Slack |
| | product-management | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Feature specs, roadmap planning, user research synthesis, stakeholder updates |
| | productivity | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Task management, day planning, work context memory, calendar/email/chat sync |
| | sales | knowledge-work-plugins | [anthropics/knowledge-work-plugins](https://github.com/anthropics/knowledge-work-plugins) | Prospecting, outreach, deal strategy, call prep, pipeline management |

## Notes

- `claude-plugins-official` is the largest source (30 plugins): agents, hooks, LSPs, document tools, output styles, plugin-dev tooling.
- `not-my-job` is drewburchfield's personal marketplace (11 plugins) covering personal utilities and dev workflows.
- `knowledge-work-plugins` is Anthropic's role-based bundle (15 plugins): entire functional areas as composed tool sets.
- `claude-community` (formerly `cc-marketplace` before the remote rename) is where `safety-net` comes from.
- For the marketplaces these plugins come from (URLs, owners), see [marketplaces.md](marketplaces.md).
