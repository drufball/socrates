# Socrates Frontend

Next.js (App Router) frontend for the Socrates monorepo.

## Local development

Install deps:

```bash
npm install
```

Run the dev server:

```bash
NEXT_PUBLIC_BACKEND_ORIGIN=http://127.0.0.1:8000 npm run dev
```

Then open `http://localhost:3000`.

## Backend connectivity

The frontend talks to the backend via the generated API client in `lib/api/generated/api.ts`.

- **Config**: set `NEXT_PUBLIC_BACKEND_ORIGIN` to your backend origin (e.g. `http://127.0.0.1:8000`).

## API client regeneration

See `tiles/typescript/styleguide.md` for the canonical regeneration commands.
