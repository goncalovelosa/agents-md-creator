# [MONOREPO_NAME]

## Overview
[Description of monorepo purpose and contained packages]

## Dev Setup

### Prerequisites
- [Tool 1] >= [version]
- [Tool 2] >= [version]

### Installation
```bash
[package-manager] install
```

### Development
```bash
[package-manager] dev              # All packages
[package-manager] dev --filter [package]  # Specific package
```

### Build
```bash
[package-manager] build            # All packages
[package-manager] build --filter [package]  # Specific package
```

### Test
```bash
[package-manager] test             # All packages
[package-manager] test --filter [package]  # Specific package
```

## Monorepo Structure

```
[monorepo]/
├── packages/
│   ├── [package-a]/    # [Description]
│   ├── [package-b]/    # [Description]
│   └── [package-c]/    # [Description]
├── shared/
│   ├── [shared-1]/     # [Description]
│   └── [shared-2]/     # [Description]
├── docs/               # Documentation
└── scripts/            # Utility scripts
```

## Package Navigation

Each package has its own AGENTS.md with specific instructions:

- **[package-a]**: `packages/[package-a]/AGENTS.md` - [Brief description]
- **[package-b]**: `packages/[package-b]/AGENTS.md` - [Brief description]
- **[package-c]**: `packages/[package-c]/AGENTS.md` - [Brief description]

## Shared Conventions

### Code Style
- [Universal rule 1]
- [Universal rule 2]
- See package AGENTS.md for specifics

### Testing
- [Universal test rule]
- Each package manages its own tests

### Dependencies
- Shared dependencies in root [lockfile]
- Package-specific in package [package.json/cargo.toml/etc]

## CI/CD

### Pipeline
- Runs on: [trigger]
- Parallel per package
- Required: All packages pass

### Local Checks
```bash
[package-manager] lint
[package-manager] test
[package-manager] build
```

## Working with Packages

### Create New Package
```bash
[package-manager] generate package [name]
```

### Add Dependency
```bash
[package-manager] add [dep] --filter [package]
```

### Run Package Script
```bash
[package-manager] [script] --filter [package]
```

## Cross-Package Changes

When changing shared code:

1. Check dependents: `[package-manager] list --filter "...[package]"`
2. Update tests in affected packages
3. Run full test suite: `[package-manager] test`
4. Document breaking changes in PR

## Resources

- [Monorepo tool docs]
- [Package manager docs]
- [Internal wiki]
