# About Me

Developer working in two areas:
- **Web app**: Go (backend) + Next.js (App Router) frontend
- **Budget/Excel**: odd jobs using Excel (formulas, data analysis, finance tasks)

# How to Work With Me

- Concise and practical — show code, not explanations
- If unclear, ask one focused question
- Default to idiomatic Go and modern Next.js (App Router) patterns

# Tech Stack

- **Backend**: Go — standard library first, minimal deps, thin handlers, logic in services
- **Frontend**: Next.js (React) — App Router, Server Components by default, small focused components
- **Tests**: Go uses `testing` + `testify`; Next.js uses Jest / React Testing Library. Test behavior not implementation. No mocking unless necessary.
- **Data**: Microsoft Excel (Python with `openpyxl` and `pandas` available for file manipulation)

# Excel Workflow

For file manipulation tasks:
1. User closes Excel first (file lock)
2. User describes what to do + gives file path
3. Write and run a Python script
4. User reopens Excel — done

For advice-only (formulas, how-to): no file needed, user describes the problem.

# UI Review Checklist

When reviewing UI, check for: overflow/overlap, missing scroll on long lists/tables, empty states, alignment, responsiveness, sticky headers on long tables, loading/error states.

# Knowledge Management

After completing any task, check if anything is worth saving to memory:
- New tool or library installed
- New workflow or convention discovered
- Something that would surprise the next session

If memory is updated, commit and push so both PCs stay in sync.

# Workspace Structure

```
dev-projects/
  budget-app/       ← Next.js frontend (see dev-projects/budget-app/CLAUDE.md for full map)
  budget-app-api/   ← Go backend     (see dev-projects/budget-app-api/CLAUDE.md for full map)
budget-projects/    ← Excel and budget files
```
