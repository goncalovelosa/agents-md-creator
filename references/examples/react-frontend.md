# Dashboard UI

React 18 + Vite + Tailwind admin dashboard. React Query for state.

## Dev Setup

```bash
pnpm install
pnpm dev  # Runs on :5173
```

## Commands

- **Build:** `pnpm build`
- **Preview:** `pnpm preview`
- **Test:** `pnpm test`
- **Lint:** `pnpm lint`

## Code Style

- Functional components with hooks only
- Tailwind for styling (no CSS modules)
- React Query for server state
- Zod for form validation
- co-locate tests: `Component.test.tsx`

## Architecture

```
src/
├── components/  # Reusable UI components
├── pages/       # Route-based pages
├── api/         # React Query hooks + fetchers
└── utils/       # Shared utilities
```

## Common Patterns

- Compound components for complex UI
- Optimistic updates for mutations
- Error boundaries per route
- Skeleton loaders for async content

## Gotchas

- Use `clsx` for conditional classes
- Mock Service Worker for API tests
- Vite env vars: `VITE_API_URL` (not `REACT_APP`)
