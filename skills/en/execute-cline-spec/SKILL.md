---
name: execute-cline-spec
description: >-
  Reads and strictly executes handoff PRD/specs whose executor is cline, from
  .cline/handoff/ACTIVE.md or specs/SPEC-*.md (including fix packs). Use when
  the user says 执行 handoff、execute-cline-spec、跑 ACTIVE spec、按 spec 改代码、
  执行 Cursor 方案、修订单、fix pack. If ACTIVE executor is cursor, stop and
  tell user to use Cursor skill execute-cursor-spec.
---

# Execute Cline Handoff Spec

## Announce

"Using execute-cline-spec — loading handoff from `.cline/handoff/`."

## Locate the spec

1. Prefer path the user gave.
2. Else read `.cline/handoff/ACTIVE.md` → `spec:` path.
3. Else list `.cline/handoff/specs/` and ask if ambiguous.
4. If missing: stop — ask for Cursor skill `cline-handoff-spec` first.

## Pre-flight

1. Read entire spec.
2. Confirm `executor` is `cline` (frontmatter and/or ACTIVE). If `executor: cursor`, **stop** — user should run Cursor `execute-cursor-spec`.
3. `status` is `ready` or `in_progress` (not `done` unless redo).
4. ACTIVE → `in_progress`; keep `executor: cline`.
5. Allowlist sandbox; no commit/push unless frontmatter allows.

## Fix packs

1. Revert/remove first, then Required edits.
2. Do not re-introduce G3/G4/G5 failures.
3. Afterward ask user to have **Cursor** (or peer) re-run quality gates — do not self-declare final PASS.

## Execution rules

- Only spec requirements; check off steps in the file; run Verify; match local style; minimal hunks.
- Blocked → ACTIVE `blocked`; do not expand Allowlist.

## Completion

1. Acceptance vs reality  
2. Files changed  
3. Commands + results  
4. ACTIVE: `ready` for peer gate review (or `blocked`). Do not set `done` / write lessons — reviewer does after G1–G5 PASS.

## Do not

- Execute `executor: cursor` specs  
- Edit outside Allowlist; skip tests to go green; commit/push; claim gates passed  
- Write Cursor-bound specs here — that is `cursor-handoff-spec`
