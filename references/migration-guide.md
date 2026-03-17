# Migration Guide

How to migrate from tool-specific config files to AGENTS.md.

## Why Migrate?

**Problems with tool-specific files:**

1. **Fragmentation:** .cursorrules for Cursor, CLAUDE.md for Claude, etc.
2. **Duplication:** Same rules in multiple files
3. **Inconsistency:** Different formats, different content
4. **Maintenance:** Update multiple files for one change

**Benefits of AGENTS.md:**

1. **Single source of truth:** One file for all agents
2. **Standard format:** Works across tools
3. **Easier maintenance:** Update once, all agents benefit
4. **Progressive disclosure:** Main file + references/ pattern

## Migration Strategies

### Strategy 1: Merge All

Combine all existing files into AGENTS.md.

**Best for:**
- Small existing files
- Similar content across files
- Starting fresh

**Steps:**
1. List all AI config files
2. Extract unique rules from each
3. Combine into AGENTS.md
4. Remove duplication
5. Validate length (<300 lines)
6. Delete old files

### Strategy 2: Keep Best

Pick the best file as base, merge others into it.

**Best for:**
- One file is comprehensive
- Others are subsets
- Clear primary source

**Steps:**
1. Identify most complete file
2. Rename to AGENTS.md
3. Merge unique content from others
4. Remove duplication
5. Delete old files

### Strategy 3: Rebuild

Start fresh, use existing files as reference only.

**Best for:**
- Existing files are messy
- Outdated information
- Want clean start

**Steps:**
1. Read existing files for context
2. Create new AGENTS.md from template
3. Incorporate relevant rules
4. Validate with agent testing
5. Delete old files

## File-Specific Migration

### .cursorrules → AGENTS.md

**Format difference:**
- .cursorrules: Plain text, no structure
- AGENTS.md: Markdown with sections

**Migration steps:**

1. **Extract rules:**
   ```bash
   cat .cursorrules
   ```

2. **Categorize:**
   - Setup rules → Dev Setup section
   - Style rules → Code Style section
   - Test rules → Testing section
   - Other rules → Appropriate section

3. **Convert to Markdown:**
   ```markdown
   # From .cursorrules:
   
   ## Code Style
   - [Rule from .cursorrules]
   - [Rule from .cursorrules]
   ```

4. **Validate:** Ensure <300 lines

5. **Delete:** Remove .cursorrules

**Example:**

Before (.cursorrules):
```
Use TypeScript strict mode
Single quotes, no semicolons
Run tests before committing
Never commit to main directly
```

After (AGENTS.md):
```markdown
# Project Name

## Code Style
- TypeScript strict mode
- Single quotes, no semicolons

## Testing
- Run tests before committing

## Safety
- Never commit directly to main
```

### CLAUDE.md → AGENTS.md

**Format difference:**
- CLAUDE.md: Already Markdown
- May be longer, more detailed

**Migration steps:**

1. **Assess length:**
   ```bash
   wc -l CLAUDE.md
   ```

2. **If <300 lines:**
   - Rename to AGENTS.md
   - Review and clean up
   - Done

3. **If >300 lines:**
   - Keep universal rules in AGENTS.md
   - Move detailed content to references/
   - Example structure:
     ```
     AGENTS.md (core rules, <150 lines)
     references/
       detailed-guide.md (from CLAUDE.md)
     ```

4. **Delete:** Remove CLAUDE.md

**Example:**

Before (CLAUDE.md - 200 lines):
```markdown
# Project Guidelines

## Setup
[detailed setup with examples]

## Code Style
[50 lines of style rules]

## Testing
[detailed testing patterns]

## Architecture
[full project structure]
```

After (AGENTS.md - 100 lines):
```markdown
# Project Name

## Dev Setup
- `pnpm install && pnpm dev`

## Code Style
- TypeScript strict mode
- See references/detailed-guide.md for full style guide

## Testing
- `pnpm test`
- See references/detailed-guide.md for testing patterns
```

### .windsurfrules → AGENTS.md

**Format difference:**
- Similar to .cursorrules
- May have Windsurf-specific syntax

**Migration steps:**

1. **Remove Windsurf-specific syntax:**
   - Remove tool-specific directives
   - Keep general rules

2. **Follow .cursorrules migration:**
   - See above

3. **Delete:** Remove .windsurfrules

### copilot-instructions.md → AGENTS.md

**Format difference:**
- Markdown format
- Often GitHub-specific

**Migration steps:**

1. **Extract general rules:**
   - Remove GitHub-specific content
   - Keep project rules

2. **Merge into AGENTS.md:**
   - Follow CLAUDE.md migration

3. **Delete:** Remove copilot-instructions.md

## Handling Multiple Files

When you have multiple config files:

```
project/
├── .cursorrules (50 lines)
├── CLAUDE.md (100 lines)
├── .windsurfrules (30 lines)
└── copilot-instructions.md (40 lines)
```

**Step 1: Inventory**

```bash
# List all AI config files
find . -name ".cursorrules" -o -name "CLAUDE.md" -o -name ".windsurfrules" -o -name "copilot-instructions.md"
```

**Step 2: Extract unique rules**

```bash
# Combine all files
cat .cursorrules CLAUDE.md .windsurfrules copilot-instructions.md > combined.txt

# Review for duplication and conflicts
```

**Step 3: Resolve conflicts**

| File A Says | File B Says | Resolution |
|-------------|-------------|------------|
| Single quotes | Double quotes | Pick one, document |
| Tabs | Spaces | Pick one, document |
| Semicolons | No semicolons | Pick one, document |

**Step 4: Create AGENTS.md**

- Merge unique rules
- Resolve conflicts
- Structure with sections

**Step 5: Create references/ (if needed)**

- Move detailed content
- Keep main file <300 lines

**Step 6: Delete old files**

```bash
rm .cursorrules CLAUDE.md .windsurfrules copilot-instructions.md
```

## Testing Migration

After migration:

1. **Validate structure:**
   ```bash
   scripts/validate-agents-md.sh AGENTS.md
   ```

2. **Test with agents:**
   - Open project in target agent
   - Ask agent to perform task
   - Verify it follows instructions

3. **Compare behavior:**
   - Before: Agent behavior with old files
   - After: Agent behavior with AGENTS.md
   - Should be equivalent or better

4. **Iterate:**
   - If agent misses rules, make them clearer
   - If file too long, move content to references/

## Rollback Plan

Keep old files until migration verified:

```bash
# Backup before migration
mkdir -p .backup
cp .cursorrules CLAUDE.md .windsurfrules .backup/ 2>/dev/null

# After successful migration (tested with agents)
rm -rf .backup
```

## Common Issues

### Issue: Agent not following rules after migration

**Cause:** Rules unclear or file too long.

**Solution:**
1. Check validation output
2. Simplify rules
3. Make instructions more explicit
4. Move detailed content to references/

### Issue: Lost rules during migration

**Cause:** Missed content during merge.

**Solution:**
1. Keep backup until verified
2. Compare old files with new AGENTS.md
3. Test all use cases

### Issue: Conflicting rules from different files

**Cause:** Different tools had different conventions.

**Solution:**
1. Pick one convention
2. Document choice
3. Update codebase if needed

## Migration Checklist

- [ ] List all existing AI config files
- [ ] Extract unique rules from each
- [ ] Identify conflicts
- [ ] Resolve conflicts
- [ ] Create AGENTS.md with merged rules
- [ ] Create references/ if needed
- [ ] Validate AGENTS.md (<300 lines)
- [ ] Test with target agents
- [ ] Backup old files
- [ ] Delete old files
- [ ] Commit migration

## Post-Migration

After successful migration:

1. **Document in repo:**
   - Add note to README.md about AGENTS.md
   - Mention in CONTRIBUTING.md

2. **Team communication:**
   - Notify team about new AGENTS.md
   - Explain migration benefits
   - Provide usage tips

3. **Maintenance:**
   - Review monthly
   - Update as project evolves
   - Keep commands current
