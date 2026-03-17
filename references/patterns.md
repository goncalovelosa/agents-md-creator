# Common Patterns

This document provides reusable patterns for common development workflows. Copy and adapt these for your AGENTS.md file.

## Feature Development

**Pattern:**
```markdown
## Workflow
1. Create feature branch: `git checkout -b feat/description`
2. Make changes + add tests
3. Run: `pnpm test && pnpm lint`
4. Submit PR with description
```

**When to use:**
- Active feature development
- Teams using feature branches
- Projects with CI/CD requirements

**Customization:**
- Replace `pnpm` with your package manager
- Add specific branch naming conventions
- Include required PR checks

## Bug Fixes

**Pattern:**
```markdown
## Bug Fix Process
1. Reproduce issue locally
2. Add failing test
3. Fix implementation
4. Verify test passes
5. Check for regressions
```

**When to use:**
- Bug fix workflows
- Test-driven development
- Quality-focused teams

**Customization:**
- Add specific debugging tools
- Include logging requirements
- Specify test coverage expectations

## Refactoring

**Pattern:**
```markdown
## Refactoring Rules
- One refactor per PR
- No behavior changes
- Update tests if needed
- Document in PR description
```

**When to use:**
- Code improvement initiatives
- Technical debt reduction
- Architecture updates

**Customization:**
- Add specific refactoring guidelines
- Include performance benchmarks
- Specify documentation requirements

## Documentation Updates

**Pattern:**
```markdown
## Documentation
- Update README.md for user-facing changes
- Update API docs for endpoint changes
- Add inline comments for complex logic
- Keep examples up to date
```

**When to use:**
- Documentation-heavy projects
- API development
- Open source projects

## Testing Strategy

**Pattern:**
```markdown
## Testing Strategy
- Unit tests for utilities
- Integration tests for APIs
- E2E tests for critical paths
- Minimum 80% coverage
```

**When to use:**
- Projects with testing requirements
- Teams practicing TDD
- Quality-focused development

## Git Workflow

**Pattern:**
```markdown
## Git Workflow
- Main branch: `main`
- Feature branches: `feat/description`
- Bug fix branches: `fix/description`
- Squash merge to main
- Delete branch after merge
```

**When to use:**
- Team projects
- Structured git workflows
- CI/CD pipelines

## Code Review

**Pattern:**
```markdown
## Code Review
- Self-review before PR
- Request review from domain expert
- Address all comments
- Keep PRs <400 lines
```

**When to use:**
- Team collaboration
- Quality assurance
- Knowledge sharing

## Combining Patterns

You can combine multiple patterns in your AGENTS.md:

```markdown
## Workflow
1. Create feature branch: `git checkout -b feat/description`
2. Make changes + add tests
3. Run: `pnpm test && pnpm lint`
4. Submit PR with description

## Testing Strategy
- Unit tests for utilities
- Integration tests for APIs
- Minimum 80% coverage

## Code Review
- Self-review before PR
- Request review from domain expert
- Address all comments
```

This provides a comprehensive workflow while keeping the file concise.
