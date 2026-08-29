---
name: execute-cursor-spec
description: >-
  Reads and strictly executes Cline-written (or peer) handoff PRD/specs whose
  executor is cursor, from .cline/handoff/ACTIVE.md or specs/SPEC-*.md including
  fix packs. Use when the user says 执行 handoff、execute-cursor-spec、跑
  ACTIVE spec、按 spec 改代码、执行 Cline 方案、Cursor 执行任务, or points at
  a SPEC under .cline/handoff with executor cursor.
---

# Execute Cursor Handoff Spec

## Announce

"Using execute-cursor-spec — loading handoff from `.cline/handoff/`."

## Locate the spec

1. Prefer path the user gave.
2. Else read `.cline/handoff/ACTIVE.md` → `spec:` path.
3. Else list `.cline/handoff/specs/` and ask if ambiguous.
4. If missing: stop — ask user/Cline to run `cursor-handoff-spec` first.

## Pre-flight

1. Read entire spec (frontmatter + body).
2. Confirm `executor` is `cursor` (frontmatter and/or ACTIVE). If `executor: cline`, **stop** and tell user to use Cline skill `execute-cline-spec` instead.
3. `status` must be `ready` or `in_progress`. If `done`, do not re-run unless user says redo.
4. Set ACTIVE `status: in_progress`, keep `executor: cursor`.
5. Allowlist = hard sandbox. `allow_commit` / `allow_push` default false.

## Fix packs

If `SPEC-*-fix-N.md` / `fix_reason` / `parent_spec`:

1. **Revert / remove** listed bad hunks first.
2. Then minimal **Required edits**.
3. Do not re-introduce G3/G4/G5 failures called out in the fix pack.

## Execution rules

- Only what the spec requires; checkbox progress in the spec file.
- Run each step’s Verify when present.
- Match local style; minimal hunks; no drive-by refactors.
- Blocked → ACTIVE `blocked` + report; do not expand Allowlist.

## Completion

1. Acceptance checklist vs reality.
2. List files changed (+ reverted if fix pack).
3. Commands run + results.
4. ACTIVE: set `status: ready` and note ready for **peer review** (Cline/user runs G1–G5). Do **not** set `done` or write lessons yourself — reviewer does after gates PASS.
5. Paste hint for user → Cline review:

```text
使用 skill cursor-handoff-spec 的审阅流程（或让 Cursor 用 cline-handoff-spec 质量门禁）：审一下 .cline/handoff/ACTIVE.md 指向的改动，跑 G1–G5。
```

Prefer: user tells Cline「审一下」or Cursor「审一下」— both write skills own the gate procedure.

## Do not

- Execute specs with `executor: cline`
- Edit outside Allowlist
- Self-declare final gate PASS / record lesson on first finish (peer review first)
- Commit/push unless allowed in frontmatter
