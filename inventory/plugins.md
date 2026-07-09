# Plugins Inventory

Current as of 2026-07-09. A curated reference of plugins in active use across this setup.

31 plugins across 10 marketplaces. Some load globally in every Claude Code session, others only when working in specific codebases (project-scoped). The setup uses both patterns: globals for everyday work, project-scoped for specialist work that doesn't need to be loaded everywhere.

## Recommended Starter Plugins

If you want a high-leverage starting set rather than the whole catalog below, install these. Add each marketplace once, then install the plugins from it.

Workflow and quality (install regardless of stack):

```bash
# Superpowers: brainstorming, TDD, systematic debugging, verification disciplines
claude plugin marketplace add obra/superpowers-marketplace
claude plugin install superpowers@superpowers-marketplace

# Official catalog: docs lookup, refactoring, commits, CLAUDE.md upkeep, guided feature work
claude plugin marketplace add anthropics/claude-plugins-official
claude plugin install context7@claude-plugins-official
claude plugin install code-simplifier@claude-plugins-official
claude plugin install commit-commands@claude-plugins-official
claude plugin install claude-md-management@claude-plugins-official
claude plugin install feature-dev@claude-plugins-official
```

Frontend and design (if you build UI):

```bash
claude plugin install frontend-design@claude-plugins-official
claude plugin marketplace add pbakaus/impeccable
claude plugin install impeccable@impeccable
```

Language servers (install the ones matching your stack):

```bash
claude plugin install pyright-lsp@claude-plugins-official      # Python
claude plugin install typescript-lsp@claude-plugins-official   # TypeScript / JS
claude plugin install gopls-lsp@claude-plugins-official         # Go
claude plugin install swift-lsp@claude-plugins-official         # Swift
```

For the security plugins (safety-net, codeguard-security, security-guidance, code-review, pr-review-toolkit), see the [security baseline](../workflows/security-baseline.md).

| Category | Plugin | Marketplace | Source | Description |
|----------|--------|-------------|--------|-------------|
| **Development** | feature-dev | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/feature-dev) | Guided feature development with codebase understanding |
| | code-review | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-review) | Code review agents for PRs |
| | pr-review-toolkit | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/pr-review-toolkit) | Comprehensive PR review with specialized agents |
| | commit-commands | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/commit-commands) | Git commit, push, and PR commands |
| | ralph-loop | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/ralph-loop) | Ralph Loop iterative development |
| | code-simplifier | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/code-simplifier) | Code simplification for clarity and maintainability |
| | claude-md-management | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-md-management) | CLAUDE.md auditing and improvement |
| | project-bootstrap | not-my-job | [drewburchfield/project-bootstrap](https://github.com/drewburchfield/project-bootstrap) | Auto-detect language, set up quality tooling, configure hooks |
| | braintrust | not-my-job | [drewburchfield/braintrust](https://github.com/drewburchfield/braintrust) | Multi-CLI orchestration (Antigravity, Codex, Grok, OpenCode, Claude Code) for second opinions and research |
| **Security & Safety** | safety-net | claude-community | [kenryu42/claude-code-safety-net](https://github.com/kenryu42/claude-code-safety-net) | Real-time PreToolUse blocker: intercepts destructive Bash commands (file deletion, force push, database drops) before execution |
| | codeguard-security | project-codeguard | [cosai-oasis/project-codeguard](https://github.com/cosai-oasis/project-codeguard) | Secure coding skill: flags vulnerability patterns as code is written |
| | security-guidance | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/security-guidance) | Security best practices guidance from Anthropic |
| **Design** | impeccable | impeccable | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Design quality toolkit: critique, polish, animate, simplify, harden, audit, and more (18 skills) |
| **Browser & Terminal** | dev-browser | dev-browser-marketplace | [sawyerhood/dev-browser](https://github.com/sawyerhood/dev-browser) | Browser automation with persistent page state |
| **Document & Content** | frontend-design | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/frontend-design) | Production-grade frontend interface design |
| | playground | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/playground) | Interactive HTML playground creation |
| **Data** (project-scoped) | fabric-skills | fabric-collection | [microsoft/skills-for-fabric](https://github.com/microsoft/skills-for-fabric) | Complete bundle: all Microsoft Skills for Fabric for developers and consumers |
| | powerbi-authoring | fabric-collection | [microsoft/skills-for-fabric](https://github.com/microsoft/skills-for-fabric) | Developer skills for authoring Microsoft Power BI solutions |
| **Language Servers** | pyright-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/pyright-lsp) | Python type checking LSP |
| | typescript-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/typescript-lsp) | TypeScript language server |
| | swift-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/swift-lsp) | Swift language server |
| | gopls-lsp | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/gopls-lsp) | Go language server |
| **Writing & Style** | learning-output-style | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/learning-output-style) | Interactive learning output style |
| **Integrations** | context7 | claude-plugins-official | [upstash/context7-mcp](https://github.com/upstash/context7-mcp) | Up-to-date library documentation |
| | linear-cli | linear-cli | [schpet/linear-cli](https://github.com/schpet/linear-cli) | Linear issue management via CLI |
| **Plugin & Skill Dev** | plugin-dev | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Plugin development: skills, hooks, agents, commands, MCP |
| | agent-sdk-dev | claude-plugins-official | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/agent-sdk-dev) | Agent SDK application development |
| **Personal Utilities** | 1password-management | not-my-job | [drewburchfield/1password-management](https://github.com/drewburchfield/1password-management) | 1Password CLI credential management |
| | linkedin-message-triage | not-my-job | [drewburchfield/linkedin-message-triage](https://github.com/drewburchfield/linkedin-message-triage) | LinkedIn inbox review, solicitation filtering, draft replies |
| | markdown-to-confluence | not-my-job | [drewburchfield/markdown-to-confluence](https://github.com/drewburchfield/markdown-to-confluence) | Convert Markdown to Confluence Storage Format (XHTML-based XML) |
| | readme-craft | not-my-job | [drewburchfield/readme-craft](https://github.com/drewburchfield/readme-craft) | Clean, human-sounding README generation |

## Notes

- `claude-plugins-official` is the largest source (18 plugins): agents, hooks, LSPs, code review, output styles, plugin-dev tooling.
- `not-my-job` is drewburchfield's personal marketplace (6 plugins) covering personal utilities and dev workflows.
- `fabric-skills` and `powerbi-authoring` are project-scoped: they load only in the codebases that need them.
- `claude-community` resolves to [anthropics/claude-plugins-community](https://github.com/anthropics/claude-plugins-community), Anthropic's official community catalog, where `safety-net` is listed.
- For the marketplaces these plugins come from (URLs, owners), see [marketplaces.md](marketplaces.md).
