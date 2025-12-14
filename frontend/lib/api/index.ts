import { Api } from "./generated/api";

// In client components, only NEXT_PUBLIC_* env vars are available.
// Set NEXT_PUBLIC_BACKEND_ORIGIN (e.g. http://127.0.0.1:8000) for local dev.
export const api = new Api({
  baseURL: process.env.NEXT_PUBLIC_BACKEND_ORIGIN,
});

export type { HealthResponse } from "./generated/api";
