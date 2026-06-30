# Jgive Campaign Donation Page

A Rails application reproducing the [Jgive campaign donation page](https://www.jgive.com/new/he/ils/donation-targets/159183) — the donor-facing experience up to (but not including) payment.

Built with Rails 8.1, SQLite, and ERB views.

**Live demo:** [https://jgive-assignment-1.onrender.com/campaigns/1](https://jgive-assignment-1.onrender.com/campaigns/1)

**Source code:** [https://github.com/sara-roei/jgive-assignment](https://github.com/sara-roei/jgive-assignment)

## Running Locally

Prerequisites: Ruby 3.2.2, Bundler, SQLite3.

```bash
git clone https://github.com/sara-roei/jgive-assignment.git
cd jgive-assignment
bundle install
bin/rails db:migrate:reset db:seed
bin/rails server
```

Visit [http://localhost:3000/campaigns/1](http://localhost:3000/campaigns/1).

## Key Decisions and Trade-offs

- **ERB views over React** — avoids a JS build pipeline and API layer within the time constraint. ERB + vanilla JS covers all interactivity needs for this scope.
- **SQLite over PostgreSQL** — zero setup, sufficient for a demo app. Trade-off: ephemeral storage on Render free tier, not suitable for real production.
- **Computed stats instead of counter caches** — `donations.sum(:amount)` and `donations.count` run per page load. Always correct, no invalidation logic. At scale, counter caches or materialized columns would be needed.
- **Tabs with placeholder content** — only the "Story" tab has real content. "Recent Donations" and "About" show placeholders. Deliberate scope cut.
- **No automated tests** — not in the assignment deliverables. With more time, would add model and controller tests.

## What I'd Do with More Time

- **Automated Testing:** Write Model specs for validations/business logic and Request/Controller specs to fully cover the donation submission flow.
- **Dynamic "Recent Donations" Tab (React Integration):** Implement backend API endpoints to replace the static placeholder text. In a production environment, I would build this specific dynamic tab (along with the real-time progress bar) as a React component, fetching live data asynchronously to ensure the donor list stays 100% accurate without reloading the page.
- **Dynamic Routing & Slugs:** Eliminate the hardcoded `/campaigns/1` approach. I would map the application root dynamically to the active campaign or implement human-readable slugs (e.g., `/campaigns/the-orange-garden`).
- **Database Consistency:** Transition from SQLite to PostgreSQL for proper concurrency support (row-level locking vs. file-level), production-grade reliability.
- **Form UX Polish:** Add precise inline error messages next to form inputs instead of top-of-form summaries, and implement a cleaner success feedback state (like a modal or toast) post-submission.

## Payment Provider Integration Plan

How I'd wire in a real payment provider and move a donation from `pending` to `paid`:

1. **Synchronous payment** — after form submission, the server calls the provider's API (e.g. Stripe PaymentIntents). The user waits in the browser. On success: update status to `paid`, show confirmation. On failure: show the error, let the user retry.

2. **Webhook safety net** — register a webhook endpoint with the provider. If the sync call succeeds but the server fails to persist the update (crash, timeout), the webhook catches it. Also prevents double-charging by checking if the donation is already `paid`.

3. **Async email** — on status change to `paid`, enqueue a background job (Active Job + Solid Queue) to send a confirmation email with invoice. Email delivery does not block the user's request.


## Setup, Methodology, and AI Thoughts

- **Tools:** Built using **Cursor** (v3.2.16) as the primary IDE with **Claude 3 Opus** providing context-aware completions and conversational assistance.
- **Development Process & AI Steering:** As a developer coming from a Node/React background, I initially brainstormed architectural choices with the AI (e.g., assessing the time overhead of setting up an API/React frontend vs. utilizing native Rails views). I proactively restricted the assistant from generating raw code until a solid, minimal implementation plan was established.
- **Where AI Helped:** 
Highly effective for fast scaffolding of core database models, 
generating realistic seed data, and building the UI views. 
It also helped me plan and break down the project into 
small, logical commits. I used it to follow a clean workflow: 
plan each step, implement, review the changes, and test 
the app before committing and pushing.
- **Where AI Got in the Way:** 
The AI repeatedly tried to over-engineer the solution. It proposed 
extra models for donation presets, adding cache columns, and complex 
Stimulus setups. I chose to reject these ideas to keep the solution 
clean, lightweight, and focused on standard Rails conventions to fit 
the 4-6 hour window.

Deployment was where the real challenge happened. I got caught in a long 
back-and-forth loop with the AI, letting it lead the troubleshooting. It kept 
suggesting failing Docker approaches (modifying entrypoints, CMD overrides, 
and build-time seeding). 
After a few rounds, I stopped the AI loop, and took back control. 
I used my own judgment and decided to simply delete the Dockerfile, letting 
Render auto-detect the Ruby environment and handle the build smoothly.

The full, unedited chat history can be viewed in the [`cursor_ruby_on_rails_home_assignment.md`](/cursor_ruby_on_rails_home_assignment.md) file in this repository.