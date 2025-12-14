# Tech stack (WIP)

Language-specific conventions belong in:

- `tiles/typescript/styleguide.md`
- `tiles/python/styleguide.md`

## Frontend

- **Next.js** (TypeScript)
- **Generated API client**: `swagger-typescript-api` (axios-based), generated into `frontend/lib/api/generated/api.ts`
- UI/UX is TBD; we'll choose libraries once interaction patterns stabilize (chat UX, sliders, multi-choice, etc.).

## Backend

- **FastAPI** (Python)
- **OpenAPI as contract**: `backend/openapi.json` is generated from the FastAPI app and checked in for reviewable diffs.
- **PydanticAI** for:
  - prompt orchestration
  - structured outputs (e.g., post schema)
  - tool calling (as needed)

## Data

- Postgres hosted via Supabase
- [`Data & infrastructure notes`](tiles/architecture/data-infra.md)
- [`Data model`](tiles/architecture/data-model.md)

## AI / LLM provider

Provider + model selection is TBD.

- We should support swapping providers via config.
- We'll likely want an evaluation harness for conversation quality + summary fidelity.

## Local dev toolchain (current)

- **Python deps**: `uv` (lockfile: `backend/uv.lock`)
- **Node deps**: `npm` (lockfile: `frontend/package-lock.json`)


