---
name: Response components
description: Structured input components that reduce decision fatigue during chat.
targets:
  - ../../frontend/**
  - ../../backend/**
---

# Response components

## Requirements

During chat, the agent can elicit responses via:

- multiple-choice
- sliders (agreement/confidence)
- freeform input

## Validation strategy

- **Manual**: during a chat, confirm the UI supports all three input modes and the agent can drive the user through them.
- **Automated (future)**: UI tests for rendering and submitting each input type; API contract tests for message payload shapes.


