# Skills Inventory

78 unique skills across personal and plugin sources.

## Personal Skills (10)

Located at `~/.claude/skills/`. These are not from any plugin or marketplace.

| Skill | Dependency | Description |
|-------|-----------|-------------|
| agent-browser | [agent-browser CLI](https://github.com/vercel-labs/agent-browser) | Browser automation for AI agents. Navigate pages, fill forms, click buttons, take screenshots, extract data. |
| bird | [@steipete/bird](https://github.com/steipete/bird) (`npm install -g @steipete/bird`) | Read tweets, search Twitter/X, fetch threads, check mentions, get bookmarks, look up users, find trending topics. |
| de-ai-ify | None | Remove AI-generated jargon and restore human voice to text. |
| design-principles | None | Enforce a precise, minimal design system inspired by Linear, Notion, and Stripe for dashboards and admin interfaces. |
| dogfood | [agent-browser CLI](https://github.com/vercel-labs/agent-browser) | Systematic web app QA: explore, find bugs, produce structured report with screenshots and repro videos. |
| exa | [Exa MCP server](https://exa.ai) | Neural search and answer APIs for finding specific, technical content on the web. |
| gog | [drewburchfield/gogcli-safe](https://github.com/drewburchfield/gogcli-safe) (`brew install drewburchfield/tap/gog-safe`) | Google Workspace CLI: Gmail, Calendar, Chat, Drive, Docs, Sheets, Contacts, Tasks. Fork of steipete/gogcli with compile-time safety profiles. |
| remotion-best-practices | None | Best practices for Remotion video creation in React. |
| things | [clings CLI](https://github.com/drewburchfield/clings) (`brew install drewburchfield/tap/clings`) | Things 3 task management: read, create, update, complete, or search tasks and projects. |
| thinking-partner | None | Collaborative thinking partner for exploring complex problems through careful questioning, not rushing to solutions. |

## Plugin Skills (67 unique)

### From [superpowers](https://github.com/obra/superpowers) (superpowers-marketplace)

| Skill | Description |
|-------|-------------|
| brainstorming | Explore user intent, requirements, and design before implementation. |
| dispatching-parallel-agents | Dispatch 2+ independent tasks without shared state. |
| executing-plans | Execute implementation plans with review checkpoints. |
| finishing-a-development-branch | Guide merge, PR, or cleanup after implementation completes. |
| receiving-code-review | Technical rigor when receiving code review feedback. |
| requesting-code-review | Verify work meets requirements before merging. |
| subagent-driven-development | Execute implementation plans with independent tasks in session. |
| systematic-debugging | Debug any bug, test failure, or unexpected behavior before proposing fixes. |
| test-driven-development | Write tests before implementation code. |
| using-git-worktrees | Isolated git worktrees for feature work. |
| using-superpowers | Establishes how to find and use skills at conversation start. |
| verification-before-completion | Run verification commands before claiming work is done. |
| writing-plans | Plan multi-step tasks before touching code. |
| writing-skills | Create, edit, and verify skills before deployment. |

### From [elements-of-style](https://github.com/obra/elements-of-style) (superpowers-marketplace)

| Skill | Description |
|-------|-------------|
| writing-clearly-and-concisely | Strunk's writing rules applied to any prose. |

### From [superpowers-developing-for-claude-code](https://github.com/obra/superpowers-developing-for-claude-code) (superpowers-marketplace)

| Skill | Description |
|-------|-------------|
| developing-claude-code-plugins | Plugin lifecycle workflows: creating, modifying, testing, releasing. |
| professional-greeting | Professional greeting template. |
| workflow | Plugin workflow feature demonstration. |
| working-with-claude-code | Comprehensive Claude Code documentation reference. |

### From [document-skills](https://github.com/anthropics/skills) (anthropic-agent-skills)

| Skill | Description |
|-------|-------------|
| algorithmic-art | Algorithmic art with p5.js, seeded randomness, interactive parameter exploration. |
| brand-guidelines | Anthropic brand colors and typography for artifacts. |
| canvas-design | Create visual art in .png and .pdf using design philosophy. |
| doc-coauthoring | Structured workflow for co-authoring documentation. |
| docx | Word document creation, editing, tracked changes, comments. |
| frontend-design | Production-grade frontend interfaces with high design quality. |
| internal-comms | Internal communications: status reports, updates, newsletters, FAQs. |
| mcp-builder | Guide for creating MCP servers in Python (FastMCP) or Node/TypeScript. |
| pdf | PDF extraction, creation, merging, splitting, and form handling. |
| pptx | PowerPoint creation, editing, layouts, speaker notes. |
| skill-creator | Guide for creating skills that extend Claude's capabilities. |
| slack-gif-creator | Animated GIFs optimized for Slack with constraints and validation. |
| theme-factory | 10 pre-set themes for slides, docs, reportings, landing pages. |
| web-artifacts-builder | Multi-component HTML artifacts with React, Tailwind, shadcn/ui. |
| webapp-testing | Test local web apps using Playwright with screenshots and logs. |
| xlsx | Spreadsheet creation, editing, analysis, formulas, visualization. |

### From [claude-plugins-official](https://github.com/anthropics/claude-plugins-official) (10 skills across 4 plugins)

| Skill | Plugin | Description |
|-------|--------|-------------|
| agent-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Agent structure, system prompts, triggering conditions for plugins. |
| claude-automation-recommender | [claude-code-setup](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-code-setup) | Analyze codebases and recommend Claude Code automations. |
| claude-md-improver | [claude-md-management](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-md-management) | Audit and improve CLAUDE.md files in repositories. |
| command-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Slash command structure, YAML frontmatter, dynamic arguments. |
| hook-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Create hooks for PreToolUse, PostToolUse, Stop, SessionStart, etc. |
| mcp-integration | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | MCP server integration into Claude Code plugins. |
| playground | [playground](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/playground) | Interactive HTML playgrounds with live preview and prompt export. |
| plugin-settings | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | .local.md pattern for per-project plugin configuration. |
| plugin-structure | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Plugin directory layout, manifest, component organization. |
| skill-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Skill structure, progressive disclosure, best practices. |

### From [claude-canvas](https://github.com/dvdsgl/claude-canvas) (claude-canvas)

| Skill | Description |
|-------|-------------|
| calendar | Calendar canvas for displaying events and picking meeting times. |
| canvas | Spawn interactive terminal canvases for calendars, documents, flight booking. |
| document | Document canvas for displaying and editing markdown content. |
| flight | Flight canvas for comparing flights and selecting seats. |

### From [dev-browser](https://github.com/sawyerhood/dev-browser) (dev-browser-marketplace)

| Skill | Description |
|-------|-------------|
| dev-browser | Browser automation with persistent page state, Chrome extension mode. |

### From [codeguard-security](https://github.com/cosai-oasis/project-codeguard) (project-codeguard)

| Skill | Description |
|-------|-------------|
| software-security | Secure coding practices integrated with Project CodeGuard. |

### From [helpscout-mcp](https://github.com/drewburchfield/help-scout-mcp-server) (personal marketplace)

| Skill | Plugin | Description |
|-------|--------|-------------|
| helpscout-navigator | [helpscout-navigator](https://github.com/drewburchfield/helpscout-navigator) | HelpScout tool selection, sequencing, and common mistake prevention. |

### From [not-my-job](https://github.com/drewburchfield/not-my-job) (personal marketplace)

| Skill | Plugin | Description |
|-------|--------|-------------|
| 1password-management | [1password-management](https://github.com/drewburchfield/1password-management) | 1Password CLI (op) credential management with proper syntax and best practices. |
| 1password-openclaw | [openclaw-1password](https://github.com/drewburchfield/openclaw-1password) | OpenClaw + 1Password SecretRef setup, diagnosis, repair, and version-aware adaptation. |
| braintrust | [braintrust](https://github.com/drewburchfield/braintrust) | Orchestrate Gemini, Codex, Claude Code for second opinions and parallel research. |
| subscription-cleanse | [subscription-cleanse](https://github.com/drewburchfield/subscription-cleanse) | Subscription audit combining bank CSV analysis and email recon. |
| cre-property-research | [cre-property-research](https://github.com/drewburchfield/cre-property-research) | Commercial real estate property research and market analysis. |
| linkedin-message-triage | [linkedin-message-triage](https://github.com/drewburchfield/linkedin-message-triage) | Review LinkedIn messages, filter solicitations, draft replies. |
| markdown-to-confluence | [markdown-to-confluence](https://github.com/drewburchfield/markdown-to-confluence) | Convert Markdown to Confluence Storage Format (XHTML-based XML). |
| happenstance | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Research people and search professional network via Happenstance API. |
| deep-search | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Network search + automatic person research in one compound workflow. |
| batch-prospect | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Exhaustive network search with pagination and CSV/markdown export. |
| meeting-prep | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Briefing prep combining person research with mutual connections. |
| network-scan | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Compare network groups by scanning for roles across groups. |
| warm-intro | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Find mutual connections for introductions to target company/role. |
| project-bootstrap | [project-bootstrap](https://github.com/drewburchfield/project-bootstrap) | Auto-detect language, set up quality tooling, configure hooks. |
| quality-gate | [project-bootstrap](https://github.com/drewburchfield/project-bootstrap) | Compound PR review with agent reviews, Devin.ai integration, and remediation cycles. |
| readme-craft | [readme-craft](https://github.com/drewburchfield/readme-craft) | README generation. |
