"use client";

import { useEffect, useState } from "react";

import { api, type HealthResponse } from "@/lib/api";

export default function Home() {
  const [data, setData] = useState<HealthResponse | null>(null);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    let cancelled = false;

    async function run() {
      try {
        setError(null);
        const health = await api.health.getHealth();
        if (!cancelled) setData(health ?? null);
      } catch (e) {
        if (!cancelled) setError(e instanceof Error ? e.message : String(e));
      }
    }

    void run();
    return () => {
      cancelled = true;
    };
  }, []);

  return (
    <main className="mx-auto flex min-h-screen max-w-2xl flex-col gap-6 px-6 py-16">
      <h1 className="text-2xl font-semibold tracking-tight">Socrates</h1>
      <p className="text-sm text-muted-foreground">
        Hello world slice: frontend calls backend health endpoint.
      </p>

      {error ? (
        <div className="rounded-md border border-destructive/50 bg-destructive/10 p-4 text-sm text-destructive">
          {error}
        </div>
      ) : data ? (
        <pre className="rounded-md border bg-muted p-4 text-sm">
          {JSON.stringify(data, null, 2)}
        </pre>
      ) : (
        <div className="text-sm text-muted-foreground">Loading…</div>
      )}
    </main>
  );
}
