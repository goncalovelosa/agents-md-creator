# Example API

Node.js/TypeScript REST API with PostgreSQL and Redis.

## Dev Setup

```bash
pnpm install
docker compose up -d  # Starts PostgreSQL + Redis
pnpm dev              # Runs on :3000
```

## Commands

- **Build:** `pnpm build`
- **Test:** `pnpm test`
- **Lint:** `pnpm lint`
- **Migrate:** `pnpm db:migrate`

## Code Style

- TypeScript strict mode enabled
- Domain-Driven Design structure (`src/domains/`)
- Single quotes, no semicolons (Prettier config)
- Prefer functional patterns over classes
- Zod for all runtime validation

## Testing

- Jest with TypeScript
- Integration tests use testcontainers
- Run before every commit
- Minimum 80% coverage for new code

## Architecture

```
src/
├── domains/        # Business logic
├── infrastructure/ # DB, Redis, external APIs
└── api/            # Express routes and middleware
```

## Common Patterns

- Repository pattern for data access
- Event-driven for cross-domain communication
- Circuit breaker for external APIs

## Gotchas

- Redis required for sessions
- Migrations auto-run on startup in dev
- Use `pnpm` not `npm` (lockfile mismatch)
