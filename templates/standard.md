# [PROJECT_NAME]

## Overview
[Brief description of what this project does and why it exists]

## Dev Setup

### Installation
```bash
[package-manager] install
```

### Development
```bash
[package-manager] dev
```

### Build
```bash
[package-manager] build
```

### Test
```bash
[package-manager] test
[package-manager] test:coverage  # With coverage
```

## Code Style

### Formatting
- [Formatter]: [config file]
- [Key rule 1]
- [Key rule 2]

### Patterns
- [Preferred pattern 1]
- [Preferred pattern 2]
- [Avoid: anti-pattern]

### Naming
- [Files]: [convention]
- [Variables]: [convention]
- [Functions]: [convention]

## Testing

### Running Tests
```bash
[package-manager] test              # All tests
[package-manager] test:watch        # Watch mode
[package-manager] test:coverage     # Coverage report
```

### Test Patterns
- [Test framework] + [assertion library]
- [Pattern for unit tests]
- [Pattern for integration tests]

### Coverage
- Target: [X]%
- Run coverage before PRs

## CI/CD

### Pipeline
- Runs on: [trigger]
- Steps: lint → test → build
- Required checks: [list]

### Local Checks
```bash
[package-manager] lint
[package-manager] test
[package-manager] build
```

## PR Guidelines

### Title Format
`[type]: [description]`

Types: feat, fix, docs, style, refactor, test, chore

### Requirements
- [ ] Tests pass
- [ ] Coverage maintained
- [ ] Lint clean
- [ ] Description clear

### Review Process
1. Create feature branch
2. Make changes + tests
3. Run local checks
4. Submit PR
5. Address review feedback

## Project Structure

```
[root]/
├── [src]/           # Source code
├── [tests]/         # Test files
├── [docs]/          # Documentation
├── [config]/        # Configuration
└── [scripts]/       # Utility scripts
```

## Safety

### Requires Approval
- [Action 1]
- [Action 2]

### Never Do
- [Destructive action 1]
- [Dangerous action 2]

## Troubleshooting

### Common Issues

**[Issue 1]**
- Cause: [reason]
- Fix: [solution]

**[Issue 2]**
- Cause: [reason]
- Fix: [solution]

## Resources

- [Documentation link]
- [API reference]
- [Related resource]
