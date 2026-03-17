# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x     | :white_check_mark: |

## Reporting a Vulnerability

If you discover a security vulnerability, please report it via:

- **Email:** security@example.com (replace with actual email)
- **GitHub:** Use the private vulnerability reporting feature

### What to Include

Please include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

### Response Timeline

- **Initial response:** Within 48 hours
- **Triage:** Within 7 days
- **Fix timeline:** Depends on severity

## Security Best Practices

When using this skill:

1. **No secrets in AGENTS.md** - Never commit API keys, tokens, or passwords
2. **Review generated content** - Always review before committing
3. **Validate inputs** - The skill validates inputs, but double-check sensitive projects
4. **Report issues** - If you find security issues in the skill itself, report immediately

## Known Security Considerations

- This skill reads project files to gather context
- It does not modify files without explicit instruction
- Generated AGENTS.md files should be reviewed before committing to public repos

## Contact

For security concerns, contact the maintainer via GitHub issues or email.
