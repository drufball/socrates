---
name: Issue reading (view generated posts)
description: Users can view all generated posts for a given Issue.
targets:
  - ../../frontend/**
  - ../../backend/**
---

# Issue reading (view generated posts)

## Requirements

- Users can view all generated posts for a given Issue.

## Validation strategy

- **Manual**: publish multiple posts to an Issue and verify they appear in the Issue feed/list view.
- **Automated (future)**: API tests for pagination/ordering; UI tests for list rendering.


