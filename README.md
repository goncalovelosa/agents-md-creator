# AGENTS.md Creator

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Version](https://img.shields.io/badge/Version-1.0.0-green.svg)

**Stop repeating yourself to AI coding agents.**

Every time you start a new session with Claude, Codex, or Cursor, you're wasting time explaining your project structure, coding conventions, and build commands. AGENTS.md Creator generates the context file your AI agents need to be productive from day one.

## The Problem

AI coding agents "wake up fresh" every session. They don't remember:
- Your tech stack or package manager
- Your build and test commands
- Your coding conventions and style preferences
- Your project structure and architecture decisions

This means you repeat the same instructions. Every. Single. Session.

## The Solution

AGENTS.md is the standard for AI agent context - a "README for agents" that provides everything they need to work effectively on your project. This tool generates optimized AGENTS.md files that:

- **Follow research-based best practices** from 60+ sources
- **Use progressive disclosure** - core rules in main file, details in references
- **Stay under length limits** - 335-535 words optimal for agent attention
- **Work across all major AI coding tools** - Claude Code, Codex, Cursor, Aider

## Features

- 🔍 **Automatic Context Detection** - Scans your project for package.json, go.mod, requirements.txt
- 📝 **4 Template Types** - Minimal, Standard, Monorepo Root, Monorepo Package
- ✅ **Validation Built-In** - Actionable error messages with specific solutions
- 🎯 **Progressive Disclosure** - Keeps root file slim, moves details to references/
- 🔧 **Migration Support** - Consolidates.cursorrules, CLAUDE.md, and other tool-specific files
- 📚 **Research-Based** - Built on analysis of 60+ sources on AI agent behavior
- 💡 **Workflow Guidance** - Checklists and validation loops ensure quality

## Installation

### Option 1: Clone and Use

```bash
# Clone the repository
git clone https://github.com/goncalovelosa/agents-md-creator.git

# Run from anywhere
./agents-md-creator/scripts/gather-context.sh /path/to/your/project
```

### Option 2: Download Scripts

```bash
# Download just the scripts you need
curl -O https://raw.githubusercontent.com/goncalovelosa/agents-md-creator/main/scripts/gather-context.sh
curl -O https://raw.githubusercontent.com/goncalovelosa/agents-md-creator/main/scripts/validate-agents-md.sh
chmod +x gather-context.sh validate-agents-md.sh
```

## Quick Start

```bash
# 1. Navigate to your project
cd /path/to/your/project

# 2. Gather context
/path/to/agents-md-creator/scripts/gather-context.sh

# 3. Copy a template
cp /path/to/agents-md-creator/templates/standard.md AGENTS.md

# 4. Edit with your project details
vim AGENTS.md

# 5. Validate (repeat until it passes)
/path/to/agents-md-creator/scripts/validate-agents-md.sh AGENTS.md
```

## Workflow

Follow this checklist when creating AGENTS.md:

- [ ] **1. Gather Context:** Run `scripts/gather-context.sh [project-path]`
- [ ] **2. Choose Template:** Select from `templates/` based on project type
- [ ] **3. Generate:** Copy template to project root as `AGENTS.md`
- [ ] **4. Customize:** Add project-specific details
- [ ] **5. Validate:** Run `scripts/validate-agents-md.sh AGENTS.md`
- [ ] **6. Fix Issues:** Address errors from validation
- [ ] **7. Re-validate:** Repeat until validation passes ⚠️
- [ ] **8. Commit:** Add AGENTS.md to version control

**⚠️ Only proceed to next step when validation passes.**

## Usage

### Phase 1: Context Gathering

The script scans your project for:
- Package manager (npm/yarn/pnpm/bun/pip/cargo/go mod)
- Tech stack (Node.js, Go, Rust, Python)
- Existing AI config files (.cursorrules, CLAUDE.md, etc.)
- CI/CD configuration (.github/workflows/, GitLab CI)
- Documentation (README.md, CONTRIBUTING.md)

```bash
./scripts/gather-context.sh /path/to/project
```

### Phase 2: Choose Template

| Template | Words | Lines | Best For |
|----------|-------|-------|----------|
| **Minimal** | 50-80 | <60 | Small projects, quick setup |
| **Standard** | 100-150 | <150 | Most projects |
| **Monorepo Root** | 80-120 | <100 | Multi-package root |
| **Monorepo Package** | 60-100 | <80 | Package-specific |

### Phase 3: Customize

Edit the generated AGENTS.md to add:
- Your specific coding conventions
- Build and test commands
- Dos and Don'ts specific to your team
- Architecture decisions that agents should know

**Tip:** Run `scripts/interview.sh` for interactive prompts.

### Phase 4: Validate

```bash
./scripts/validate-agents-md.sh AGENTS.md
```

**Validation checks:**
- ✅ Length (335-535 words optimal, 800 max)
- ✅ Required sections (Dev Setup, Build, Test, Code Style)
- ✅ No AI vocabulary triggers
- ✅ Standard Markdown only

**Validation loop:**
```
Generate → Validate → Fix → Validate → Repeat until ✅
```

## Templates

### Minimal Template (<60 lines)

Best for small projects or quick setup.

```markdown
# Project Name

## Dev Setup
- Install: `pnpm install`
- Dev: `pnpm dev`
- Test: `pnpm test`

## Code Style
- TypeScript strict mode
- Single quotes, no semicolons
- Functional patterns preferred

## Testing
- Run tests before committing
- Add tests for new features
```

### Standard Template (<150 lines)

Covers most project needs:
- Dev Setup
- Build/Test Commands
- Code Style (detailed)
- Testing Instructions
- PR Guidelines
- Security Notes

### Monorepo Templates

**Root file** uses progressive disclosure:
```markdown
# Project Snapshot
Brief description with key technologies.

# Root Setup Commands
`pnpm install`

# Universal Conventions
- Use Conventional Commits

# Directory Map
- Frontend: see `apps/web/AGENTS.md`
- Backend: see `apps/api/AGENTS.md`
```

**Package files** inherit from root and add specifics.

## How It Works

### Progressive Disclosure Pattern

Research shows AI agents follow ~150-200 instructions effectively. This tool uses progressive disclosure:

1. **Root AGENTS.md** - Universal rules (<300 lines, ideally <60)
2. **references/** folder - Detailed guides for specific tasks
3. **Nested AGENTS.md** - Package-specific rules in monorepos

**Rule:** Keep references one level deep only. Multi-hop navigation fails.

### Validation Rules

The tool checks for:
- ✅ Length under 300 lines (warns at >150)
- ✅ Required sections (Dev Setup, Testing, Code Style)
- ✅ No AI vocabulary ("explore", "variety", "important", etc.)
- ✅ Standard Markdown only (no `@path` imports)
- ⚠️ Word count 335-535 (optimal range)

### Actionable Errors

Validation errors provide specific solutions:

```
❌ Missing: Testing section
 Add: ## Testing
 - Run: npm test
 - Coverage: npm run test:coverage
```

Not just "Validation failed" - you know exactly what to fix.

### Research Base

This tool is built on research from:
- [agents.md Official Spec](https://agents.md/) - 60k+ projects analyzed
- [HumanLayer: Writing a Good CLAUDE.md](https://www.humanlayer.dev/blog/writing-a-good-claude-md)
- [Builder.io: AGENTS.md Best Practices](https://www.builder.io/blog/agents-md)
- Skill creation patterns - Progressive disclosure, validation loops

See `references/best-practices.md` for full synthesis.

## Project Structure

```
agents-md-creator/
├── scripts/
│ ├── gather-context.sh # Detect project type and structure
│ ├── interview.sh # Interactive preference gathering
│ └── validate-agents-md.sh # Length and structure validation
├── templates/
│ ├── minimal.md # <60 lines
│ ├── standard.md # <150 lines
│ ├── monorepo-root.md # Progressive disclosure root
│ └── monorepo-package.md # Package-specific rules
└── references/
 ├── best-practices.md # Full research synthesis
 ├── section-guide.md # When to use each section
 ├── template-guide.md # How to customize templates
 ├── migration-guide.md # Migrate from.cursorrules, etc.
 ├── patterns.md # Common AGENTS.md patterns
 ├── agent-quirks.md # Tool-specific behaviors
 ├── workflow-patterns.md # Validation loops, checklists
 └── examples/ # Real AGENTS.md files
 ├── node-api.md # Node.js REST API example
 ├── react-frontend.md # React dashboard example
 └── go-cli.md # Go CLI tool example
```

## Compatibility

The generated AGENTS.md files work with:
- **Claude Code** - Anthropic's coding assistant
- **Codex** - OpenAI's code generation
- **Cursor** - AI-powered IDE
- **Aider** - Terminal-based AI coding
- **OpenCode** - Open-source alternative
- **Windsurf** - Codeium's IDE
- **Any AI coding agent** that reads project context

## Examples

Real AGENTS.md files in `references/examples/`:

**Node.js API** (92 words)
```markdown
# Example API

Node.js/TypeScript REST API for business logic. PostgreSQL + Redis.

## Dev Setup
- Install: `pnpm install`
- Dev: `pnpm dev` (runs on :3000)
- DB: `docker compose up -d`

## Commands
- Build: `pnpm build`
- Test: `pnpm test`
- Migrate: `pnpm db:migrate`

## Code Style
- TypeScript strict mode
- Domain-Driven Design structure
- Single quotes, no semicolons
```

**React Frontend** (78 words) and **Go CLI** (87 words) also available.

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [agents.md](https://agents.md/) for the specification and community
- [HumanLayer](https://www.humanlayer.dev/) for research on AI instruction following
- [Builder.io](https://www.builder.io/) for practical AGENTS.md guidance
