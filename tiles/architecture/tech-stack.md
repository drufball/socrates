# Tech stack (WIP)

Language-specific conventions belong in:

- `tiles/typescript/styleguide.md`
- `tiles/python/styleguide.md`

## Frontend

- **Next.js** (TypeScript)
- UI/UX is TBD; we'll choose libraries once interaction patterns stabilize (chat UX, sliders, multi-choice, etc.).

## Backend

- **FastAPI** (Python)
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


