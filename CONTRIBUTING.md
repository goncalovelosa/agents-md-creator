# Contributing to AGENTS.md Creator

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing.

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce**
- **Expected behavior**
- **Actual behavior**
- **Environment details** (OS, Python version, etc.)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please include:

- **Clear title and description**
- **Use case** - why is this needed?
- **Proposed solution** - how should it work?
- **Alternatives considered**

### Pull Requests

1. Fork the repo
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test thoroughly
5. Commit with clear messages (`git commit -m 'Add amazing feature'`)
6. Push to your branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

## Development Setup

```bash
# Clone your fork
git clone https://github.com/your-username/agents-md-creator.git
cd agents-md-creator

# Run tests
python3 scripts/validate-agents-md.sh test

# Test gather-context
./scripts/gather-context.sh /path/to/test/project
```

## Style Guidelines

### Bash Scripts
- Use `set -euo pipefail`
- Follow [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- Comment complex logic

### Python Scripts
- Follow PEP 8
- Use type hints
- Document functions with docstrings

### Markdown
- Use proper heading hierarchy
- Keep lines under 120 characters
- Use fenced code blocks with language tags

## Questions?

Feel free to open an issue with the "question" label.
