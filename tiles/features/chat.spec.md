---
name: Chat
description: Users can have a guided conversation with the agent about a given Issue.
targets:
  - ../../frontend/**
  - ../../backend/**
---

# Chat

## Requirements

- A user can start a **chat** about a given Issue.
- The chat is grounded in the Issue's configured **seed info** / "editorial stance".
- The chat experience can display **response components** ([see response components spec](./response-components.spec.md)) as part of the conversation UI.
- Chats do **not** require login.
- **Chats are private & anonymous by default.**
- v1 does not include "revisit my old chats" UX (even if we retain them server-side).

### Agent tone

The agent is **friendly, academic, and proactive**:

- Starts with Socratic questioning to draw ideas out
- Switches into "yes, and…" to develop emerging thoughts
- Flips back to stress-testing and refining

## Notes

- Where chat is surfaced (e.g., "instant entrypoint" on the landing page) is a UX decision and is intentionally out of scope for this spec.

## Validation strategy

- **Manual**: start chats on two different Issues and confirm the agent behavior reflects the selected Issue's stance/context.
- **Manual**: evaluate chat transcripts across multiple Issues to confirm the agent consistently:
  - avoids blank-page moments (always offers a next step)
  - alternates between elicitation → development → stress-test as appropriate
- **Automated (future)**: API tests for creating chat sessions scoped to an Issue; UI tests for starting a chat from an Issue context.


