# Skills Inventory

Current as of 2026-05-01. Generated from the live Claude Code skill graph with `zsh ~/.claude/scripts/sync-skills.sh --dry-run`.

143 unique skills are discoverable after deduplication: 35 personal Claude Code skills and 108 plugin skills.

Claude Code is the source of truth. Personal skills live in `~/.claude/skills/`. The sync script creates symlinks outward to Codex, Gemini, and OpenCode.

## Personal Claude Code Skills

35 skills live directly in `~/.claude/skills/`.

### Installed Through skills.sh

These are tracked in `~/.agents/.skill-lock.json`, but their canonical folders now live in `~/.claude/skills/`. The `.agents` entries are compatibility symlinks back to Claude Code.

| Skill | Original Source | Description |
|-------|-----------------|-------------|
| `caveman` | `mattpocock/skills` | Ultra-compressed communication mode. Cuts token usage ~75% by dropping filler, articles, and pleasantries while keeping full technical accuracy. Use when user says "caveman mode", "talk l... |
| `diagnose` | `mattpocock/skills` | Disciplined diagnosis loop for hard bugs and performance regressions. Reproduce -> minimise -> hypothesise -> instrument -> fix -> regression-test. Use when user says "diagnose this" / "debug... |
| `find-skills` | `vercel-labs/skills` | Helps users discover and install agent skills when they ask questions like "how do I do X", "find a skill for X", "is there a skill that can...", or express interest in extending capabili... |
| `gog` | `openclaw/skills` | Google Workspace CLI for Gmail, Calendar, Chat, Classroom, Drive, Docs, Slides, Sheets, Contacts, Tasks, People, Groups, and Keep. Use when working with email threads, creating drafts, ma... |
| `grill-me` | `mattpocock/skills` | Interview the user relentlessly about a plan or design until reaching shared understanding, resolving each branch of the decision tree. Use when user wants to stress-test a plan, get gril... |
| `grill-with-docs` | `mattpocock/skills` | Grilling session that challenges your plan against the existing domain model, sharpens terminology, and updates documentation (CONTEXT.md, ADRs) inline as decisions crystallise. Use when... |
| `improve-codebase-architecture` | `mattpocock/skills` | Find deepening opportunities in a codebase, informed by the domain language in CONTEXT.md and the decisions in docs/adr/. Use when the user wants to improve architecture, find refactoring... |
| `remotion-best-practices` | `remotion-dev/skills` | Best practices for Remotion - Video creation in React |
| `setup-matt-pocock-skills` | `mattpocock/skills` | Sets up an `## Agent skills` block in AGENTS.md/CLAUDE.md and `docs/agents/` so the engineering skills know this repo's issue tracker (GitHub or local markdown), triage label vocabulary,... |
| `tdd` | `mattpocock/skills` | Test-driven development with red-green-refactor loop. Use when user wants to build features or fix bugs using TDD, mentions "red-green-refactor", wants integration tests, or asks for test... |
| `to-issues` | `mattpocock/skills` | Break a plan, spec, or PRD into independently-grabbable issues on the project issue tracker using tracer-bullet vertical slices. Use when user wants to convert a plan into issues, create... |
| `to-prd` | `mattpocock/skills` | Turn the current conversation context into a PRD and publish it to the project issue tracker. Use when user wants to create a PRD from the current context. |
| `triage` | `mattpocock/skills` | Triage issues through a state machine driven by triage roles. Use when user wants to create an issue, triage issues, review incoming bugs or feature requests, prepare issues for an AFK ag... |
| `write-a-skill` | `mattpocock/skills` | Create new agent skills with proper structure, progressive disclosure, and bundled resources. Use when user wants to create, write, or build a new skill. |
| `zoom-out` | `mattpocock/skills` | Tell the agent to zoom out and give broader context or a higher-level perspective. Use when you're unfamiliar with a section of code or need to understand how it fits into the bigger pict... |

### Direct Personal Skills

| Skill | Source Path | Description |
|-------|-------------|-------------|
| `agent-browser` | `/opt/homebrew/lib/node_modules/agent-browser/skills/agent-browser` | Browser automation CLI for AI agents. Use when the user needs to interact with websites, including navigating pages, filling forms, clicking buttons, taking screenshots, extracting data,... |
| `asc-app-create-ui` | `~/.claude/skills/asc-app-create-ui` | Create an App Store Connect app via iris API using web session from Blitz |
| `asc-iap-attach` | `~/.claude/skills/asc-iap-attach` | Attach in-app purchases and subscriptions to an app version for App Store review. Use when the user has IAPs or subscriptions in "Ready to Submit" state that need to be included with a fi... |
| `asc-privacy-nutrition-labels` | `~/.claude/skills/asc-privacy-nutrition-labels` | Set up App Store privacy nutrition labels (data collection declarations) for an app. Use when the user needs to declare what data their app collects, how it's used, and whether it's linke... |
| `asc-team-key-create` | `~/.claude/skills/asc-team-key-create` | Create a new App Store Connect Team API Key with Admin permissions, download the one-time .p8 private key, and store it in ~/.blitz. Use when the user needs a new ASC API key for CLI auth... |
| `bird` | `~/.claude/skills/bird` | This skill should be used when the user asks to "read a tweet", "search Twitter", "search X", "fetch a thread", "check Twitter mentions", "get bookmarks from Twitter", "look up a Twitter... |
| `de-ai-ify` | `~/.claude/skills/de-ai-ify` | Remove AI-generated jargon and restore human voice to text. Use when user says "de-ai-ify", "make this sound human", "remove AI voice", or provides text that needs to sound less machine-g... |
| `design-principles` | `~/.claude/skills/design-principles` | Enforce a precise, minimal design system inspired by Linear, Notion, and Stripe. Use this skill when building dashboards, admin interfaces, or any UI that needs Jony Ive-level precision -... |
| `docfetch` | `~/.claude/skills/docfetch` | Fetch the latest version of any external API, SDK, or library documentation on demand. Use when the user references external docs, mentions a library or API by name, asks about endpoints,... |
| `dogfood` | `~/.claude/skills/dogfood` | Systematically explore and test a web application to find bugs, UX issues, and other problems. Use when asked to "dogfood", "QA", "exploratory test", "find issues", "bug hunt", "test this... |
| `exa` | `~/.claude/skills/exa` | Exa neural search and answer APIs for finding specific, technical content on the web. Use when user asks to "search exa", "exa search", "find with exa", or needs deep web research beyond... |
| `generated-artifact-cleanup` | `~/.claude/skills/generated-artifact-cleanup` | Clean up iterative generated artifacts without deleting work. Use when a workspace has many draft, final, v1/v2, render, export, raw media, or build-output files and the user wants a grou... |
| `gitbutler` | `~/.claude/skills/gitbutler` | Commit, push, branch, and manage version control with GitButler. Use for: commit my changes, check what changed, create a PR, push my branch, view diff, create branches, stage files, edit... |
| `hex` | `~/.claude/skills/hex` | Programmatically interact with the Hex data analytics platform (https://hex.tech). Create projects, add python and sql cells to notebooks, write queries against data connections, build st... |
| `newsletter-processor` | `~/.claude/skills/newsletter-processor` | Process newsletters from inbox into structured knowledge artifacts. Use when user says "process newsletters", "review my newsletters", "summarize newsletters", "daily newsletter review",... |
| `nlm-skill` | `~/.claude/skills/nlm-skill` | Expert guide for the NotebookLM CLI (`nlm`) and MCP server - interfaces for Google NotebookLM. Use this skill when users want to interact with NotebookLM programmatically, including: crea... |
| `quality-gate` | `~/.claude/skills/quality-gate` | This skill should be used when the user asks to "quality gate", "run quality gate", "review and merge", "PR review cycle", or mentions completing a phase/milestone and wanting comprehensi... |
| `things` | `~/.claude/skills/things` | This skill should be used when the user asks to "check my tasks", "add a todo", "what's on my list", "show today's tasks", "mark something as done", "complete a task", "search my todos",... |
| `thinking-partner` | `~/.claude/skills/thinking-partner` | Collaborative thinking partner for exploring complex problems through careful questioning, not rushing to solutions. Use when user says "thinking partner", "help me think through", "explo... |
| `zero` | `~/.claude/skills/zero` | Use this skill when the user wants to search for AI capabilities, call paid APIs, or access external services with automatic payment. Activate when the user mentions zero, capability sear... |

## Plugin Skills

108 plugin skills come from `~/.claude/plugins/cache/`. Personal skills win if a plugin provides the same skill name.

### anthropic-agent-skills/claude-api

| Skill | Description |
|-------|-------------|
| `claude-api` | Build apps with the Claude API or Anthropic SDK. TRIGGER when: code imports `anthropic`/`@anthropic-ai/sdk`/`claude_agent_sdk`, or user asks to use Claude API, Anthropic SDKs, or Agent SD... |

### anthropic-agent-skills/document-skills

| Skill | Description |
|-------|-------------|
| `docx` | Use this skill whenever the user wants to create, read, edit, or manipulate Word documents (.docx files). Triggers include: any mention of 'Word doc', 'word document', '.docx', or request... |
| `pdf` | Use this skill whenever the user wants to do anything with PDF files. This includes reading or extracting text/tables from PDFs, combining or merging multiple PDFs into one, splitting PDF... |
| `pptx` | Use this skill any time a .pptx file is involved in any way - as input, output, or both. This includes: creating slide decks, pitch decks, or presentations; reading, parsing, or extractin... |
| `xlsx` | Use this skill any time a spreadsheet file is the primary input or output. This means any task where the user wants to: open, read, edit, or fix an existing .xlsx, .xlsm, .csv, or .tsv fi... |

### anthropic-agent-skills/example-skills

| Skill | Description |
|-------|-------------|
| `algorithmic-art` | Creating algorithmic art using p5.js with seeded randomness and interactive parameter exploration. Use this when users request creating art using code, generative art, algorithmic art, fl... |
| `brand-guidelines` | Applies Anthropic's official brand colors and typography to any sort of artifact that may benefit from having Anthropic's look-and-feel. Use it when brand colors or style guidelines, visu... |
| `canvas-design` | Create beautiful visual art in .png and .pdf documents using design philosophy. You should use this skill when the user asks to create a poster, piece of art, design, or other static piec... |
| `doc-coauthoring` | Guide users through a structured workflow for co-authoring documentation. Use when user wants to write documentation, proposals, technical specs, decision docs, or similar structured cont... |
| `internal-comms` | A set of resources to help me write all kinds of internal communications, using the formats that my company likes to use. Claude should use this skill whenever asked to write some sort of... |
| `mcp-builder` | Guide for creating high-quality MCP (Model Context Protocol) servers that enable LLMs to interact with external services through well-designed tools. Use when building MCP servers to inte... |
| `skill-creator` | Create new skills, modify and improve existing skills, and measure skill performance. Use when users want to create a skill from scratch, edit, or optimize an existing skill, run evals to... |
| `slack-gif-creator` | Knowledge and utilities for creating animated GIFs optimized for Slack. Provides constraints, validation tools, and animation concepts. Use when users request animated GIFs for Slack like... |
| `theme-factory` | Toolkit for styling artifacts with a theme. These artifacts can be slides, docs, reportings, HTML landing pages, etc. There are 10 pre-set themes with colors/fonts that you can apply to a... |
| `web-artifacts-builder` | Suite of tools for creating elaborate, multi-component claude.ai HTML artifacts using modern frontend web technologies (React, Tailwind CSS, shadcn/ui). Use for complex artifacts requirin... |
| `webapp-testing` | Toolkit for interacting with and testing local web applications using Playwright. Supports verifying frontend functionality, debugging UI behavior, capturing browser screenshots, and view... |

### claude-canvas/canvas

| Skill | Description |
|-------|-------------|
| `calendar` | Calendar canvas for displaying events and picking meeting times. Use when showing calendar views or when users need to select available time slots. |
| `canvas` | **The primary skill for terminal TUI components.** Covers spawning, controlling, and interacting with terminal canvases. Use when displaying calendars, documents, or flight bookings. |
| `document` | Document canvas for displaying and editing markdown content. Use when showing documents, emails, or when users need to select text for editing. |
| `flight` | Flight canvas for comparing flights and selecting seats. Use when users need to browse flight options and book seats. |

### claude-plugins-official/claude-code-setup

| Skill | Description |
|-------|-------------|
| `claude-automation-recommender` | Analyze a codebase and recommend Claude Code automations (hooks, subagents, skills, plugins, MCP servers). Use when user asks for automation recommendations, wants to optimize their Claud... |

### claude-plugins-official/claude-md-management

| Skill | Description |
|-------|-------------|
| `claude-md-improver` | Audit and improve CLAUDE.md files in repositories. Use when user asks to check, audit, update, improve, or fix CLAUDE.md files. Scans for all CLAUDE.md files, evaluates quality against te... |

### claude-plugins-official/frontend-design

| Skill | Description |
|-------|-------------|
| `frontend-design` | Create distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, or applications. Generates creative, p... |

### claude-plugins-official/playground

| Skill | Description |
|-------|-------------|
| `playground` | Creates interactive HTML playgrounds - self-contained single-file explorers that let users configure something visually through controls, see a live preview, and copy out a prompt. Use wh... |

### claude-plugins-official/plugin-dev

| Skill | Description |
|-------|-------------|
| `agent-development` | This skill should be used when the user asks to "create an agent", "add an agent", "write a subagent", "agent frontmatter", "when to use description", "agent examples", "agent tools", "ag... |
| `command-development` | This skill should be used when the user asks to "create a slash command", "add a command", "write a custom command", "define command arguments", "use command frontmatter", "organize comma... |
| `hook-development` | This skill should be used when the user asks to "create a hook", "add a PreToolUse/PostToolUse/Stop hook", "validate tool use", "implement prompt-based hooks", "use ${CLAUDE_PLUGIN_ROOT}"... |
| `mcp-integration` | This skill should be used when the user asks to "add MCP server", "integrate MCP", "configure MCP in plugin", "use .mcp.json", "set up Model Context Protocol", "connect external service",... |
| `plugin-settings` | This skill should be used when the user asks about "plugin settings", "store plugin configuration", "user-configurable plugin", ".local.md files", "plugin state files", "read YAML frontma... |
| `plugin-structure` | This skill should be used when the user asks to "create a plugin", "scaffold a plugin", "understand plugin structure", "organize plugin components", "set up plugin.json", "use ${CLAUDE_PL... |
| `skill-development` | This skill should be used when the user wants to "create a skill", "add a skill to plugin", "write a new skill", "improve skill description", "organize skill content", or needs guidance o... |

### dbt-agent-marketplace/dbt

| Skill | Description |
|-------|-------------|
| `adding-dbt-unit-test` | Creates unit test YAML definitions that mock upstream model inputs and validate expected outputs. Use when adding unit tests for a dbt model or practicing test-driven development (TDD) in... |
| `answering-natural-language-questions-with-dbt` | Writes and executes SQL queries against the data warehouse using dbt's Semantic Layer or ad-hoc SQL to answer business questions. Use when a user asks about analytics, metrics, KPIs, or d... |
| `building-dbt-semantic-layer` | Use when creating or modifying dbt Semantic Layer components - semantic models, metrics, dimensions, entities, measures, or time spines. Covers MetricFlow configuration, metric types (sim... |
| `configuring-dbt-mcp-server` | Generates MCP server configuration JSON, resolves authentication setup, and validates server connectivity for dbt. Use when setting up, configuring, or troubleshooting the dbt MCP server... |
| `fetching-dbt-docs` | Retrieves and searches dbt documentation pages in LLM-friendly markdown format. Use when fetching dbt documentation, looking up dbt features, or answering questions about dbt Cloud, dbt C... |
| `running-dbt-commands` | Formats and executes dbt CLI commands, selects the correct dbt executable, and structures command parameters. Use when running models, tests, builds, compiles, or show queries via dbt CLI... |
| `troubleshooting-dbt-job-errors` | Diagnoses dbt Cloud/platform job failures by analyzing run logs, querying the Admin API, reviewing git history, and investigating data issues. Use when a dbt Cloud/platform job fails and... |
| `using-dbt-for-analytics-engineering` | Builds and modifies dbt models, writes SQL transformations using ref() and source(), creates tests, and validates results with dbt show. Use when doing any dbt work - building or modifyin... |
| `working-with-dbt-mesh` | Implements dbt Mesh governance features (model contracts, access modifiers, groups, versioning) and multi-project collaboration with cross-project refs. Use when implementing dbt Mesh gov... |

### dev-browser-marketplace/dev-browser

| Skill | Description |
|-------|-------------|
| `dev-browser` | Browser automation with persistent page state. Use when users ask to navigate websites, fill forms, take screenshots, extract web data, test web apps, or automate browser workflows. Trigg... |

### dlthub-ai-workbench/data-exploration

| Skill | Description |
|-------|-------------|
| `build-notebook` | This skill should be used when the user asks to "build the notebook", "launch the dashboard", "generate the marimo notebook", or when an analysis_plan.md artifact exists and the user want... |
| `explore-data` | This skill should be used when the user asks to "explore my data", "what can I learn from this pipeline", "what's the revenue trend", "show me charts", "visualize my pipeline", "analyze m... |

### dlthub-ai-workbench/init

| Skill | Description |
|-------|-------------|
| `improve-skills` | Improve existing skills based on the current session. Use at the end of a session (or when the user asks) to capture new debugging patterns, data issues, data validation tracks, querying... |
| `setup-secrets` | Safely manage dlt secrets in *.secrets.toml. Use when the user directly asks to set up, configure, or inspect credentials (API keys, database passwords, tokens). Also use when writing Pyt... |
| `toolkit-dispatch` | Helps users figure out what they can build with dlt and which workflow to start. MUST use this skill when the user asks questions like 'what can you do', 'how do I build a pipeline', 'how... |

### dlthub-ai-workbench/rest-api-pipeline

| Skill | Description |
|-------|-------------|
| `adjust-endpoint` | Adjust a working dlt pipeline for production - remove dev limits, verify pagination, configure incremental loading, expand date ranges. Use when the user wants to remove .add_limit(), loa... |
| `create-rest-api-pipeline` | Create a dlt REST API pipeline. Use for the rest_api core source, or any generic REST/HTTP API source. Not for sql_database or filesystem sources. |
| `debug-pipeline` | Debug and inspect a dlt pipeline after running it. Use after a pipeline run (success or failure) to inspect traces, load packages, schema, data, and diagnose errors like missing credentia... |
| `find-source` | Find a dlt source for a given API or data provider. Use when the user asks about a source, wants to find a connector, or asks to implement a pipeline for a specific data source. |
| `new-endpoint` | Add a new REST API endpoint/resource to an existing dlt pipeline. Use when the user wants to pull additional data from an API that already has a working pipeline. |
| `validate-data` | Validate schema and data after a successful dlt pipeline load. Use when the user wants to check if loaded data looks correct, inspect table schemas, fix data types, flatten nested structu... |
| `view-data` | Query, explore, or view data loaded by a dlt pipeline. Use when the user asks to query data, explore loaded tables, check row counts, write Python that reads pipeline data, or asks questi... |

### impeccable/impeccable

| Skill | Description |
|-------|-------------|
| `adapt` | Adapt designs to work across different screen sizes, devices, contexts, or platforms. Implements breakpoints, fluid layouts, and touch targets. Use when the user mentions responsive desig... |
| `animate` | Review a feature and enhance it with purposeful animations, micro-interactions, and motion effects that improve usability and delight. Use when the user mentions adding animation, transit... |
| `audit` | Run technical quality checks across accessibility, performance, theming, responsive design, and anti-patterns. Generates a scored report with P0-P3 severity ratings and actionable plan. U... |
| `bolder` | Amplify safe or boring designs to make them more visually interesting and stimulating. Increases impact while maintaining usability. Use when the user says the design looks bland, generic... |
| `clarify` | Improve unclear UX copy, error messages, microcopy, labels, and instructions to make interfaces easier to understand. Use when the user mentions confusing text, unclear labels, bad error... |
| `colorize` | Add strategic color to features that are too monochromatic or lack visual interest, making interfaces more engaging and expressive. Use when the user mentions the design looking gray, dul... |
| `critique` | Evaluate design from a UX perspective, assessing visual hierarchy, information architecture, emotional resonance, cognitive load, and overall quality with quantitative scoring, persona-ba... |
| `delight` | Add moments of joy, personality, and unexpected touches that make interfaces memorable and enjoyable to use. Elevates functional to delightful. Use when the user asks to add polish, perso... |
| `distill` | Strip designs to their essence by removing unnecessary complexity. Great design is simple, powerful, and clean. Use when the user asks to simplify, declutter, reduce noise, remove element... |
| `harden` | Make interfaces production-ready: error handling, empty states, onboarding flows, i18n, text overflow, and edge case management. Use when the user asks to harden, make production-ready, h... |
| `impeccable` | Use when the user wants to design, redesign, shape, critique, audit, polish, clarify, distill, harden, optimize, adapt, animate, colorize, extract, or otherwise improve a frontend interfa... |
| `layout` | Improve layout, spacing, and visual rhythm. Fixes monotonous grids, inconsistent spacing, and weak visual hierarchy. Use when the user mentions layout feeling off, spacing issues, visual... |
| `optimize` | Diagnoses and fixes UI performance across loading speed, rendering, animations, images, and bundle size. Use when the user mentions slow, laggy, janky, performance, bundle size, load time... |
| `overdrive` | Pushes interfaces past conventional limits with technically ambitious implementations - shaders, spring physics, scroll-driven reveals, 60fps animations. Use when the user wants to wow, i... |
| `polish` | Performs a final quality pass fixing alignment, spacing, consistency, and micro-detail issues before shipping. Use when the user mentions polish, finishing touches, pre-launch review, som... |
| `quieter` | Tones down visually aggressive or overstimulating designs, reducing intensity while preserving quality. Use when the user mentions too bold, too loud, overwhelming, aggressive, garish, or... |
| `shape` | Plan the UX and UI for a feature before writing code. Runs a structured discovery interview, then produces a design brief that guides implementation. Use during the planning phase to esta... |
| `typeset` | Improves typography by fixing font choices, hierarchy, sizing, weight, and readability so text feels intentional. Use when the user mentions fonts, type, readability, text hierarchy, sizi... |

### linear-cli/linear-cli

| Skill | Description |
|-------|-------------|
| `linear-cli` | Manage Linear issues from the command line using the linear cli. This skill allows automating linear management. |
| `release` | This skill should be used when the user asks to "make a release", "create a release", "cut a release", "release a new version", "publish a release", or mentions preparing for release. Pro... |

### not-my-job/1password-management

| Skill | Description |
|-------|-------------|
| `1password-management` | Use when interacting with 1Password CLI (op) to create, read, update, or manage credentials. Provides proper syntax, field types, best practices, and common pitfall avoidance. |

### not-my-job/braintrust

| Skill | Description |
|-------|-------------|
| `braintrust` | Orchestrate other AI CLIs (Gemini, Codex, Claude Code) for second opinions, research, codebase analysis, design review, security audits, and parallel research |

### not-my-job/cre-property-research

| Skill | Description |
|-------|-------------|
| `cre-property-research` | Comprehensive commercial real estate property research and market analysis. Use when user requests property research, market analysis, tenant prospecting intelligence, or investment due d... |

### not-my-job/happenstance-navigator

| Skill | Description |
|-------|-------------|
| `batch-prospect` | Exhaustive network search with find-more pagination and export to CSV or markdown. Designed for prospecting with configurable depth and safety caps. |
| `deep-search` | Search your professional network and automatically research the top matches. Combines network search with person research into a single compound workflow. |
| `happenstance` | Research people and search your professional network using the Happenstance API. Supports person research with detailed profiles, natural language network search, and paginated results. R... |
| `meeting-prep` | Prepare a comprehensive briefing for a meeting with a specific person. Combines person research with mutual connection search into talking points. |
| `network-scan` | Compare your network groups by scanning for a role or criteria across multiple groups. Surfaces cross-group overlaps and per-group statistics. |
| `warm-intro` | Find mutual connections who can introduce you to people at a target company or in a target role. Analyzes your network for the best connectors. |

### not-my-job/linkedin-message-triage

| Skill | Description |
|-------|-------------|
| `linkedin-message-triage` | Use when reviewing LinkedIn messages to identify which need responses, filter solicitations, and draft personalized replies. Triggers when user asks to "check LinkedIn messages", "review... |

### not-my-job/markdown-to-confluence

| Skill | Description |
|-------|-------------|
| `markdown-to-confluence` | Convert Markdown documents to Confluence Storage Format (XHTML-based XML) for uploading to Atlassian Confluence. Use when the user needs to convert a Markdown file to Confluence format, c... |

### not-my-job/project-bootstrap

| Skill | Description |
|-------|-------------|
| `project-bootstrap` | Auto-detect project language, set up quality tooling (ESLint, Prettier, ruff, pyright), configure stop hooks for quality gates, and manage plugin selection. Use when bootstrapping a new o... |

### not-my-job/readme-craft

| Skill | Description |
|-------|-------------|
| `readme-craft` | Write clean, human-sounding README files for personal and open source projects. Use when creating or improving a README, especially for smaller projects that don't need enterprise-grade d... |

### not-my-job/subscription-cleanse

| Skill | Description |
|-------|-------------|
| `subscription-cleanse` | Comprehensive subscription audit combining bank CSV analysis and email reconnaissance. Use when user wants to find all subscriptions, audit recurring charges, review what they're paying f... |

### project-codeguard/codeguard-security

| Skill | Description |
|-------|-------------|
| `software-security` | A software security skill that integrates with Project CodeGuard to help AI coding agents write secure code and prevent common vulnerabilities. Use this skill when writing, reviewing, or... |

### superpowers-marketplace/elements-of-style

| Skill | Description |
|-------|-------------|
| `writing-clearly-and-concisely` | Apply Strunk's timeless writing rules to ANY prose humans will read-documentation, commit messages, error messages, explanations, reports, or UI text. Makes your writing clearer, stronger... |

### superpowers-marketplace/superpowers

| Skill | Description |
|-------|-------------|
| `brainstorming` | You MUST use this before any creative work - creating features, building components, adding functionality, or modifying behavior. Explores user intent, requirements and design before impl... |
| `dispatching-parallel-agents` | Use when facing 2+ independent tasks that can be worked on without shared state or sequential dependencies |
| `executing-plans` | Use when you have a written implementation plan to execute in a separate session with review checkpoints |
| `finishing-a-development-branch` | Use when implementation is complete, all tests pass, and you need to decide how to integrate the work - guides completion of development work by presenting structured options for merge, P... |
| `receiving-code-review` | Use when receiving code review feedback, before implementing suggestions, especially if feedback seems unclear or technically questionable - requires technical rigor and verification, not... |
| `requesting-code-review` | Use when completing tasks, implementing major features, or before merging to verify work meets requirements |
| `subagent-driven-development` | Use when executing implementation plans with independent tasks in the current session |
| `systematic-debugging` | Use when encountering any bug, test failure, or unexpected behavior, before proposing fixes |
| `test-driven-development` | Use when implementing any feature or bugfix, before writing implementation code |
| `using-git-worktrees` | Use when starting feature work that needs isolation from current workspace or before executing implementation plans - creates isolated git worktrees with smart directory selection and saf... |
| `using-superpowers` | Use when starting any conversation - establishes how to find and use skills, requiring Skill tool invocation before ANY response including clarifying questions |
| `verification-before-completion` | Use when about to claim work is complete, fixed, or passing, before committing or creating PRs - requires running verification commands and confirming output before making any success cla... |
| `writing-plans` | Use when you have a spec or requirements for a multi-step task, before touching code |
| `writing-skills` | Use when creating new skills, editing existing skills, or verifying skills work before deployment |

### superpowers-marketplace/superpowers-developing-for-claude-code

| Skill | Description |
|-------|-------------|
| `developing-claude-code-plugins` | Use when working on Claude Code plugins (creating, modifying, testing, releasing, or maintaining) - provides streamlined workflows, patterns, and examples for the complete plugin lifecycle |
| `professional-greeting` |  |
| `workflow` | Use when demonstrating plugin workflow features - shows how skills can guide multi-step processes |
| `working-with-claude-code` | Use when working with Claude Code CLI, plugins, hooks, MCP servers, skills, configuration, or any Claude Code feature - provides comprehensive official documentation for all aspects of Cl... |

### superwhisper/superwhisper

| Skill | Description |
|-------|-------------|
| `superwhisper` | Toggle Superwhisper agent integration (on/off/toggle) |

## Operational Notes

- Run `zsh ~/.claude/scripts/sync-skills.sh --dry-run` to preview the exact deduped graph.
- Run `zsh ~/.claude/scripts/sync-skills.sh` after adding or removing personal skills.
- Do not install skills directly into Codex, Gemini, or OpenCode. Those folders are sync targets.
- `~/.agents/skills` is compatibility state for `skills.sh`, not the canonical source.
