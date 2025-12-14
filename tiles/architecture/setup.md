# Setup

This repo is a monorepo with:

- `frontend/` — Next.js app
- `backend/` — FastAPI app

## Prerequisites

- **Node.js**: `22.19.0` (see `frontend/.node-version`)
- **Python**: `3.13.1` (see `backend/.python-version`)
- **Python deps**: `uv` (we commit `backend/uv.lock`)
- **Node deps**: `npm` (we commit `frontend/package-lock.json`)

## Recommended: one-command dev with Tilt

If you want a single command that:

- installs deps when lockfiles change
- regenerates `backend/openapi.json` when the backend API changes
- regenerates `frontend/lib/api/generated/api.ts` when OpenAPI changes
- runs both dev servers

…use Tilt.

1. Install Tilt (see [Tilt install docs](https://tilt.dev/)).
2. From repo root:

```bash
tilt up
```

Notes:

- The Tilt config lives in `Tiltfile` at the repo root.
- **Reload behavior**: Next.js HMR and `uvicorn --reload` handle code reloads; Tilt primarily ensures the generated artifacts stay up to date.
- You may still want `frontend/.env.local` with `NEXT_PUBLIC_BACKEND_ORIGIN=http://127.0.0.1:8000` for local dev.

## Local development

### Backend (FastAPI)

Install deps (from `backend/`):

```bash
uv sync --dev
```

Run the dev server (from `backend/`):

```bash
uv run uvicorn app.main:app --reload --host 127.0.0.1 --port 8000
```

Sanity checks:

- API: `GET http://127.0.0.1:8000/health`
- Docs: `http://127.0.0.1:8000/docs`

### Frontend (Next.js)

Install deps (from `frontend/`):

```bash
npm ci
```

Set the backend origin (client-side env var):

- **Local dev**: set `NEXT_PUBLIC_BACKEND_ORIGIN=http://127.0.0.1:8000`
- **Recommended**: create `frontend/.env.local` with that value

Run the dev server (from `frontend/`):

```bash
npm run dev
```

Sanity check: `http://127.0.0.1:3000`

### Running both

Run the backend and frontend in two terminals:

- `backend/`: `uv run uvicorn app.main:app --reload --port 8000`
- `frontend/`: `npm run dev` (port `3000`)

The backend currently enables CORS for `http://localhost:3000` and `http://127.0.0.1:3000`.

## Opinionated workflows / “why”

### Python dependencies: prefer `uv` commands over hand-editing `pyproject.toml`

We commit `uv.lock`, so dependency edits should keep `pyproject.toml` and `uv.lock` in sync.

- **Add a runtime dep** (from `backend/`): `uv add <package>`
- **Add a dev dep** (from `backend/`): `uv add --dev <package>`
- **Sync your env to the lockfile**: `uv sync --dev`
- **Run tools inside the managed env**: `uv run <cmd>` (e.g. `uv run pytest`)

If you do edit `pyproject.toml` manually, follow up by regenerating/syncing so `uv.lock` is correct.

### OpenAPI export + client generation (kept in-repo and deterministic)

We check in `backend/openapi.json` (generated from the FastAPI app). This is deliberate:

- **reviewable diffs** when API changes
- **no running server required** to regenerate the frontend client

Update OpenAPI (from `backend/`):

```bash
uv run python scripts/export_openapi.py
```

Regenerate the frontend client (from `frontend/`):

```bash
npx swagger-typescript-api generate -p ../backend/openapi.json -o ./lib/api/generated -n api.ts --axios --unwrap-response-data
```

Notes:

- `frontend/lib/api/generated/api.ts` is **generated**; don't hand-edit it.
- We keep a small wrapper in `frontend/lib/api/index.ts` to configure `baseURL` and re-export types.

## Useful commands

### Backend

- **Tests**: `uv run pytest`
- **Lint**: `uv run ruff check .`
- **Format**: `uv run ruff format .`

### Frontend

- **Lint**: `npm run lint`

