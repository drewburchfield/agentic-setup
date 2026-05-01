# Agentic Setup Audit

Current as of 2026-05-01.

This repo should explain a working AI-agent environment from first principles, not just list a pile of local config. The goal is reproducibility: someone should understand what matters, what can drift, and what order to install things in.

## Layer 1: Operating Model

**Current state:** Claude Code is the primary harness. Codex, Gemini, and OpenCode are secondary harnesses that receive skills through symlinks.

**Good pattern:** One source of truth for skills. Claude Code owns personal skills and plugin skills. Other harnesses read from Claude through generated symlinks.

**Risk:** `skills.sh` keeps its own lockfile under `~/.agents/.skill-lock.json`, which can make `~/.agents/skills` look canonical. That creates drift unless the direction is explicit.

**Decision:** `~/.agents/skills` is compatibility state. It can track where skills came from, but it should point back to `~/.claude/skills` when a skill is used across harnesses.

## Layer 2: Reproducibility

**Current state:** The README explains the main setup path and the sync script. The inventory files describe what is installed today.

**Gap:** A new user can see the destination but not the full install order. Plugin marketplaces, personal skills, MCP servers, CLIs, and hooks are spread across several inventory files.

**Improvement:** Add a numbered bootstrap guide:

1. Install harnesses.
2. Install required CLIs.
3. Configure Claude Code settings and hooks.
4. Add plugin marketplaces.
5. Enable plugins.
6. Install personal skills into `~/.claude/skills`.
7. Run `sync-skills.sh --dry-run`.
8. Configure MCP servers per harness.
9. Run a health check.

## Layer 3: Drift Detection

**Current state:** `scripts/sync-skills.sh --dry-run` gives the most truthful skill graph. `inventory/skills.md` is a snapshot.

**Gap:** There is no committed check that says whether inventory is stale.

**Improvement:** Add a read-only health command later:

```bash
zsh scripts/sync-skills.sh --dry-run
```

Then compare:

- current unique skill count
- personal skill count
- plugin skill count
- broken symlinks in secondary harnesses
- `.agents` entries that are real folders instead of Claude-backed symlinks

## Layer 4: Tutorial Quality

**Current state:** The repo is useful if you already understand Claude Code, plugins, MCP servers, and multiple harnesses.

**Gap:** It still reads more like an operator inventory than a tutorial.

**Improvement:** Add short conceptual pages before the detailed inventories:

- Why Claude Code is the control plane.
- Why skills sync outward instead of being installed separately per harness.
- How plugins differ from personal skills.
- What MCP servers do and which ones are shared.
- What to install first on a clean machine.

## Layer 5: Deepening Opportunities

### 1. Skill Graph Module

**Files:** `scripts/sync-skills.sh`, `inventory/skills.md`

**Problem:** The sync script knows the skill graph, but the inventory is manually generated from that behavior. The interface for "what skills exist" is buried in a sync side effect.

**Solution:** Split read-only skill discovery from symlink writing. Keep `sync-skills.sh` as the writer, but add a small read-only inventory command later.

**Benefit:** Better locality. Inventory generation, stale checks, and sync can all depend on one skill graph interface.

### 2. Bootstrap Guide

**Files:** `README.md`, `config/`, `inventory/`

**Problem:** The setup path is scattered. A reader has to infer order from multiple files.

**Solution:** Add a `workflows/bootstrap.md` guide that walks from a clean machine to a verified setup.

**Benefit:** Higher leverage for the repo as a tutorial. The README can stay concise while the bootstrap guide carries the details.

### 3. Health Check

**Files:** `scripts/`, `inventory/`

**Problem:** The repo can silently drift from the machine.

**Solution:** Add a read-only `check` command that reports stale inventory, broken symlinks, and missing expected tools.

**Benefit:** Safer maintenance. The repo becomes easier to keep current without relying on memory.

## Current Recommendation

Keep changes conservative:

1. Make Claude Code the skill source of truth.
2. Keep `skills.sh` installs, but make `.agents` point back to Claude Code.
3. Update the skills inventory from the live sync graph.
4. Add a future health-check workflow instead of overbuilding automation today.
