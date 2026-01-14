# Claude Code Setup

Personal Claude Code configuration backup and setup automation.

## What's Included

### Configuration Files
- **CLAUDE.md** - Global instructions and rules for Claude Code
- **settings.template.json** - Hooks, plugins, and preferences (template)
- **mcp-servers.template.json** - MCP server configurations (template)

### Custom Agents (`agents/`)
| Agent | Purpose |
|-------|---------|
| code-reviewer | Security, bugs, performance review |
| qa-tester | Edge cases and test scenarios |
| ux-reviewer | UX/UI audit before/after implementation |
| ui-designer | Design decisions before coding |

### Custom Skills (`skills/`)
| Skill | Triggers |
|-------|----------|
| prd | "create a prd", "plan this feature" |
| ralph | "convert this prd to ralph format" |
| copy | Copywriting assistance |
| design | Design assistance |
| go-to-market | GTM planning |
| qa-testing | QA planning |

### Custom Commands (`commands/`)
| Command | Purpose |
|---------|---------|
| /ui | Generate UI via v0 with ux-reviewer validation |

### Rules (`rules/delegator/`)
GPT expert delegation workflow rules:
- orchestration.md - Main orchestration logic
- triggers.md - When to delegate
- model-selection.md - Expert selection criteria
- delegation-format.md - Prompt templates

## Quick Setup

```bash
# Clone this repo
git clone <your-repo-url> ~/claude-setup
cd ~/claude-setup

# Run setup script
chmod +x setup.sh
./setup.sh
```

## Manual Setup Steps

After running the script, you need to:

### 1. Add MCP Servers

**Global servers:**
```bash
claude mcp add vercel -s user --transport http https://mcp.vercel.com/mcp
claude mcp add supabase -s user --transport http https://mcp.supabase.com/mcp
claude mcp add chrome-devtools -s user -- npx -y chrome-devtools-mcp@latest
claude mcp add playwright -s user -- npx -y @playwright/mcp@latest
claude mcp add github -s user -- npx -y @modelcontextprotocol/server-github
```

**Project servers (run in project directory):**
```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
claude mcp add figma --transport http https://mcp.figma.com/mcp
claude mcp add gcloud -- npx -y @google-cloud/gcloud-mcp
claude mcp add postgres-mcp -- uvx --python 3.12 postgres-mcp --access-mode=unrestricted
```

### 2. Configure Secrets

Set these environment variables or configure in MCP server settings:

| Secret | Purpose | How to get |
|--------|---------|------------|
| V0_API_KEY | v0.dev API | https://v0.dev/settings |
| DATABASE_URI | PostgreSQL connection | Your DB provider |
| GITHUB_TOKEN | GitHub API | `gh auth token` or PAT |

### 3. Install External Tools

```bash
# Codex CLI (for GPT delegation)
# Follow installation from OpenAI

# Google Cloud CLI
brew install google-cloud-sdk
gcloud auth login

# GitHub CLI
brew install gh
gh auth login

# Python tools (for postgres-mcp)
brew install uv
```

### 4. Enable Plugins

Merge `settings.template.json` into `~/.claude/settings.json`, or manually enable:

```bash
claude plugins list  # See installed
# Plugins should auto-enable after installation
```

## MCP Servers Summary

| Server | Type | Purpose |
|--------|------|---------|
| vercel | HTTP | Vercel deployments |
| supabase | HTTP | Supabase database |
| chrome-devtools | stdio | Browser debugging |
| playwright | stdio | Browser automation |
| github | stdio | GitHub API |
| context7 | stdio | Documentation lookup |
| figma | HTTP | Figma designs |
| postgres-mcp | stdio | PostgreSQL queries |
| gcloud | stdio | Google Cloud |
| v0-mcp | stdio | v0 UI generation |
| codex | stdio | GPT expert delegation |

## Hooks

The setup includes audio notification hooks that play a sound when:
- Claude stops responding (task complete)
- Subagents complete their work

Works on macOS using `afplay`.

## Updating

To update your setup after making changes:

```bash
cd ~/claude-setup

# Copy updated files from ~/.claude
cp ~/.claude/CLAUDE.md .
cp ~/.claude/agents/*.md agents/
cp ~/.claude/commands/*.md commands/
cp ~/.claude/skills/prd/SKILL.md skills/prd/
cp ~/.claude/skills/ralph/SKILL.md skills/ralph/
cp ~/.claude/rules/delegator/*.md rules/delegator/

# Commit and push
git add .
git commit -m "Update Claude Code config"
git push
```

## License

Personal configuration - use at your own discretion.
