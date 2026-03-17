# Template Usage Guide

This guide explains how to use each template and what the placeholders mean.

## Available Templates

### 1. Minimal Template

**File:** `templates/minimal.md`

**Best for:**
- Simple projects
- Single developer
- Quick setup
- Projects with minimal conventions

**When to use:**
- Prototype or proof-of-concept
- Personal projects
- Projects with few conventions
- Getting started quickly

**Placeholders:**

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[Project Name]` | Your project's name | `User Service API` |
| `npm` | Package manager | `pnpm`, `yarn`, `bun` |
| `[Formatting preferences]` | Code style rules | `Single quotes, no semicolons` |
| `[Key patterns]` | Important conventions | `Functional components only` |

**Example filled:**
```markdown
# Task Runner CLI

## Dev Setup
- Install: `npm install`
- Dev: `npm run dev`
- Test: `npm test`

## Code Style
- Single quotes, no semicolons
- Functional programming preferred

## Testing
- Run before committing
- Add tests for new features
```

### 2. Standard Template

**File:** `templates/standard.md`

**Best for:**
- Most projects
- Small teams (2-5 people)
- Standard development workflows
- Projects with CI/CD

**When to use:**
- Production projects
- Team collaboration
- Projects with testing requirements
- Standard git workflows

**Placeholders:**

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[Project Name]` | Your project's name | `E-commerce Platform` |
| `pnpm` | Package manager | `npm`, `yarn`, `bun` |
| `[Language/framework conventions]` | Tech stack specifics | `TypeScript strict mode` |
| `[Formatting rules]` | Code style rules | `Prettier with 2-space indent` |
| `[Design patterns]` | Architectural patterns | `Repository pattern, DDD` |
| `[Naming conventions]` | Variable/function naming | `camelCase for variables` |
| `[Coverage expectations]` | Test coverage goals | `Minimum 80% coverage` |
| `[Test patterns]` | Testing conventions | `Jest + React Testing Library` |
| `[PR requirements]` | Pull request rules | `Require 1 approval, pass CI` |
| `[destructive operations]` | Dangerous actions | `Database migrations, deploys` |

**Example filled:**
```markdown
# E-commerce Platform

## Dev Setup
- Install: `pnpm install`
- Dev: `pnpm dev`
- Build: `pnpm build`
- Test: `pnpm test`
- Lint: `pnpm lint`

## Code Style
- TypeScript strict mode
- Single quotes, semicolons required
- Repository pattern with DDD
- camelCase for variables, PascalCase for types

## Testing
- Run tests before committing
- Add tests for new features
- Minimum 80% coverage
- Jest + React Testing Library

## PR Guidelines
- Create feature branch: `git checkout -b feat/description`
- Run tests + lint before PR
- Require 1 approval, pass CI

## Safety
- Ask before: Database migrations, production deploys
- Protected branches: main, master
```

### 3. Monorepo Root Template

**File:** `templates/monorepo-root.md`

**Best for:**
- Monorepo root directory
- Shared rules across packages
- Organizations with multiple projects

**When to use:**
- Monorepo setup
- Shared conventions
- Multiple related packages

**Placeholders:**

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[Monorepo Name]` | Monorepo name | `Company Platform` |
| `[Shared formatting rules]` | Universal style | `Prettier config in root` |
| `[Shared patterns]` | Common conventions | `ESLint rules for all packages` |

**Example filled:**
```markdown
# Company Platform

## Structure
- `/packages/web` - Web frontend
- `/packages/api` - Backend API
- `/shared` - Shared utilities
- `/docs` - Documentation

## Dev Setup (All Packages)
- Install: `pnpm install`
- Build all: `pnpm build`
- Test all: `pnpm test`

## Code Style (Universal)
- Prettier config in root
- ESLint rules for all packages
- TypeScript strict mode

## Package-Specific Rules
See `AGENTS.md` in each package directory.
```

### 4. Monorepo Package Template

**File:** `templates/monorepo-package.md`

**Best for:**
- Individual packages in monorepo
- Package-specific conventions
- Detailed package instructions

**When to use:**
- Each package in monorepo
- Package-specific workflows
- Different tech stacks per package

**Placeholders:**

| Placeholder | Description | Example |
|-------------|-------------|---------|
| `[Package Name]` | Package name | `@company/web` |
| `[This package's patterns]` | Package-specific rules | `React functional components` |
| `[Unique requirements]` | Special needs | `SSR with Next.js` |
| `[Package-specific test patterns]` | Testing approach | `Cypress for E2E` |

**Example filled:**
```markdown
# @company/web

## Dev Setup
- Install: `pnpm install`
- Dev: `pnpm dev`
- Test: `pnpm test`

## Package-Specific Conventions
- React functional components only
- Tailwind CSS for styling
- Next.js App Router

## Testing
- Jest for unit tests
- Cypress for E2E tests

## See Also
- Root AGENTS.md for shared rules
- `../api/AGENTS.md` for backend conventions
```

## Filling Templates

### Manual Approach

1. Copy template to your project: `cp templates/standard.md AGENTS.md`
2. Replace placeholders with your values
3. Remove sections that don't apply
4. Validate: `scripts/validate-agents-md.sh AGENTS.md`

### Interactive Interview

1. Run interview script: `scripts/interview.sh`
2. Answer questions about your project
3. Script generates `.agents-md-context.json`
4. Use context to fill template

### Automated Generation

Future enhancement: Script that combines interview + template automatically.

## Customizing Templates

### Adding Custom Sections

After filling template, add sections specific to your project:

```markdown
## API Conventions
- RESTful endpoints
- JSON responses
- Error format: `{ error: string, code: string }`
```

### Removing Sections

If a section doesn't apply, remove it:

```markdown
<!-- Remove if not using CI/CD -->
## PR Guidelines
...
```

### Combining Templates

For complex projects, combine elements:

- Use monorepo root template for shared rules
- Use package template for each package
- Add custom sections as needed

## Common Mistakes

1. **Leaving placeholders**: Always replace `[...]` with actual values
2. **Too many sections**: Keep it simple, move details to references/
3. **Inconsistent formatting**: Follow the template's structure
4. **Missing validation**: Always run validate-agents-md.sh after filling

## Next Steps

After filling template:
1. Validate: `scripts/validate-agents-md.sh AGENTS.md`
2. Test with your AI agent
3. Iterate based on agent behavior
4. Move detailed content to references/ if needed
