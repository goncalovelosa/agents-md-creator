# [PACKAGE_NAME]

> Part of [MONOREPO_NAME] monorepo. See root AGENTS.md for shared conventions.

## Overview
[Brief description of this package's purpose]

## Dev Setup

### Installation
From monorepo root:
```bash
[package-manager] install
```

### Development
```bash
[package-manager] dev --filter [package-name]
```

### Build
```bash
[package-manager] build --filter [package-name]
```

### Test
```bash
[package-manager] test --filter [package-name]
```

## Package Structure

```
[package-name]/
├── src/
│   ├── [module-1]/     # [Description]
│   └── [module-2]/     # [Description]
├── tests/
│   ├── [test-1].test.[ext]
│   └── [test-2].test.[ext]
├── [config-files]
└── package.json (or equivalent)
```

## Code Style

### Package-Specific Rules
- [Rule specific to this package]
- [Pattern preference]
- Inherits shared conventions from root AGENTS.md

### Formatting
- [Formatter config if different from root]

## Testing

### Run Tests
```bash
[package-manager] test --filter [package-name]
[package-manager] test:watch --filter [package-name]
```

### Test Patterns
- [Pattern used in this package]
- [Coverage target]

## Dependencies

### Internal
- `@[scope]/[package-a]` - [Purpose]
- `@[scope]/[package-b]` - [Purpose]

### External
- `[dep-1]` - [Purpose]
- `[dep-2]` - [Purpose]

## API

### Public Exports
```[language]
// Example usage
import { [export] } from '@[scope]/[package-name]'
```

### Key Functions
- `[function-1]`: [Description]
- `[function-2]`: [Description]

## Integration

### Used By
- `[package-x]`
- `[package-y]`

### Breaking Changes
When changing public API:
1. Check dependents (see root AGENTS.md)
2. Update tests in dependent packages
3. Document in CHANGELOG

## Tasks

### Common Tasks

**[Task 1]**
```bash
[command]
```

**[Task 2]**
```bash
[command]
```

## Troubleshooting

### Package-Specific Issues

**[Issue]**
- Cause: [reason]
- Fix: [solution]

## Notes

- [Important note 1]
- [Important note 2]

---

See root AGENTS.md for:
- Shared code style
- CI/CD pipeline
- Cross-package workflows
