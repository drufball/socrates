# Socrates dev orchestrator
#
# Run: tilt up
#
# Tilt will:
# - install backend/frontend deps when lockfiles change
# - regenerate backend/openapi.json when backend API code changes
# - regenerate frontend/lib/api/generated/api.ts when OpenAPI changes
# - run both dev servers (uvicorn + next)

# If you want to keep using manual commands, see tiles/architecture/setup.md

BACKEND_DIR = "backend"
FRONTEND_DIR = "frontend"

# --- Backend deps (uv) ---
local_resource(
    "backend_deps",
    dir=BACKEND_DIR,
    cmd="uv sync --dev",
    deps=[
        "backend/pyproject.toml",
        "backend/uv.lock",
    ],
)

# --- OpenAPI export (generated contract) ---
local_resource(
    "openapi",
    dir=BACKEND_DIR,
    cmd="uv run python scripts/export_openapi.py",
    deps=[
        # Regenerate the contract when API code changes.
        "backend/app",
        "backend/scripts/export_openapi.py",
    ],
    resource_deps=["backend_deps"],
)

# --- Frontend deps (npm) ---
local_resource(
    "frontend_deps",
    dir=FRONTEND_DIR,
    cmd="npm ci",
    deps=[
        "frontend/package.json",
        "frontend/package-lock.json",
    ],
)

# --- Generated TS client (from OpenAPI) ---
local_resource(
    "client",
    dir=FRONTEND_DIR,
    cmd="npx swagger-typescript-api generate -p ../backend/openapi.json -o ./lib/api/generated -n api.ts --axios --unwrap-response-data",
    deps=[
        "backend/openapi.json",
    ],
    resource_deps=["frontend_deps", "openapi"],
)

# --- Backend server ---
# NOTE: uvicorn's --reload handles code changes. We keep Tilt deps minimal so it
# doesn't restart the server on every edit.
local_resource(
    "backend",
    serve_cmd="uv run uvicorn app.main:app --reload --host 127.0.0.1 --port 8000",
    serve_dir=BACKEND_DIR,
    deps=[
        "backend/pyproject.toml",
        "backend/uv.lock",
    ],
    resource_deps=["backend_deps", "openapi"],
)

# --- Frontend server ---
# NOTE: Next.js HMR handles code changes. We keep Tilt deps minimal so it doesn't
# restart the dev server on every edit.
local_resource(
    "frontend",
    serve_cmd="npm run dev",
    serve_dir=FRONTEND_DIR,
    deps=[
        "frontend/package.json",
        "frontend/package-lock.json",
    ],
    resource_deps=["frontend_deps", "client"],
)
