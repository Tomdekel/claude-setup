#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

CLAUDE_DIR="$HOME/.claude"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}========================================${NC}"
echo -e "${BLUE}   Claude Code Setup Script${NC}"
echo -e "${BLUE}========================================${NC}"
echo ""

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo -e "${RED}Error: Claude Code CLI not found.${NC}"
    echo "Install it first: https://claude.ai/claude-code"
    exit 1
fi

# Create base directories (only for non-symlinked dirs)
echo -e "${YELLOW}Creating directories...${NC}"
mkdir -p "$CLAUDE_DIR"/{skills,mcp-servers}

# Helper function to create symlink (backs up existing if not a symlink)
create_symlink() {
    local source="$1"
    local target="$2"

    if [ -L "$target" ]; then
        # Already a symlink, remove it
        rm "$target"
    elif [ -e "$target" ]; then
        # Exists but not a symlink, backup
        echo -e "${YELLOW}  Backing up existing $(basename "$target")...${NC}"
        mv "$target" "${target}.backup"
    fi

    ln -s "$source" "$target"
    echo -e "${GREEN}  Linked: $(basename "$target")${NC}"
}

echo -e "${YELLOW}Creating symlinks (changes will auto-sync to git)...${NC}"
echo ""

# Symlink CLAUDE.md
create_symlink "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"

# Symlink entire directories
create_symlink "$SCRIPT_DIR/agents" "$CLAUDE_DIR/agents"
create_symlink "$SCRIPT_DIR/commands" "$CLAUDE_DIR/commands"
create_symlink "$SCRIPT_DIR/rules" "$CLAUDE_DIR/rules"

# Symlink skill subdirectories (not the whole skills dir - it has built-in skills)
create_symlink "$SCRIPT_DIR/skills/prd" "$CLAUDE_DIR/skills/prd"
create_symlink "$SCRIPT_DIR/skills/ralph" "$CLAUDE_DIR/skills/ralph"
# Symlink individual skill files at root level
for f in "$SCRIPT_DIR/skills/"*.md; do
    if [ -f "$f" ]; then
        fname=$(basename "$f")
        create_symlink "$f" "$CLAUDE_DIR/skills/$fname"
    fi
done

echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   Symlinks created successfully!${NC}"
echo -e "${GREEN}========================================${NC}"
echo -e "${BLUE}Changes to ~/.claude config files now go to:${NC}"
echo -e "${BLUE}  $SCRIPT_DIR${NC}"
echo -e "${BLUE}Just 'git add/commit/push' from there!${NC}"
echo ""

# Plugin installation
echo -e "${YELLOW}Installing plugins...${NC}"
echo ""

# Add marketplaces
echo -e "${BLUE}Adding plugin marketplaces...${NC}"
claude plugins marketplace add dvdsgl/claude-canvas 2>/dev/null || echo "  (claude-canvas marketplace may already exist)"
claude plugins marketplace add jarrodwatts/claude-delegator 2>/dev/null || echo "  (claude-delegator marketplace may already exist)"
claude plugins marketplace add jarrodwatts/claude-hud 2>/dev/null || echo "  (claude-hud marketplace may already exist)"
claude plugins marketplace add thedotmack/claude-mem 2>/dev/null || echo "  (claude-mem marketplace may already exist)"
claude plugins marketplace add kingbootoshi/cartographer 2>/dev/null || echo "  (cartographer marketplace may already exist)"

# Install plugins
echo -e "${BLUE}Installing plugins...${NC}"
claude plugins install canvas@claude-canvas 2>/dev/null || echo "  (canvas may already be installed)"
claude plugins install claude-delegator@jarrodwatts-claude-delegator 2>/dev/null || echo "  (claude-delegator may already be installed)"
claude plugins install claude-hud@jarrodwatts-claude-hud 2>/dev/null || echo "  (claude-hud may already be installed)"
claude plugins install claude-mem@thedotmack-claude-mem 2>/dev/null || echo "  (claude-mem may already be installed)"
claude plugins install cartographer@kingbootoshi-cartographer 2>/dev/null || echo "  (cartographer may already be installed)"

echo ""
echo -e "${GREEN}Plugins installed!${NC}"
echo ""

# v0-mcp installation
echo -e "${YELLOW}Installing v0-mcp server...${NC}"
if [ -d "$CLAUDE_DIR/mcp-servers/v0-mcp" ]; then
    echo -e "${YELLOW}  v0-mcp already exists, pulling latest...${NC}"
    cd "$CLAUDE_DIR/mcp-servers/v0-mcp"
    git pull || true
else
    echo -e "${BLUE}  Cloning v0-mcp...${NC}"
    git clone https://github.com/nicepkg/v0-mcp.git "$CLAUDE_DIR/mcp-servers/v0-mcp"
    cd "$CLAUDE_DIR/mcp-servers/v0-mcp"
fi

echo -e "${BLUE}  Installing dependencies...${NC}"
npm install
echo -e "${BLUE}  Building...${NC}"
npm run build

echo ""
echo -e "${GREEN}v0-mcp installed!${NC}"
echo ""

# Settings merge instructions
echo -e "${RED}========================================${NC}"
echo -e "${RED}   MANUAL STEPS REQUIRED${NC}"
echo -e "${RED}========================================${NC}"
echo ""
echo -e "${YELLOW}1. Merge settings:${NC}"
echo "   Review and merge settings.template.json into ~/.claude/settings.json"
echo "   This includes hooks and plugin enablement."
echo ""
echo -e "${YELLOW}2. Configure MCP servers:${NC}"
echo "   Review mcp-servers.template.json and add servers via:"
echo ""
echo "   ${BLUE}Global servers (add with -s user):${NC}"
echo "   claude mcp add vercel -s user --transport http https://mcp.vercel.com/mcp"
echo "   claude mcp add supabase -s user --transport http https://mcp.supabase.com/mcp"
echo "   claude mcp add chrome-devtools -s user -- npx -y chrome-devtools-mcp@latest"
echo "   claude mcp add playwright -s user -- npx -y @playwright/mcp@latest"
echo "   claude mcp add github -s user -- npx -y @modelcontextprotocol/server-github"
echo ""
echo "   ${BLUE}Project servers (add to specific project):${NC}"
echo "   claude mcp add context7 -- npx -y @upstash/context7-mcp@latest"
echo "   claude mcp add figma --transport http https://mcp.figma.com/mcp"
echo "   claude mcp add gcloud -- npx -y @google-cloud/gcloud-mcp"
echo "   claude mcp add postgres-mcp -- uvx --python 3.12 postgres-mcp --access-mode=unrestricted"
echo ""
echo -e "${YELLOW}3. Set environment variables / secrets:${NC}"
echo "   - V0_API_KEY: Get from v0.dev"
echo "   - DATABASE_URI: Your PostgreSQL connection string"
echo "   - Install 'codex' CLI for GPT delegation"
echo "   - Configure 'gh' CLI for GitHub access"
echo "   - Configure 'gcloud' CLI for Google Cloud"
echo ""
echo -e "${YELLOW}4. Enable plugins in settings:${NC}"
echo "   Ensure ~/.claude/settings.json has:"
echo '   "enabledPlugins": {'
echo '     "figma@claude-plugins-official": true,'
echo '     "canvas@claude-canvas": true,'
echo '     "claude-delegator@jarrodwatts-claude-delegator": true,'
echo '     "claude-hud@jarrodwatts-claude-hud": true,'
echo '     "claude-mem@thedotmack-claude-mem": true,'
echo '     "cartographer@kingbootoshi-cartographer": true'
echo '   }'
echo ""
echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}   Setup complete!${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""
echo "Run 'claude' to start using your configured environment."
