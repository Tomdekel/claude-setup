
## UI/Frontend Rules

For ANY UI or frontend task:
1. Before implementation: use ux-reviewer subagent to validate the plan
2. After implementation: use ux-reviewer subagent to audit the result
3. Do not mark UI work complete until ux-reviewer approves

This is mandatory, not optional.

## Code Quality Rules

For ANY code changes:
1. After implementation: use code-reviewer to check for security/bugs
2. After features complete: use qa-tester to identify edge cases
3. Do not mark work complete until reviewers approve

## Agent Workflow
- UI work → ux-reviewer (before + after)
- All code → code-reviewer (after)
- Features → qa-tester (after)

## GPT Expert Delegation (claude-delegator)

Delegate to GPT experts via the codex MCP server for:

**Architect**
- System design decisions, architecture questions
- "How should I structure this?"
- "What are the tradeoffs between X and Y?"

**Plan Reviewer**
- Before starting significant implementations
- Validate migration plans, refactoring strategies

**Scope Analyst**
- When requirements seem ambiguous
- "What am I missing?"
- "Are there edge cases I haven't considered?"

**Code Reviewer**
- After implementing complex features (complements code-reviewer subagent)
- Get second opinion on tricky implementations

**Security Analyst**
- Auth flows, API endpoints, data handling
- "Is this secure?"
- "Review this endpoint for vulnerabilities"

**Stuck on Bugs**
- After 2+ failed attempts to fix a bug, delegate to GPT for a fresh perspective
- Include what was tried and why it failed

### When NOT to delegate:
- Simple file operations
- First attempt at any fix (try yourself first)
- Trivial questions with obvious answers

### Limit-Aware Delegation

Claude Code does the work. Codex is for specific delegation scenarios above.

**Periodic limit check:** At session start and periodically during long sessions, ask the user about Claude usage limits status.

**When user indicates limits are running low:**
- Expand the range of tasks delegated to Codex
- Tasks that CC would normally handle can be sent to Codex
- CC focuses on orchestration, planning, and synthesis
- Codex handles more of the implementation work

**Normal operation (limits OK):**
- CC handles most tasks directly
- Only delegate to Codex per the expert rules above (architecture, stuck bugs, security, etc.)

## UI Generation Rules

When creating new UI components or pages:
1. Use the v0-mcp tools (v0_generate_ui) to generate the initial design
2. Then have ux-reviewer validate the output
3. Refine as needed before integrating into the project

For converting designs/screenshots to code:
- Use v0_generate_from_image with the image

Do not manually write UI from scratch - always start with v0.

## MCP Usage Rules

**Database (postgres-mcp, supabase)**
- Use for schema introspection, queries, and migrations
- Always check schema before writing queries

**Deployment (vercel, gcloud)**
- Use vercel for frontend/edge deployments
- Use gcloud for backend services, Cloud Run, BigQuery

**Browser/Testing (playwright, chrome-devtools)**
- Use playwright for E2E tests and browser automation
- Use chrome-devtools for debugging, network inspection

**GitHub**
- Use for PR creation, issue management, code review
- Prefer gh CLI for complex git operations

**Figma**
- Use figma MCP to inspect designs and extract specs
- Combine with v0 for design-to-code workflows

## Session Handoff
- On session start: Check for HANDOFF.md and read it to restore context
- On session end: Offer to write HANDOFF.md with what was accomplished, current state, and next steps
