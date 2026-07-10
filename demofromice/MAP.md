# demofromice — HTML Map
File: `remixed-690fa535.html` (~578KB, minified single-page app, lang="th")
Title: **ระบบงบลงทุน | ACBS** (Capital Budget System)

---

## Top-Level Views (toggled via `show*()` / `showPage()`)

| id | Description | Shown by |
|----|-------------|----------|
| `view-main` | Landing/home — "ถึงเวลาตั้งงบลงทุนประจำปีแล้ว!" | default (display:block) |
| `view-capex` | Full CAPEX app shell (contains page-list, page-form-*) | `showCapex()` |
| `view-review` | Reviewer shell (contains page-review-list) | `showReview()` |

---

## Pages inside view-capex

| id | Title / Purpose |
|----|-----------------|
| `page-list` | รายการแผนงาน/โครงการ — project list table |
| `page-form` | Step 1 — ตั้งงบลงทุนประจำปี 2570 (basic info + file upload) |
| `page-form-2` | Step 2 — ข้อมูลงาน / ข้อมูลแผนงาน (work details, sub-tabs) |
| `page-form-3` | Step 3 — งบประมาณ / EMV / สรุปแผนการลงทุน (budget entry) |
| `page-form-4` | Step 4 — budget breakdown table (monthly, carry-forward, OH) |

Navigation: `goForm(n)` → page-form-n, `goList()` → page-list

---

## Pages inside view-review

| id | Purpose |
|----|---------|
| `page-review-list` | รายการแผนงาน/โครงการ (reviewer's project list) |

---

## Page 1 — Form Fields (page-form)

| id/name | Label |
|---------|-------|
| `projectTypeSelect` | ประเภทงานรายปี |
| `wbsNumber` | หมายเลข WBS |
| `workName` | ชื่องาน |
| `deptSelect` | แผนกที่รับผิดชอบ |
| `yearFrom` / `yearTo` | ระยะเวลา จากปี / ถึงปี |
| `file-pvk`, `file-board` | อัปโหลดไฟล์ |
| `upload-pvk`, `upload-board` | file upload triggers |

---

## Page 2 — Sub-tabs (page-form-2)

Tabs live inside `subTabBar` / `s3TabBar`, managed by `switchSubTab()` / `switchS3Tab()`.
- Each sub-tab has id like `stab-1`, `s3stab-1`
- Add tab: `addSubTab()`, Delete: `confirmDeleteSubTab()`

Key fields per sub-tab:
- Plan years: `yearFrom26` / `yearTo26`
- Budget target: `s26Target`, `s26OpBudget`, `s26Total`
- Plan table: `planTable` / `planTbody` (rows via `addPlanRow()`)
- Plan32 table: `plan32Tbody` (rows via `addPlan32Row()`)
- Risk: `risk13Tbl` / `risk13Tbody` (rows via `addRisk13Row()`)
- SDG total: `sdgTotalVal`, Strategy total: `stratTotalVal`

Financial indicators (form labels):
- Payback period, NPV, FIRR, EIRR, Output, Outcome, org/community/env impacts

---

## Page 3 — Budget Table (page-form-3)

Tab bar: `s3TabBar` → tabs: งบประมาณ / EMV / สรุปแผนการลงทุน
- `switchS3Tab(el, 's3stab-1')` 
- Budget rows: `s3BudgetTbl` / `s3BudgetRows` (built by `buildS3BudgetRows()`)
- EMV table: `emvTbl-s3stab-1` (built by `buildEmvTable()`)
- IDC section: `idcWrap` — fields: `idcAmount`, `idcRate`, `idcBondRate`, `idcBondYears`, `idcSpread`
- IDC details: `idcDetail31` / `idcDetail32`, tables: `idcTable31Wrap`, `idcTable32Wrap`
- OH (overhead) table: `ohTableWrap` (built by `buildOhTable()`)
- Validation modal: `s3ValidationModal`

---

## Page 4 — Budget Breakdown (page-form-4)

- Scroll container: `p4Scroll`
- Op table: `p4OpTable` (built by `buildP4OpTableHTML()`)
- Summary panes: `p4SumPane1`, `p4SumPane2` (tabs via `switchP4Tab()`)
- Filter bars: `p4SumPane1-filterbar`, `p4SumPane2-filterbar`
- Tab bar: `p4TabBar`
- Carry-forward: `carry_forward`, `carry_year`, built by `buildP4CarryBanner()`
- Month columns toggle: `toggleP4MonthCols()`, `toggleP4YearMonths()`
- Group collapse: `toggleP4Group()` / `_collapseP4Grp()`

---

## Key JS Functions by Area

### Navigation
- `showMain()` — go to view-main
- `showCapex()` — go to view-capex
- `showReview()` — go to view-review
- `showPage(id)` — show a page div inside current view
- `goForm(n)` — go to page-form-n (validates before leaving)
- `goList()` / `tryGoList()` — go to page-list (checks unsaved)

### Data / State
- `fillMockData()` — loads all mock data into form
- `_doMockData()` — internal mock loader
- `bgtSave()` / `bgtRestore()` — localStorage budget state
- `_saveProjectState()` / `_restoreProjectState()` — project state
- `_markDirty()` / `_markClean()` — unsaved changes tracking

### Budget Calculation
- `recalcBgtAll()` — recalculate all budget rows
- `calcKhotangBgt()` / `calcKhotangBgtDyn()` — ผูกพัน budget calc
- `buildBgtTable()` / `buildBgtTableKhotang()` / `buildBgtTablePhukpan()` — render budget tabs
- `buildP4OpTableHTML()` — render page-4 operations table
- `sumBgtTabForYear()`, `calcSubtabTotal()` — sum helpers

### Validation
- `validateAndNext()` — step 1 → 2
- `validateStep2AndNext()` — step 2 → 3
- `validateStep3AndNext()` — step 3 → 4
- `validateAndSave()` / `doSave()` — final save
- `_showValidationModal()`, `scrollToFirstErr()`

### Year Picker
- `yrPickInit(id)`, `yrPickRender(id)`, `yrPickToggle(id)`, `yrPickSelect(id, yr)`
- IDs: `yearFrom`, `yearTo`, `yearFrom26`, `yearTo26`

### File Upload
- `triggerUpload(id)`, `handleFileSelect(input)`, `removeFile(el)`
- `checkUploadRequired()`, `updateUploadRequired()`

---

## Modals

| id | Purpose |
|----|---------|
| `validationModal` | General validation errors |
| `s3ValidationModal` | Step 3 validation |
| `bgtErrModal` | Budget error |
| `saveConfirmModal` | Confirm save |
| `deleteConfirmModal` | Confirm delete |
| `unsavedModal` | Unsaved changes warning |
| `flowModal` | System flow diagram popup |
| `modalMsg` | Generic message |

---

## CSS / Layout Notes
- Single `<style>` block (all inline in the HTML)
- Uses custom CSS classes, no external framework detected
- Sticky header on budget tables: `p4FixStickyHeader()`
- Toast notifications: `showToast(msg)`
- Tab color groups follow `COL_GROUPS` pattern (same as budget-app)

---

## Sections Not Fully Explored
- Full mock data shape (`_mockEmvProject1`, `_mockProject2Step2`, etc.)
- Complete IDC calculation logic (table 31/32 structure)
- OH (overhead) calculation detail
- The approval/review flow inside `view-review`
