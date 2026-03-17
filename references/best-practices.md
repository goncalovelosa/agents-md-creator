# AGENTS.md Best Practices

Research synthesis from agents.md specification, HumanLayer, Builder.io, and production testing.

## Instruction-Following Limits

**Key Finding:** LLMs follow approximately 150-200 instructions effectively.

- GPT-4 class: ~200 instructions
- Smaller models: ~100-150 instructions
- Beyond limit: Instructions get ignored or forgotten

**Implication:** Keep AGENTS.md under 300 lines, ideally under 150.

### What Counts as an Instruction?

- Each bullet point
- Each numbered step
- Each "do this" statement
- Each code example with implied usage

**Example:**

```markdown
## Code Style
- Use single quotes              # 1 instruction
- No semicolons                  # 1 instruction
- Functional patterns preferred  # 1 instruction
```

3 instructions in 3 lines.

## Progressive Disclosure Pattern

**Principle:** Put universally applicable rules in AGENTS.md, task-specific in references/.

### What Goes in AGENTS.md?

- Dev setup (always needed)
- How to run tests (always needed)
- Core code style (always applicable)
- Build commands (always needed)
- Safety boundaries (always relevant)

### What Goes in references/?

- Detailed style guides (too long for main file)
- Architecture documentation (not always needed)
- Task-specific instructions (feature dev, bug fixes)
- Testing patterns and examples (detailed)
- API documentation (too long)

**Pattern:**

```
project/
├── AGENTS.md (<150 lines)
└── references/
    ├── detailed-style-guide.md
    ├── testing-guide.md
    ├── architecture.md
    └── common-tasks.md
```

## WHAT/WHY/HOW Framework

Structure AGENTS.md to answer:

### WHAT is this project?

```markdown
# Project Name

Brief description of what this project does.
```

### WHY does it exist?

```markdown
## Overview

Purpose and context. Why was this built? What problem does it solve?
```

### HOW do I work on it?

```markdown
## Dev Setup
## Code Style
## Testing
## CI/CD
```

## Section Ordering

Recommended order (by priority):

1. **Title + Overview** - Immediate context
2. **Dev Setup** - How to start working
3. **Code Style** - How to write code
4. **Testing** - How to verify changes
5. **CI/CD** - How changes get deployed
6. **PR Guidelines** - How to submit changes
7. **Safety** - What not to do
8. **Troubleshooting** - Common issues

## Common Mistakes

### 1. Too Long

**Problem:** 500+ line AGENTS.md gets ignored.

**Solution:** 
- Aim for <150 lines
- Move details to references/
- Remove redundant information

### 2. Task-Specific Content

**Problem:** "How to implement OAuth" in main file.

**Solution:**
- Keep main file universal
- Create `references/oauth-implementation.md`
- Link from main file if needed

### 3. Outdated Information

**Problem:** Commands that no longer work.

**Solution:**
- Test commands regularly
- Add to CI if possible
- Review monthly

### 4. Missing Context

**Problem:** Assumes agent knows project history.

**Solution:**
- Explain WHY, not just WHAT
- Add links to documentation
- Include examples

### 5. Vague Instructions

**Problem:** "Follow best practices" without specifics.

**Solution:**
- Be explicit: "Use functional components"
- Provide examples
- Link to detailed guides

## Length Guidelines

| Length | Use Case | Quality |
|--------|----------|---------|
| <60 lines | Simple projects, single purpose | Excellent |
| 60-150 lines | Standard projects | Good |
| 150-300 lines | Complex projects | Acceptable |
| >300 lines | Too long | Poor |

## Validation Checklist

Before finalizing AGENTS.md:

- [ ] Under 150 lines? (ideal)
- [ ] Under 300 lines? (required)
- [ ] Dev setup section exists?
- [ ] Test commands included?
- [ ] Code style defined?
- [ ] No task-specific content?
- [ ] All commands tested?
- [ ] Links work?
- [ ] Spelling correct?

## Agent Behavior Patterns

### What Agents Follow Well

- Numbered steps
- Bullet lists
- Code examples
- Clear "do this" statements
- Explicit file paths

### What Agents Struggle With

- Long paragraphs
- Vague guidelines
- Contradictory instructions
- Context-heavy explanations
- Implicit conventions

## Research Sources

1. **agents.md Official Spec** (agents.md)
   - 60k+ open-source projects
   - Standard format specification

2. **HumanLayer Research**
   - Instruction-following limits
   - CLAUDE.md best practices

3. **Builder.io Blog**
   - Practical implementation tips
   - Common patterns

4. **InfoQ Analysis**
   - Value assessment
   - Industry adoption

5. **Production Testing**
   - 10+ agents tested
   - Real-world validation

## Templates Summary

| Template | Lines | Use Case |
|----------|-------|----------|
| Minimal | <60 | Simple projects |
| Standard | <150 | Most projects |
| Monorepo Root | <100 | Monorepo root |
| Monorepo Package | <80 | Individual packages |

## Next Steps

After creating AGENTS.md:

1. **Test with target agent** - Does it follow instructions?
2. **Monitor for issues** - Agent ignoring sections?
3. **Iterate** - Refine based on usage
4. **Validate regularly** - Keep commands current
5. **Update as project evolves** - Keep in sync with codebase
