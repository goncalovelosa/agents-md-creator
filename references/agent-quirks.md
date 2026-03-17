# Agent-Specific Quirks

Different AI coding agents have unique behaviors and preferences when reading AGENTS.md files. This guide helps you tailor your AGENTS.md for specific agents or write universally compatible files.

## Codex

**Strengths:**
- Prefers bullet lists over paragraphs
- Follows numbered steps precisely
- Good at understanding structured data

**Limitations:**
- Ignores very long sections (>200 lines)
- May miss context buried in prose

**Best Practices:**
- Use bullet lists for instructions
- Number steps in order
- Keep sections concise
- Put critical info at the top

## Claude Code

**Strengths:**
- Handles longer context well (up to 500 lines)
- Good at following multi-step instructions
- Understands conditional logic

**Limitations:**
- May need explicit "do X before Y" ordering
- Can get confused by ambiguous instructions

**Best Practices:**
- Use explicit ordering when steps matter
- Include WHY along with WHAT
- Provide examples for complex patterns
- Use conditional sections for task-specific rules

## OpenCode

**Strengths:**
- Similar to Codex in behavior
- Works well with references/ folder
- Good at file-based context

**Limitations:**
- May need shorter sections than Claude Code
- Prefers explicit file paths

**Best Practices:**
- Keep AGENTS.md <150 lines
- Use references/ for detailed guides
- Include specific file paths
- Separate concerns into different sections

## Cursor

**Strengths:**
- Expects .cursorrules format compatibility
- Can read AGENTS.md directly
- Good IDE integration

**Limitations:**
- Prefers concise instructions
- May ignore verbose sections

**Best Practices:**
- Migrate from .cursorrules carefully
- Keep instructions direct and actionable
- Use standard Markdown
- Test after migration

## Aider

**Strengths:**
- Works with any markdown file
- Good at following conventions
- Handles git-based workflows well

**Limitations:**
- May need explicit file paths
- Less context than Claude Code

**Best Practices:**
- Provide explicit file paths when needed
- Document git conventions
- Use standard Markdown
- Include test commands

## Universal Compatibility

To create an AGENTS.md that works well with all agents:

1. **Keep it short** (<150 lines ideal, <300 max)
2. **Use bullet lists** for instructions
3. **Number steps** when order matters
4. **Put critical info first** (closest wins)
5. **Use references/** for detailed guides
6. **Test with multiple agents** if possible

## Choosing the Right Length

| Agent Type | Optimal Length | Max Length |
|------------|----------------|------------|
| Codex-like | <100 lines | 200 lines |
| Claude Code | <300 lines | 500 lines |
| Universal | <150 lines | 300 lines |

## When to Use Agent-Specific Files

If you work primarily with one agent, consider:

- **Codex/OpenCode**: Keep AGENTS.md very short, use references/ heavily
- **Claude Code**: Can include more detail in AGENTS.md
- **Cursor**: Migrate from .cursorrules, test thoroughly
- **Aider**: Focus on git conventions and file paths

For teams using multiple agents, aim for universal compatibility (short, structured, with references/).
