# Styleguide (Python)

This doc captures repo-specific conventions beyond “normal Python”.

## Backend conventions (FastAPI)

### Always model responses for good OpenAPI (and good generated clients)

- **Define Pydantic models** (`BaseModel`) for request/response bodies.
- **Always set `response_model=...`** on routes so the OpenAPI schema is correct.
- **Prefer returning models** (or things Pydantic can serialize cleanly) rather than ad-hoc dicts.

This is not just “documentation”: our TypeScript client is generated from `backend/openapi.json`.

### Pin `operation_id` for stable client method names

Generated clients use `operationId` to name methods. To keep diffs stable and avoid awkward auto-generated names:

- **Set `operation_id="someStableName"` explicitly** on every route.
- **Keep it unique across the whole app**, not just within a router.
- **Use a consistent casing** (we currently use lowerCamelCase like `getHealth`).

Example (current pattern):

- `operation_id="getHealth"` → generated TS method `api.health.getHealth()`

### Use tags intentionally (they become API namespaces)

We set `tags=[...]` on routes so the generated client groups endpoints into namespaces.

- **Use a small, stable set of tags** (e.g. `health`, `issues`, `chat`, …).
- Prefer “domain” tags over “technical” tags so the generated API shape matches product concepts.

### Prefer `APIRouter` per domain module

As the backend grows, routes should live in domain routers:

- `app/routers/issues.py`, `app/routers/chat.py`, etc.
- Each router uses `APIRouter(prefix=..., tags=[...])`
- The root `app` includes routers via `app.include_router(router)`

This keeps URLs consistent and keeps OpenAPI tag grouping predictable.

### Make API diffs reviewable

When you change routes, update the checked-in OpenAPI file:

```bash
uv run python scripts/export_openapi.py
```
