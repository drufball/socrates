# Socrates

Socrates is an **interactive discussion board** for product-minded tech workers (especially in AI) who want a more **active content-consumption** experience.

## Motivation

People want to spend their free time doing active, enriching things but they're exhausted by **decisions** from the day. They turn to autopilot scrolling when they actually *do* have the energy to engage more actively.

Socrates gives the no-decision, "on rails" ease of passive reading while turning the experience into a **low-friction, high-engagement** thinking loop.

Instead of passively reading a blog/newsletter, you drop into a guided conversation with an LLM-powered discussion partner. When you're done, Socrates produces a durable artifact: a post that represents **your** views—added to the zine for others to read.

## Documentation

**IMPORTANT:** All feature & technical documentation is managed by Tessl and should be accessed by querying the Tessl MCP.

## Product vocabulary

- **Product Market Fit**: The name of the zine. `fit()` is stylised like the ML training method.
- **Issue**: one release centered on a topic (labeled in-product as **No. X**).
- **Post**: the final artifact generated from a user's conversation, representing the **user's** views for that issue.

## Implementation plan

Thin vertical slices that integrate early and often (frontend ↔ backend ↔ DB ↔ AI), optimized for getting an end-to-end system running quickly:

1. [X] **Scaffold + “it runs”**
   - Minimal Next.js app (`frontend/`) and FastAPI app (`backend/`)
   - Single “health” path: Web calls API, API returns JSON
   - Setup shadcn design system
   - Establish code quality baseline (interview user + configure):
     - linting
     - formatting
     - unit tests (and how they run in CI/local)

2. [ ] **Issue read path (no auth)**
   - Create a new Issue in Web UI
   - Web can load and display list of issues

3. [ ] **Chat session (no AI yet)**
   - Home page is a new chat session, with a drop-down to select which issue (default is latest)
   - Once conversation starts, issue is locked
   - Store `messages` rows (user + assistant roles) and render a basic transcript
   - User can send a freeform text message and always gets an echo back as assistant response.

4. [ ] **Agent integration (smallest useful loop)**
   - Wire PydanticAI to produce the assistant messages
   - Keep prompts/outputs simple; focus on functionality

5. [ ] **Post generation**
   - End a conversation and generate a Post (`content_markdown`)
   - Display generated post to the user immediately

6. [ ] **Publish/save with accounts**
   - Add account creation + login
   - Chats & posts are auto-tagged with account if logged in
   - Require login to publish/save

7. [ ] **Issue reading**
   - Publish multiple posts to an Issue
   - Issue page lists posts (basic ordering/pagination later)
   - Click a post to view it
