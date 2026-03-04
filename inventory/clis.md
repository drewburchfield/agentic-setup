# CLI Tools Inventory

Command-line tools that connect to services or provide capabilities used by the agentic setup.

## Core to the Setup

These CLIs are directly used by skills, plugins, or workflows.

| CLI | Source | Used By | Description |
|-----|--------|---------|-------------|
| gh | [cli/cli](https://github.com/cli/cli) (`brew install gh`) | commit-commands plugin, PR workflows | GitHub: repos, PRs, issues, actions, API |
| clings | [drewburchfield/clings](https://github.com/drewburchfield/clings) (`brew install drewburchfield/tap/clings`) | things skill | Things 3: natural language task entry, SQL-like filtering, bulk operations |
| agent-browser | [vercel-labs/agent-browser](https://github.com/vercel-labs/agent-browser) (`npm install -g agent-browser`) | agent-browser skill, dogfood skill | Browser automation for AI agents via Playwright |
| op | [1Password CLI](https://developer.1password.com/docs/cli/) (`brew install 1password-cli`) | 1password-management plugin | 1Password vault access from the terminal |
| gog | [drewburchfield/gogcli-safe](https://github.com/drewburchfield/gogcli-safe) (`brew install drewburchfield/tap/gog-safe`) | gog skill | Google Workspace: Gmail, Calendar, Chat, Drive, Docs, Sheets, Contacts, Tasks. Fork of steipete/gogcli with compile-time safety profiles that physically remove dangerous commands from the binary. |
| bird | [@steipete/bird](https://github.com/steipete/bird) (`npm install -g @steipete/bird`) | bird skill | Twitter/X: tweet, reply, search, read threads, bookmarks, trending |

## Agentic Tooling

CLIs for building, managing, and publishing AI agent infrastructure.

| CLI | Source | Description |
|-----|--------|-------------|
| goose | [block/goose](https://github.com/block/goose) (`brew install block-goose-cli`) | Goose AI coding agent |
| clawhub | [clawhub](https://www.npmjs.com/package/clawhub) (`npm install -g clawhub`) | Install, update, search, and publish agent skills |
| openclaw | [openclaw](https://www.npmjs.com/package/openclaw) (`npm install -g openclaw`) | Cross-platform messaging CLI |
| mcporter | [mcporter](https://www.npmjs.com/package/mcporter) (`npm install -g mcporter`) | MCP CLI: generate, test, and manage MCP servers |
| mcp-publisher | [mcp-publisher](https://github.com/docker/mcp-publisher) (`brew install mcp-publisher`) | Publish MCP servers to the Docker registry |
| dxt | [@anthropic-ai/dxt](https://www.npmjs.com/package/@anthropic-ai/dxt) (`npm install -g @anthropic-ai/dxt`) | Build and package Anthropic Desktop Extensions |

## Service CLIs

CLIs that connect to external platforms and cloud services.

| CLI | Source | Description |
|-----|--------|-------------|
| cloudflared | [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/) (`brew install cloudflared`) | Cloudflare Tunnel: expose local services securely without port forwarding |
| flyctl | [Fly.io CLI](https://fly.io/docs/flyctl/) (`brew install flyctl`) | Fly.io app deployment and management |
| gcloud / bq | [Google Cloud SDK](https://cloud.google.com/sdk) (`brew install google-cloud-sdk`) | Google Cloud Platform management and BigQuery |
| neonctl | [Neon CLI](https://neon.tech/docs/reference/neon-cli) (`brew install neonctl`) | Neon serverless Postgres: branches, databases, connection strings |
| ngrok | [ngrok](https://ngrok.com/) (`brew install ngrok/ngrok/ngrok`) | Tunnel local services to the internet for webhooks and testing |
| obsidian-cli | [Obsidian CLI](https://github.com/Yakitrak/obsidian-cli) (`brew install yakitrak/yakitrak/obsidian-cli`) | Obsidian vault operations from the terminal |
| openai | [OpenAI CLI](https://github.com/openai/openai-python) (`brew install openai`) | OpenAI API access from the terminal |
| railway | [Railway CLI](https://docs.railway.app/reference/cli-api) (`brew install railway`) | Railway.app deployment and project management |
| sentry-cli | [Sentry CLI](https://docs.sentry.io/cli/) | Sentry error tracking: releases, source maps, debug files |
| stripe | [Stripe CLI](https://stripe.com/docs/stripe-cli) (`brew install stripe/stripe-cli/stripe`) | Stripe: webhooks, logs, API testing |
| tailscale | [Tailscale CLI](https://tailscale.com/kb/1080/cli) | Tailscale mesh VPN: device management, network access, DNS |
| wrangler | [Cloudflare Wrangler](https://developers.cloudflare.com/workers/wrangler/) | Cloudflare Workers and Pages: deploy, dev, KV, R2, D1 |

## Utility CLIs

Standalone tools used across workflows.

| CLI | Source | Description |
|-----|--------|-------------|
| gifgrep | [steipete/gifgrep](https://github.com/steipete/gifgrep) (`brew install steipete/tap/gifgrep`) | Search GIFs by content |
| goplaces | [steipete/goplaces](https://github.com/steipete/goplaces) (`brew install steipete/tap/goplaces`) | Search and resolve places via Google Places API |
| hugo | [Hugo](https://gohugo.io/) (`brew install hugo`) | Static site generator |
| marp | [@marp-team/marp-cli](https://github.com/marp-team/marp-cli) (`npm install -g @marp-team/marp-cli`) | Markdown presentations to HTML/PDF/PPTX |
| mmdc | [@mermaid-js/mermaid-cli](https://github.com/mermaid-js/mermaid-cli) (`npm install -g @mermaid-js/mermaid-cli`) | Mermaid diagram rendering |
| pandoc | [Pandoc](https://pandoc.org/) (`brew install pandoc`) | Universal document converter |
| peekaboo | [steipete/peekaboo](https://github.com/steipete/peekaboo) (`brew install steipete/tap/peekaboo`) | macOS screenshot and window capture |
| sag | [steipete/sag](https://github.com/steipete/sag) (`brew install steipete/tap/sag`) | ElevenLabs TTS with macOS playback |
| summarize | [steipete/summarize](https://github.com/steipete/summarize) (`brew install steipete/tap/summarize`) | Summarize web pages and YouTube links |
| whisper-cpp | [whisper.cpp](https://github.com/ggerganov/whisper.cpp) (`brew install whisper-cpp`) | Local speech-to-text on Apple Silicon |

## Development Runtimes

| CLI | Description |
|-----|-------------|
| node / npm / npx | Node.js via NVM. Required by MCP servers, Playwright, and skill sync. |
| bun | Fast JavaScript runtime and bundler |
| deno | Secure JavaScript/TypeScript runtime |
| go | Go toolchain |
| dart / flutter | Dart SDK and Flutter framework |
