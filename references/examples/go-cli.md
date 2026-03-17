# Taskmaster CLI

Go CLI tool for task management. SQLite storage, Cobra framework.

## Dev Setup

```bash
go mod download
go run ./cmd/taskmaster  # Runs CLI
```

## Commands

- **Build:** `go build -o taskmaster ./cmd/taskmaster`
- **Test:** `go test ./...`
- **Lint:** `golangci-lint run`
- **Install:** `go install ./cmd/taskmaster`

## Code Style

- Effective Go guidelines
- golangci-lint with default config
- Error messages lowercase, no trailing punctuation
- Prefer `struct{}` for empty interfaces

## Architecture

```
cmd/
  taskmaster/   # CLI entrypoint
internal/
  commands/     # Cobra command definitions
  storage/      # SQLite repository
  task/         # Domain logic
```

## Common Patterns

- Repository interface for storage
- Cobra for CLI structure
- Viper for config
- table-driven tests

## Gotchas

- SQLite file: `~/.taskmaster.db`
- Use `fmt.Errorf` for error wrapping
- Context timeout: 5s for all operations
