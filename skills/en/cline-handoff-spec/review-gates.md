# Review gates & fix packs

Used after the **executor** finishes a handoff (Cursor reviews Cline work, or Cline/Cursor reviews Cursor work). Keep reports short; evidence from `git diff` / file reads. See [routing.md](routing.md).

## ACTIVE.md template

```markdown
# Agent Handoff Active Pointer

- **spec**: specs/SPEC-YYYYMMDD-HHMM-<slug>.md
- **executor**: cline
- **status**: ready
- **updated**: YYYY-MM-DD HH:MM (local)
- **one_liner**: <one sentence goal>
- **author**: cursor-agent
- **parent_spec**: <optional original SPEC path if this is a fix pack>

## For executor

- executor `cline` → Cline skill `execute-cline-spec`
- executor `cursor` → Cursor skill `execute-cursor-spec`
```

`status` values: `ready` | `in_progress` | `blocked` | `done` | `rejected`  
`executor` values: `cline` | `cursor` — fix packs **must** copy parent executor.

## Review procedure

1. Read ACTIVE.md → current spec (and parent if fix pack).
2. Run `git status` and `git diff` (include untracked). Map every changed path.
3. Score gates G1–G5. Each is **PASS** or **FAIL** with 1–3 evidence bullets (file:hunk or behavior).
4. Decide:
   - All PASS → done path: ACTIVE `done`, then **record/update lesson** per [lessons.md](lessons.md) (mandatory): classify kind/facet/module/layer, capture `git log` short sha(s) or `pending`, set style_anchor. Put failed-gate `avoid` notes into the lesson when this PASS followed fix packs. Do not archive SPEC without an INDEX row.
   - Any FAIL → fix-pack path (below); **do not** write a full lesson yet; **must** emit ready-to-paste AI prompt with numbered 修改建议 (see Paste prompt section).
5. Tell the user the verdict table first, then the paste prompt if failing (or `lesson recorded/updated` if PASS).

### G1 Allowlist

- List every changed path vs Allowlist.
- Unlisted path = FAIL unless user explicitly expanded scope in chat (then update Allowlist in fix pack).

### G2 Acceptance

- Tick each acceptance criterion against the diff / quick verify commands from the spec.
- Missing criterion = FAIL.

### G3 Regression / blast radius

Ask:

- Does this change shared helpers, public APIs, routers, schemas, global i18n keys, or defaults used elsewhere?
- Are call sites / dual locales / tests for sibling features left inconsistent?
- Could default values or control flow alter unrelated UI/API paths?

FAIL if risk is real and unmitigated (no test, no scoped guard, accidental coupling). PASS if impact is intentionally in-scope and covered.

### G4 Style match

Compare hunks to surrounding code in the same file/module:

- naming, import order, layering (domain/application/adapters), error_code vs prose, Vue/composable patterns, test fixtures
- FAIL on new patterns that fight the file, comment noise, or inconsistent i18n key style

### G5 Minimal diff

Prefer the smallest change that satisfies acceptance:

- FAIL on drive-by renames, wholesale reformat, unused abstractions, duplicated logic that could call an existing helper, or “while we’re here” edits
- FAIL if a 5-line local fix would replace a 50-line rewrite
- PASS if every hunk maps to a stated step

## Optional review report

Write `reviews/REVIEW-YYYYMMDD-HHMM-<slug>.md`:

```markdown
# Review <slug>

- **spec**: specs/…
- **git**: <short sha or "working tree">
- **verdict**: PASS | FAIL

| Gate | Result | Evidence |
|------|--------|----------|
| G1 Allowlist | PASS/FAIL | … |
| G2 Acceptance | PASS/FAIL | … |
| G3 Regression | PASS/FAIL | … |
| G4 Style | PASS/FAIL | … |
| G5 Minimal | PASS/FAIL | … |

## Required fixes
- …

## Cline paste prompt
(see below)
```

## Fix-pack spec template

Save as `specs/SPEC-YYYYMMDD-HHMM-<slug>-fix-N.md` (N starts at 1).

```markdown
---
id: SPEC-YYYYMMDD-HHMM-<slug>-fix-N
title: Fix pack N — <slug>
status: ready
priority: high
created: YYYY-MM-DDTHH:MM:SS
author: cursor-agent
executor: cline
repo_root: .
parent_spec: specs/SPEC-….md
allow_commit: false
allow_push: false
fix_reason: <G3 regression | G4 style | G5 minimal | G1 allowlist | G2 acceptance>
---

# Fix pack N — <title>

## Meta

| Field | Value |
|-------|-------|
| Goal | Make parent handoff pass quality gates G1–G5 |
| Parent | specs/SPEC-….md |
| Failed gates | Gx, Gy |

## Constraints

- Only edit Allowlist paths below.
- Prefer **revert + smaller re-apply** over layering more code on a bad approach.
- Do not commit/push.
- Do not expand scope beyond fixing the failed gates.

## Allowlist

- `path/a` — <exact fix>
- `path/b` — <exact fix>

## Forbidden

- Re-introducing rejected hunks listed in “Revert / remove”
- New refactors unrelated to failed gates
- Editing files outside Allowlist

## Revert / remove

Concrete deletions (quote symbols or describe hunks):

- [ ] Revert or delete: <file>::<symbol or line intent> — reason: <gate>
- [ ] Undo formatting-only changes in <file>

## Required edits

- [ ] <file>: <precise change>
- [ ] Verify: <command or manual check>

## Acceptance criteria

- [ ] Previously failed gates now PASS (Gx, Gy)
- [ ] Parent acceptance criteria still hold
- [ ] `git diff` only touches Allowlist
- [ ] Diff is smaller or equal focus vs pre-fix (no new drive-by)

## Done protocol

1. Check off steps/acceptance in this file.
2. ACTIVE.md → `status: ready` still pointing here until Cursor re-reviews; after your work set `status: in_progress` then leave for Cursor — or set `status: ready` and tell user to ask Cursor to re-review.
3. Reply with files changed + what was reverted/fixed per gate.
```

## Paste prompt for user → executor (fix pack)

On **any FAIL**, you MUST give the user a **ready-to-paste AI prompt** in the chat reply (fenced `text` block). Do not only link the fix-pack path.

### Required chat output on FAIL

1. Gate table (G1–G5 PASS/FAIL + evidence).
2. Write/update `specs/SPEC-…-fix-N.md`.
3. Point ACTIVE at it.
4. Emit **one** paste block below (fill concrete paths / file:hunk advice). The block must include:
   - which execute skill
   - fix-pack path
   - bullet **修改建议** the executor can follow without re-reading the review chat (revert X, change Y to Z, mirror style_anchor / lesson git sha if relevant)

Pick skill from ACTIVE `executor`:

**executor: cline**
```text
使用 skill execute-cline-spec。读取并严格执行 .cline/handoff/ACTIVE.md（fix pack：.cline/handoff/specs/SPEC-…-fix-N.md）。

修改建议（按顺序做，不要扩大范围）：
1) Revert/remove：<具体文件与符号/hunk 意图>
2) 最小补丁：<具体怎么改，对齐哪个 style_anchor 或 git sha>
3) Verify：<命令或手工检查>
4) 只改 allowlist；不要 commit；完成后汇报，并请对方重新质量门禁。
```

**executor: cursor**
```text
使用 skill execute-cursor-spec。读取并严格执行 .cline/handoff/ACTIVE.md（fix pack：.cline/handoff/specs/SPEC-…-fix-N.md）。

修改建议（按顺序做，不要扩大范围）：
1) Revert/remove：<具体文件与符号/hunk 意图>
2) 最小补丁：<具体怎么改，对齐哪个 style_anchor 或 git sha>
3) Verify：<命令或手工检查>
4) 只改 allowlist；不要 commit；完成后汇报，并请对方重新质量门禁。
```

If a failed gate relates to style (G4) or minimal (G5), the paste prompt MUST name the **style_anchor** and/or lesson **git sha** to mirror when one exists.

## Re-review

After the executor applies a fix pack, run the same G1–G5 again on the **full** remaining diff vs original parent goal (not only the fix-pack hunks). New FAIL → `fix-(N+1)` + new paste prompt.
