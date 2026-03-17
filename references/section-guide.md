# Section Guide

When to include each section in AGENTS.md.

## Essential Sections (Always Include)

### Title (H1)

**Always required.** Single H1 heading with project name.

```markdown
# Project Name
```

**Why:** Identifies project immediately. Required for proper structure.

### Dev Setup

**Always include.** How to start working on the project.

```markdown
## Dev Setup

### Installation
- `pnpm install`

### Development
- `pnpm dev`

### Build
- `pnpm build`
```

**Include when:** Always. Every project has setup steps.

**Omit when:** Never. Even simple projects need setup.

### Testing

**Include when:** Project has tests (should be always).

```markdown
## Testing

- Run tests: `pnpm test`
- Coverage: `pnpm test:coverage`
- Target: 80%
```

**Include when:** Tests exist.

**Omit when:** No tests (but consider adding them).

## Recommended Sections (Usually Include)

### Code Style

**Include when:** Project has code conventions.

```markdown
## Code Style

- TypeScript strict mode
- Single quotes, no semicolons
- Functional patterns preferred
```

**Include when:** 
- Team project
- Specific conventions matter
- Multiple contributors

**Omit when:**
- Trivial project
- No specific conventions

### Build

**Include when:** Build step exists.

```markdown
## Build

- Production: `pnpm build`
- Staging: `pnpm build:staging`
```

**Include when:**
- Compiled language
- Bundling step
- Multiple environments

**Omit when:**
- No build step
- Simple deployment

### CI/CD

**Include when:** Pipeline exists.

```markdown
## CI/CD

- Runs on: push to main, PRs
- Steps: lint → test → build
- Required: All checks pass
```

**Include when:**
- Automated pipeline
- Required checks
- Deployment automation

**Omit when:**
- Manual deployment
- No CI/CD

### PR Guidelines

**Include when:** Team project.

```markdown
## PR Guidelines

### Title Format
`type: description`

Types: feat, fix, docs, refactor, test, chore

### Requirements
- [ ] Tests pass
- [ ] Lint clean
- [ ] Description clear
```

**Include when:**
- Multiple contributors
- Code review process
- PR-based workflow

**Omit when:**
- Solo project
- Direct commits

## Optional Sections (Include When Relevant)

### Safety

**Include when:** Destructive or sensitive operations possible.

```markdown
## Safety

### Requires Approval
- Deployments to production
- Database migrations
- API key changes

### Never Do
- Delete production data
- Force push to main
```

**Include when:**
- Production access
- Destructive operations
- Sensitive data

**Omit when:**
- Local-only project
- No sensitive operations

### Architecture

**Include when:** Complex project structure.

```markdown
## Architecture

src/
├── api/          # REST endpoints
├── services/     # Business logic
├── models/       # Data models
└── utils/        # Helpers
```

**Include when:**
- Non-obvious structure
- Many directories
- Specific organization matters

**Omit when:**
- Simple structure
- Self-explanatory layout

**Alternative:** Move to `references/architecture.md` if long.

### Troubleshooting

**Include when:** Common issues exist.

```markdown
## Troubleshooting

### Port Already in Use
- Cause: Previous dev server running
- Fix: `kill -9 $(lsof -t -i:3000)`
```

**Include when:**
- Known issues
- Environment-specific problems
- Common gotchas

**Omit when:**
- No known issues
- Fresh project

### API Documentation

**Include when:** Public API.

```markdown
## API

### GET /users
Returns list of users.

### POST /users
Creates new user.
```

**Include when:**
- Public API
- Multiple endpoints
- Consumers need reference

**Omit when:**
- Internal only
- API is trivial

**Alternative:** Move to `references/api.md` if long.

### Security

**Include when:** Security considerations exist.

```markdown
## Security

- Never commit secrets
- Use environment variables
- Validate all inputs
```

**Include when:**
- Handles sensitive data
- Public-facing
- Security requirements

**Omit when:**
- No security concerns
- Local-only

### Performance

**Include when:** Performance matters.

```markdown
## Performance

- Lazy load images
- Code split by route
- Cache API responses
```

**Include when:**
- Performance requirements
- Known bottlenecks
- Optimization patterns

**Omit when:**
- Not a concern

## Section Order

Recommended order:

1. Title (H1)
2. Overview (optional)
3. Dev Setup
4. Code Style
5. Testing
6. Build
7. CI/CD
8. PR Guidelines
9. Safety
10. Architecture
11. Troubleshooting

## Section Length Guidelines

| Section | Ideal Lines | Max Lines |
|---------|-------------|-----------|
| Title + Overview | 5 | 10 |
| Dev Setup | 10 | 20 |
| Code Style | 10 | 30 |
| Testing | 10 | 20 |
| Build | 5 | 10 |
| CI/CD | 10 | 15 |
| PR Guidelines | 10 | 20 |
| Safety | 5 | 15 |
| Architecture | 10 | 20 |
| Troubleshooting | 10 | 20 |

**Total ideal:** <150 lines
**Total max:** <300 lines

## Decision Flowchart

```
Should I include section X?
│
├─ Is it essential? (Dev Setup, Testing)
│  └─ YES → Always include
│
├─ Is it relevant to all tasks?
│  ├─ YES → Include in AGENTS.md
│  └─ NO → Move to references/
│
├─ Is it short? (<20 lines)
│  ├─ YES → Include in AGENTS.md
│  └─ NO → Move to references/
│
└─ Does agent need it immediately?
   ├─ YES → Include in AGENTS.md
   └─ NO → Move to references/
```

## Examples by Project Type

### API Service

Essential: Title, Dev Setup, Code Style, Testing, Build
Recommended: CI/CD, PR Guidelines, Safety
Optional: Architecture, API Docs, Troubleshooting

### Frontend App

Essential: Title, Dev Setup, Code Style, Testing
Recommended: Build, CI/CD, PR Guidelines
Optional: Architecture, Performance, Troubleshooting

### CLI Tool

Essential: Title, Dev Setup, Code Style, Testing, Build
Recommended: CI/CD
Optional: Architecture, Troubleshooting

### Library

Essential: Title, Dev Setup, Code Style, Testing, Build
Recommended: CI/CD, PR Guidelines
Optional: API Docs, Architecture
