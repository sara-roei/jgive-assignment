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
- **Preset amounts hardcoded in the view** — the assignment calls for "a few preset options"; a separate model would be over-engineering. In production, these would be configurable per campaign.
- **Vanilla JS instead of Stimulus** — tab switching and form interactions total ~20 lines. A framework isn't justified for this amount.
- **Tabs with placeholder content** — only the "Story" tab has real content. "Recent Donations" and "About" show placeholders. Deliberate scope cut.
- **No automated tests** — not in the assignment deliverables. With more time, would add model and controller tests.

## What I'd Do with More Time

- **Campaign index page** — a homepage listing all campaigns, instead of a redirect to `/campaigns/1`.
- **Fill in all tabs** — populate "Recent Donations" with actual data from the DB, and "About" with organization info.
- **Inline field validation** — highlight invalid fields next to the input instead of listing errors at the top of the form.
- **Better success feedback** — replace the flash notice with a styled confirmation (toast or modal).

## Payment Provider Integration Plan

How I'd wire in a real payment provider (e.g. Stripe) and move a donation from `pending` to `paid`:

1. **Synchronous payment** — after form submission, the server calls the provider's API (e.g. Stripe PaymentIntents). The user waits in the browser. On success: update status to `paid`, show confirmation. On failure: show the error, let the user retry.

2. **Webhook safety net** — register a webhook endpoint with the provider. If the sync call succeeds but the server fails to persist the update (crash, timeout), the webhook catches it. Also prevents double-charging by checking if the donation is already `paid`.

3. **Async email** — on status change to `paid`, enqueue a background job (Active Job + Solid Queue) to send a confirmation email with invoice. Email delivery does not block the user's request.


## Setup, Methodology, and AI Thoughts

- **Tools:** Built using **Cursor** (v3.2.16) as the primary IDE with **Claude 3 Opus** providing context-aware completions and conversational assistance.
- **Development Process & AI Steering:** As a developer coming from a Node/React background, I initially brainstormed architectural choices with the AI (e.g., assessing the time overhead of setting up an API/React frontend vs. utilizing native Rails views). I proactively restricted the assistant from generating raw code until a solid, minimal implementation plan was established.
- **Where AI Helped:** Highly effective for rapidly scaffolding the core database models, generating realistic initial seed data in Hebrew, and handling the core form parameters routing. 
- **Where AI Got in the Way:** The assistant repeatedly attempted to introduce premature optimizations and over-engineering — such as proposing extra models for donation presets, adding cache columns, or outputting heavy Stimulus setups. I deliberately steered it away from these, stripping the final solution down to clean, lightweight Rails conventions and standard vanilla JS inline behaviors to fit the strict 4-6 hour window. 
Deployment was another friction point... the AI struggled with Render's Docker execution model, cycling through several failed approaches (modifying entrypoints, CMD overrides, build-time seeding). The fix was simple: I removed the Dockerfile so Render auto-detected the app as Ruby and handled the build natively.

The full, unedited chat history can be viewed in the [`cursor_ruby_on_rails_home_assignment.md`](/cursor_ruby_on_rails_home_assignment.md) file in this repository.