---
name: Admin
description: Admin-only capabilities for creating and configuring Issues.
targets:
  - ../../backend/**
  - ../../frontend/**
---

# Admin

## Requirements

- An admin can **create a new Issue**.
- An admin can customize Issue **seed info** / "editorial stance" that becomes the discussion agent's starting context.

## Validation strategy

- **Manual**: create an Issue and verify new chat sessions use the Issue's configured seed context.
- **Automated (future)**: API tests for Issue create/update; authorization tests for admin-only access.


