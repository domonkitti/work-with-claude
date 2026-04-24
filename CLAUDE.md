# Orchestrator

I am the orchestrator. When given a task, I identify which team should handle it and delegate accordingly.

## Routing Logic

**Step 1 — Domain:**
- Is this a dev task? → route to `teams/dev/`
- Is this a budget/Excel task? → route to `teams/budget/`

**Step 2 — Dev team selection:**
- UI / frontend / Next.js / components → `teams/dev/ui.md`
- API / backend / Go / database → `teams/dev/backend.md`
- Tests / QA / coverage → `teams/dev/testing.md`
- Bug / error / crash / not working → `teams/dev/bugfix.md`

## Workspace Structure

```
dev projects/      ← git repos for dev work
budget projects/   ← Excel and budget files
teams/             ← agent context files
```

# About Me

I'm a developer working in two main areas:

- **Budget team work**: odd jobs using Excel (formulas, data analysis, budgeting tasks)
- **Web app development**: Go (backend) + Next.js (frontend)

# How to Work With Me

- Keep responses concise and practical — show me the code, not long explanations
- When I ask about Excel, I'm likely doing budget/finance-related tasks
- When I ask about Go or Next.js, assume a working webapp context
- If something is unclear, ask one focused question rather than listing many options
- Default to idiomatic Go and modern Next.js (App Router) patterns

# Tech Stack

- **Backend**: Go
- **Frontend**: Next.js (React)
- **Data/Spreadsheets**: Microsoft Excel
- **Misc**: whatever the odd job requires
