# Skills Inventory

146 skills across personal and plugin sources.

## Personal Skills (36)

Located at `~/.claude/skills/`. These are not from any plugin or marketplace.

| Skill | Dependency | Description |
|-------|-----------|-------------|
| agent-browser | [agent-browser CLI](https://github.com/vercel-labs/agent-browser) | Browser automation for AI agents. Navigate pages, fill forms, click buttons, take screenshots, extract data. |
| asc-app-create-ui | App Store Connect web session | Create an App Store Connect app via iris API. |
| asc-iap-attach | App Store Connect | Attach in-app purchases and subscriptions to an app version for review. |
| asc-privacy-nutrition-labels | App Store Connect | Set up privacy nutrition labels (data collection declarations) for an app. |
| asc-team-key-create | App Store Connect | Create a new ASC Team API Key with Admin permissions and store the .p8 securely. |
| bird | [@steipete/bird](https://github.com/steipete/bird) (`npm install -g @steipete/bird`) | Read tweets, search Twitter/X, fetch threads, check mentions, look up users. |
| caveman | None | Ultra-compressed communication mode. Cuts token usage ~75% while preserving accuracy. |
| de-ai-ify | None | Remove AI-generated jargon and restore human voice to text. |
| design-principles | None | Enforce a precise, minimal design system inspired by Linear, Notion, and Stripe. |
| diagnose | None | Disciplined diagnosis loop: reproduce, minimise, hypothesise, instrument, fix. |
| docfetch | None | Fetch the latest version of any external API, SDK, or library documentation on demand. |
| dogfood | [agent-browser CLI](https://github.com/vercel-labs/agent-browser) | Systematic web app QA: explore, find bugs, produce structured report with screenshots and repro videos. |
| exa | [Exa MCP server](https://exa.ai) | Neural search and answer APIs for finding specific, technical content on the web. |
| find-skills | None | Discover and install agent skills when looking for specific functionality. |
| generated-artifact-cleanup | None | Clean up iterative generated artifacts (drafts, v1/v2, renders, exports) without deleting work. |
| gitbutler | [GitButler](https://gitbutler.com/) | Commit, push, branch, manage version control via GitButler. Replaces direct git usage. |
| gog | [drewburchfield/gogcli-safe](https://github.com/drewburchfield/gogcli-safe) (`brew install drewburchfield/tap/gog-safe`) | Google Workspace CLI: Gmail, Calendar, Chat, Drive, Docs, Sheets, Contacts, Tasks. |
| grill-me | None | Interview the user relentlessly about a plan or design until reaching shared understanding. |
| grill-with-docs | None | Grilling that updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. |
| hex | [Hex](https://hex.tech) | Programmatically interact with Hex: create projects, add cells, run queries, build dashboards. |
| improve-codebase-architecture | None | Find deepening opportunities informed by CONTEXT.md domain language and docs/adr/ decisions. |
| make-interfaces-feel-better | [jakubkrehel/make-interfaces-feel-better](https://github.com/jakubkrehel/make-interfaces-feel-better) | Design engineering details: text wrapping, concentric radius, optical alignment, animations. |
| newsletter-processor | None | Process newsletters from inbox into structured knowledge artifacts. |
| nlm-skill | [nlm CLI](https://github.com/danielcorin/nlm) | Expert guide for the NotebookLM CLI and MCP server. |
| quality-gate | None | Full PR review cycle: agent reviews, Devin.ai integration, CodeRabbit, and remediation loops. |
| remotion-best-practices | None | Best practices for Remotion video creation in React. |
| setup-matt-pocock-skills | None | Configure the agent-skills block in AGENTS.md/CLAUDE.md so engineering skills know the project. |
| tdd | None | Test-driven development with red-green-refactor loop. |
| things | [clings CLI](https://github.com/drewburchfield/clings) (`brew install drewburchfield/tap/clings`) | Things 3 task management: read, create, update, complete tasks and projects. |
| thinking-partner | None | Collaborative thinking partner for exploring complex problems through careful questioning. |
| to-issues | None | Break a plan, spec, or PRD into independently-grabbable issues using tracer-bullet vertical slices. |
| to-prd | None | Turn the current conversation context into a PRD published to the project tracker. |
| triage | None | Triage issues through a state machine driven by triage roles. |
| write-a-skill | None | Create new agent skills with proper structure, progressive disclosure, and bundled resources. |
| zero | [zero CLI](https://www.zero-tools.com/) | Discover and call paid AI capabilities and external services with automatic x402 payment. |
| zoom-out | None | Tell the agent to zoom out for broader context or higher-level perspective. |

## Plugin Skills (110)

### From [superpowers](https://github.com/obra/superpowers) (superpowers-marketplace)

| Skill | Description |
|-------|-------------|
| brainstorming | Explore user intent, requirements, and design before implementation. |
| dispatching-parallel-agents | Dispatch 2+ independent tasks without shared state or sequential dependencies. |
| executing-plans | Execute implementation plans in a separate session with review checkpoints. |
| finishing-a-development-branch | Guide merge, PR, or cleanup decisions after implementation completes. |
| receiving-code-review | Apply technical rigor when receiving review feedback before implementing suggestions. |
| requesting-code-review | Verify work meets requirements before merging or shipping. |
| subagent-driven-development | Execute implementation plans with independent tasks in the current session. |
| systematic-debugging | Debug any bug, test failure, or unexpected behavior before proposing fixes. |
| test-driven-development | Write tests before implementation code. |
| using-git-worktrees | Create isolated git worktrees for feature work. |
| using-superpowers | Establish how to find and use skills at conversation start. |
| verification-before-completion | Run verification commands before claiming work is done. |
| writing-plans | Plan multi-step tasks before touching code. |
| writing-skills | Create, edit, and verify skills before deployment. |

### From [elements-of-style](https://github.com/obra/elements-of-style) (superpowers-marketplace)

| Skill | Description |
|-------|-------------|
| writing-clearly-and-concisely | Apply Strunk's writing rules to any prose humans will read. |

### From [superpowers-developing-for-claude-code](https://github.com/obra/superpowers-developing-for-claude-code) (superpowers-marketplace)

| Skill | Description |
|-------|-------------|
| developing-claude-code-plugins | Plugin lifecycle workflows: creating, modifying, testing, releasing, maintaining. |
| professional-greeting | Professional greeting template. |
| workflow | Demonstrate plugin workflow features. |
| working-with-claude-code | Comprehensive Claude Code documentation reference for all features. |

### From [document-skills](https://github.com/anthropics/skills/tree/main/document-skills) (anthropic-agent-skills)

| Skill | Description |
|-------|-------------|
| docx | Word document creation, editing, tracked changes, comments, find-and-replace. |
| pdf | PDF extraction, creation, merging, splitting, rotation, watermarks, OCR, form filling. |
| pptx | PowerPoint creation, editing, layouts, speaker notes, slide manipulation. |
| xlsx | Spreadsheet creation, editing, formula computation, charting, data cleaning. |

### From [example-skills](https://github.com/anthropics/skills/tree/main/example-skills) (anthropic-agent-skills)

| Skill | Description |
|-------|-------------|
| algorithmic-art | Algorithmic art with p5.js: seeded randomness, interactive parameter exploration, flow fields. |
| brand-guidelines | Anthropic's official brand colors and typography for artifacts. |
| canvas-design | Visual art in .png and .pdf using design philosophy. |
| doc-coauthoring | Structured workflow for co-authoring documentation, proposals, and specs. |
| internal-comms | Internal communications: status reports, leadership updates, FAQs, incident reports. |
| mcp-builder | Guide for creating MCP servers in Python (FastMCP) or Node/TypeScript. |
| skill-creator | Create, edit, and optimize skills; run evals and benchmarks. |
| slack-gif-creator | Animated GIFs optimized for Slack with constraints and validation. |
| theme-factory | 10 pre-set themes for slides, docs, reports, landing pages. |
| web-artifacts-builder | Multi-component HTML artifacts with React, Tailwind, shadcn/ui. |
| webapp-testing | Test local web apps using Playwright with screenshots and console logs. |

### From [claude-api](https://github.com/anthropics/skills/tree/main/claude-api) (anthropic-agent-skills)

| Skill | Description |
|-------|-------------|
| claude-api | Build apps with the Claude API or Anthropic SDK: caching, thinking, tool use, batch, files, citations. |

### From [claude-plugins-official](https://github.com/anthropics/claude-plugins-official) (anthropic, 11 skills across 5 plugins)

| Skill | Plugin | Description |
|-------|--------|-------------|
| agent-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Agent structure, system prompts, triggering conditions for plugins. |
| claude-automation-recommender | [claude-code-setup](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-code-setup) | Analyze codebases and recommend Claude Code automations. |
| claude-md-improver | [claude-md-management](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/claude-md-management) | Audit and improve CLAUDE.md files in repositories. |
| command-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Slash command structure, YAML frontmatter, dynamic arguments. |
| frontend-design | [frontend-design](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/frontend-design) | Production-grade frontend interfaces with high design quality. |
| hook-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Create hooks for PreToolUse, PostToolUse, Stop, SessionStart, and other events. |
| mcp-integration | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | MCP server integration into Claude Code plugins. |
| playground | [playground](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/playground) | Interactive HTML playgrounds with live preview and prompt export. |
| plugin-settings | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | `.local.md` pattern for per-project plugin configuration. |
| plugin-structure | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Plugin directory layout, manifest configuration, component organization. |
| skill-development | [plugin-dev](https://github.com/anthropics/claude-plugins-official/tree/main/plugins/plugin-dev) | Skill structure, progressive disclosure, best practices. |

### From [canvas](https://github.com/dvdsgl/claude-canvas) (claude-canvas)

| Skill | Description |
|-------|-------------|
| calendar | Calendar canvas for displaying events and picking meeting times. |
| canvas | Spawn interactive terminal canvases for calendars, documents, flight booking. |
| document | Document canvas for displaying and editing markdown content. |
| flight | Flight canvas for comparing flights and selecting seats. |

### From [dbt](https://github.com/dbt-labs/dbt-agent-skills) (dbt-agent-marketplace)

| Skill | Description |
|-------|-------------|
| adding-dbt-unit-test | Create unit test YAML definitions that mock upstream model inputs and validate expected outputs. |
| answering-natural-language-questions-with-dbt | Run SQL via dbt's Semantic Layer or ad-hoc to answer business questions. |
| building-dbt-semantic-layer | Create or modify Semantic Layer components: models, metrics, dimensions, entities. |
| configuring-dbt-mcp-server | Generate MCP server configuration JSON, resolve auth, validate connectivity. |
| fetching-dbt-docs | Retrieve and search dbt documentation pages in LLM-friendly markdown. |
| running-dbt-commands | Format and execute dbt CLI commands with the correct executable and parameters. |
| troubleshooting-dbt-job-errors | Diagnose dbt Cloud job failures via logs, Admin API, git history, and data investigation. |
| using-dbt-for-analytics-engineering | Build and modify dbt models, write SQL transformations, create tests. |
| working-with-dbt-mesh | Implement dbt Mesh governance: contracts, access modifiers, groups, versioning, cross-project refs. |

### From [dev-browser](https://github.com/sawyerhood/dev-browser) (dev-browser-marketplace)

| Skill | Description |
|-------|-------------|
| dev-browser | Browser automation with persistent page state via Chrome extension. |

### From [dlthub-ai-workbench](https://github.com/dlt-hub/dlthub-ai-workbench) (dlthub-ai-workbench, 12 skills across 3 plugins)

| Skill | Plugin | Description |
|-------|--------|-------------|
| adjust-endpoint | rest-api-pipeline | Adjust a working pipeline for production: remove dev limits, configure incremental loading. |
| build-notebook | data-exploration | Build a marimo notebook from an analysis_plan.md artifact. |
| create-rest-api-pipeline | rest-api-pipeline | Create a dlt REST API pipeline for any generic REST/HTTP source. |
| debug-pipeline | rest-api-pipeline | Debug and inspect a dlt pipeline: traces, load packages, schema, error diagnosis. |
| explore-data | data-exploration | Explore loaded pipeline data: charts, summaries, dashboards. |
| find-source | rest-api-pipeline | Find a dlt source for a given API or data provider. |
| improve-skills | init | Capture session learnings (debug patterns, data issues, queries) into skill updates. |
| new-endpoint | rest-api-pipeline | Add a new REST API endpoint/resource to an existing pipeline. |
| setup-secrets | init | Safely manage dlt secrets in `*.secrets.toml`. |
| toolkit-dispatch | init | Help users figure out what they can build with dlt and which workflow to start. |
| validate-data | rest-api-pipeline | Validate schema and data after a successful pipeline load. |
| view-data | rest-api-pipeline | Query, explore, or view data loaded by a dlt pipeline. |

### From [impeccable](https://github.com/pbakaus/impeccable) (impeccable)

| Skill | Description |
|-------|-------------|
| adapt | Adapt designs across screen sizes, devices, and contexts. |
| animate | Add purposeful animations, micro-interactions, and motion effects. |
| audit | Comprehensive interface audit across accessibility, performance, theming, anti-patterns. |
| bolder | Amplify safe or boring designs to be more visually interesting. |
| clarify | Improve unclear UX copy, error messages, labels, and instructions. |
| colorize | Add strategic color to monochromatic or visually flat features. |
| critique | Evaluate design effectiveness from a UX perspective with quantitative scoring. |
| delight | Add moments of joy, personality, and unexpected touches. |
| distill | Strip designs to their essence by removing unnecessary complexity. |
| harden | Make interfaces production-ready: error handling, empty states, i18n, edge cases. |
| impeccable | Master skill that routes to the right sub-skill for the design task. |
| layout | Improve layout, spacing, and visual rhythm. |
| optimize | Diagnose and fix UI performance: loading, rendering, animations, bundle size. |
| overdrive | Push interfaces past conventional limits: shaders, spring physics, scroll-driven reveals. |
| polish | Final quality pass: alignment, spacing, consistency, micro-details before shipping. |
| quieter | Tone down overly bold or visually aggressive designs. |
| shape | Plan UX and UI for a feature before code: discovery interview, design brief. |
| typeset | Improve typography: font choices, hierarchy, sizing, weight, readability. |

### From [linear-cli](https://github.com/schpet/linear-cli) (linear-cli)

| Skill | Description |
|-------|-------------|
| linear-cli | Manage Linear issues from the command line. |
| release | Make a release: create release branches, prepare release notes, publish versions. |

### From [not-my-job](https://github.com/drewburchfield/not-my-job) (drewburchfield's personal marketplace, 16 skills across 11 plugins)

| Skill | Plugin | Description |
|-------|--------|-------------|
| 1password-management | [1password-management](https://github.com/drewburchfield/1password-management) | 1Password CLI (`op`) credential management with proper syntax and best practices. |
| 1password-openclaw | [openclaw-1password](https://github.com/drewburchfield/openclaw-1password) | OpenClaw + 1Password SecretRef setup, diagnosis, repair, and version-aware adaptation. |
| batch-prospect | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Exhaustive network search with pagination and CSV/markdown export. |
| braintrust | [braintrust](https://github.com/drewburchfield/braintrust) | Orchestrate Gemini, Codex, and Claude Code for second opinions and parallel research. |
| cre-property-research | [cre-property-research](https://github.com/drewburchfield/cre-property-research) | Commercial real estate property research and market analysis. |
| deep-search | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Network search + automatic person research in one compound workflow. |
| happenstance | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Research people and search professional network via Happenstance API. |
| helpscout-navigator | [helpscout-navigator](https://github.com/drewburchfield/helpscout-navigator) | HelpScout tool selection, sequencing, and common mistake prevention. |
| linkedin-message-triage | [linkedin-message-triage](https://github.com/drewburchfield/linkedin-message-triage) | Review LinkedIn messages, filter solicitations, draft personalized replies. |
| markdown-to-confluence | [markdown-to-confluence](https://github.com/drewburchfield/markdown-to-confluence) | Convert Markdown to Confluence Storage Format (XHTML-based XML). |
| meeting-prep | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Briefing prep combining person research with mutual connections. |
| network-scan | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Compare network groups by scanning for roles across groups. |
| project-bootstrap | [project-bootstrap](https://github.com/drewburchfield/project-bootstrap) | Auto-detect language, set up quality tooling (ESLint, ruff, pyright), configure stop hooks. |
| readme-craft | [readme-craft](https://github.com/drewburchfield/readme-craft) | Clean, human-sounding README generation. |
| subscription-cleanse | [subscription-cleanse](https://github.com/drewburchfield/subscription-cleanse) | Subscription audit combining bank CSV analysis and email recon. |
| warm-intro | [happenstance-navigator](https://github.com/drewburchfield/happenstance-navigator) | Find mutual connections for introductions to a target company or role. |

### From [codeguard-security](https://github.com/cosai-oasis/project-codeguard) (project-codeguard)

| Skill | Description |
|-------|-------------|
| software-security | Secure coding practices integrated with Project CodeGuard. Flags vulnerability patterns as code is written. |

### From [superwhisper](https://github.com/superultrainc/superwhisper-claude-code) (superwhisper)

| Skill | Description |
|-------|-------------|
| superwhisper | Toggle Superwhisper voice transcription integration on/off. |

---

If you're using the [sync script](../scripts/sync-skills.sh) from this repo, run `zsh ~/.claude/scripts/sync-skills.sh` after adding or removing personal skills to refresh the symlinks in Codex, Gemini, and OpenCode.

