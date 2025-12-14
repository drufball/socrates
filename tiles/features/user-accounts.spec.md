---
name: User accounts
description: Account creation and login for users who want to publish/save posts.
targets:
  - ../../frontend/**
  - ../../backend/**
---

# User accounts

## Requirements

- A user can **create an account**.
- A user can **log in**.
- A logged-in user's session persists according to our chosen auth approach (details TBD).

See also:

- Chat privacy + no “revisit chats” UX: [`chat.spec.md`](./chat.spec.md)
- Publishing requirement (account required to save/publish generated posts): [`post-generation.spec.md`](./post-generation.spec.md)

## Validation strategy

- **Manual**:
  - User can create an account and log in successfully.
  - Logged-in state is reflected in the UI (e.g., user menu / logout).
  - Session persists across refresh (within expected limits).


