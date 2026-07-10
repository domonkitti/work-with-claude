# Budget App — Pending Work

## Context
Project I2568Y001 had 37 duplicate rows for หมวดค่าจ้าง ผูกพัน 2569 in sub_jobs (no UNIQUE constraint).
This caused: overall page (SUM) ≠ edit page (last row wins).

## Done
- [x] `projects.go` Get handler: aggregate sub_jobs + budget_sources with SUM/MIN(id) grouped by (name, fund_type, data_year)
- [x] `projects.go` BatchSave: after each UPDATE, DELETE duplicate rows with same (project_id, name, fund_type, data_year)
- [x] `changelog.go`: added undo cases for budget_sources cut_transfer + under_budget
- [x] `scenarios.go` Promote: aggregate with SUM subquery before joining (handles pre-existing duplicates)
- [x] `scenarios.go` Create: aggregate sub_jobs + budget_sources with SUM when copying into scenario tables
- [x] `scenarios.go` GetProject: aggregate scenario_sub_jobs + scenario_budget_sources with SUM/MIN(id)
- [x] `scenarios.go` UpdateSubJob: dedup after UPDATE (wrapped in tx)
- [x] `scenarios.go` UpdateBudgetSource: dedup after UPDATE (wrapped in tx)
- [x] Migration 010_bs_cut_transfer.sql: adds cut_transfer + under_budget to budget_sources + scenario_budget_sources

## Still TODO

### 1. Run migration 010 against DB
```bash
docker compose exec -T db psql -U budget -d budget_db -f /migrations/010_bs_cut_transfer.sql
```
OR copy-paste the SQL manually:
```sql
ALTER TABLE budget_sources
    ADD COLUMN IF NOT EXISTS cut_transfer NUMERIC(15,3) NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS under_budget NUMERIC(15,3) NOT NULL DEFAULT 0;
ALTER TABLE scenario_budget_sources
    ADD COLUMN IF NOT EXISTS cut_transfer NUMERIC(15,3) NOT NULL DEFAULT 0,
    ADD COLUMN IF NOT EXISTS under_budget NUMERIC(15,3) NOT NULL DEFAULT 0;
```

### 2. Rebuild and restart API
```bash
docker compose up --build -d
```

### 3. Verify UI — budget source ct/ub cells
Open a project in edit mode and confirm budget sources show editable ตัดทิ้ง/โยกย้าย + ต่ำกว่างบ cells.
(Already verified in code: no `isSj &&` gate, bsYearTotal includes ct/ub.)

## DB Info
- Container: budget-app-api-db-1
- Port: 5433 (host) -> 5432 (container)
- User: budget, DB: budget_db
- Connect: docker compose exec -T db psql -U budget -d budget_db
