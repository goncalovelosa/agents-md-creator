# Workflow Patterns for AGENTS.md Creation

## Validation Loop Pattern

**The Pattern:**
```
Generate → Validate → Fix → Validate → Repeat until ✅
```

**Why it matters:** AI agents perform significantly better with validated AGENTS.md files. Validation catches common issues that reduce agent effectiveness.

**Implementation in SKILL.md:**
```markdown
## Workflow Checklist

- [ ] 1. Gather context
- [ ] 2. Choose template
- [ ] 3. Generate AGENTS.md
- [ ] 4. Validate
- [ ] 5. Fix issues
- [ ] 6. Re-validate ⚠️
- [ ] 7. Only proceed when validation passes
```

**Key phrase:** "Only proceed when validation passes" - prevents agents from skipping validation.

## Progressive Disclosure Pattern

**The Problem:** Loading all context at once wastes tokens and reduces effectiveness.

**The Solution:** Three-stage loading:

1. **Metadata (startup):** Frontmatter `name` + `description`
2. **Body (triggered):** SKILL.md content (<500 lines)
3. **References (on-demand):** External files in `references/`

**Implementation:**
```
skill/
├── SKILL.md              # Core instructions (<500 lines)
└── references/
    ├── api-guide.md      # Detailed API docs
    ├── testing.md        # Testing patterns
    └── examples/         # Real examples
```

**Rule:** References one level deep only. Multi-hop navigation (`SKILL.md` → `guide.md` → `details.md`) fails.

## Freedom Calibration Pattern

**The Insight:** Different tasks need different levels of constraint.

**Three levels:**

| Level | When to Use | Example |
|-------|-------------|---------|
| **Low freedom** | Error-prone, must be exact | Database migrations, deployment steps |
| **Medium freedom** | Standardized output, configurable | Reports, AGENTS.md generation |
| **High freedom** | Multiple valid approaches | Code review, refactoring |

**For AGENTS.md creation:** Use **medium freedom**
- Provide templates (standardized)
- Allow customization (configurable)
- Enforce validation (quality gate)

**Not low:** Every project is different, needs flexibility
**Not high:** AGENTS.md has specific structure requirements

## Markdown Checklist Pattern

**The Pattern:** Provide markdown checklists for multi-step processes.

**Example:**
```markdown
## Workflow Checklist

- [ ] 1. Gather context
- [ ] 2. Choose template
- [ ] 3. Generate AGENTS.md
- [ ] 4. Validate
- [ ] 5. Fix issues
- [ ] 6. Re-validate
```

**Why it works:**
- Agents copy checklist into response
- Check off items as they progress
- Ensures no steps skipped
- Visible progress tracking

## Error Message Pattern

**The Problem:** Vague errors cause agents to guess randomly.

**Bad error:**
```
Validation failed
```

**Good error:**
```
❌ Missing: Testing section
   Add: ## Testing
        - Run: npm test
        - Coverage: npm run test:coverage
```

**Pattern:**
1. **What's wrong:** Clear error message
2. **Where:** Specific location (section, line)
3. **How to fix:** Actionable solution with example

## Deterministic Script Pattern

**The Insight:** Scripts should handle tasks requiring consistency.

**Principle:**
- Scripts = deterministic, error-prone tasks
- Agents = interpretation, generation, conversation

**Example:**
```bash
# Good: Script calculates score (deterministic)
./scripts/validate-agents-md.sh AGENTS.md

# Bad: Ask agent to "check if AGENTS.md is good" (inconsistent)
```

**Why:** LLMs generate inconsistent "vibes-based" results for deterministic tasks.

## Exception Handling Pattern

**The Problem:** Scripts that crash with stack traces confuse agents.

**Bad:**
```bash
if [ ! -f "$FILE" ]; then
    exit 1  # Unhelpful exit code
fi
```

**Good:**
```bash
if [ ! -f "$FILE" ]; then
    echo "❌ Error: File not found: $FILE"
    echo "   Solution: Create file first using template:"
    echo "     cp templates/standard.md $FILE"
    exit 1
fi
```

**Pattern:**
1. Clear error message
2. Specific file/location
3. Suggested solution
4. Example command if applicable

## Real-World Examples

### Block Engineering "Repo Readiness" Skill

**Pattern:** Deterministic script + agent interpretation
- Script: Calculate hard pass/fail score (bash)
- Agent: Interpret results, converse with user, generate files

**Why it works:** Script prevents "vibes-based" scoring, agent handles nuance.

### Atmos Framework Skills

**Pattern:** Highly focused skills (20+ separate skills)
- `atmos-terraform` - Orchestration only
- `atmos-validation` - Policy checks only
- `atmos-stacks` - YAML manifests only

**Why it works:** Single responsibility, clear triggers, modular loading.

### PDF Form Processing Skill

**Pattern:** Multi-step with validation loops
1. Extract fields
2. Map values
3. Validate
4. Fill form

**Validation loop:** "Only execute final fill when validation passes"

## Implementation Checklist

When creating a skill, ensure:

- [ ] **Progressive disclosure:** SKILL.md <500 lines, references one level deep
- [ ] **Validation loop:** Clear pattern with "only proceed when passes"
- [ ] **Markdown checklist:** Multi-step processes documented
- [ ] **Actionable errors:** Scripts provide specific solutions
- [ ] **Deterministic scripts:** Handle consistency tasks
- [ ] **Exception handling:** Graceful failures with guidance
- [ ] **Freedom calibration:** Match constraint level to task fragility
