---
name: Post generation
description: When a conversation ends, generate a post representing the user's views.
targets:
  - ../../backend/**
  - ../../frontend/**
---

# Post generation

## Requirements

- Once a conversation is done, generate a **post** summarizing the user's opinions.
- Users can generate a post **without** an account.
- Users must **create an account** to save/publish their generated post into the zine.

## Validation strategy

- **Manual**: complete a chat and verify a post is generated and reflects the user's stated opinions.
- **Automated (future)**: contract tests for structured post output; snapshot tests for deterministic summary behavior using fixtures/mocks.


