# Data model (WIP)

This tile defines the **core domain objects** and how they relate.

## Core domain objects

Lightweight table schemas (names + columns).

### `issues`

- `id`: `uuid`
- `issue_number`: `int` (display label: “No. X”)
- `title`: `text`
- `seed_context`: `text` (Issue stance / seed prompt context)
- `created_at`: `timestamptz`

### `conversations`

- `id`: `uuid`
- `issue_id`: `uuid` (FK → `issues.id`)
- `user_id`: `uuid | null` (FK → `users.id`, nullable for anonymous chat)
- `created_at`: `timestamptz`

### `messages`

- `id`: `uuid`
- `conversation_id`: `uuid` (FK → `conversations.id`)
- `role`: `text` (one of: `user`, `assistant`)
- `type`: `text` (message/render type; used to display response components)
- `content`: `text`
- `created_at`: `timestamptz`

### `posts`

- `id`: `uuid`
- `issue_id`: `uuid` (FK → `issues.id`)
- `conversation_id`: `uuid` (FK → `conversations.id`)
- `author_user_id`: `uuid | null` (FK → `users.id`; null for anonymous chats)
- `title`: `text`
- `content_markdown`: `text`
- `created_at`: `timestamptz`
- `published_at`: `timestamptz | null` (can only be published if there is an author)

### `users`

- `id`: `uuid`
- `handle`: `text` (optional)
- `created_at`: `timestamptz`
