---
name: cursor-handoff-spec
description: >-
  After planning a coding task, consults .cline/handoff/lessons/INDEX.md for
  similar past issues, then writes a Cursor-executable PRD/spec under
  .cline/handoff/specs/ with executor cursor and updates ACTIVE.md. Use when
  the user wants Cline to hand off to Cursor, 给 Cursor、发给 Cursor、handoff
  to Cursor、写给 Cursor 的方案、让 Cursor 改代码.
---

# Cursor Handoff Spec (Cline → Cursor)

## Announce

"Using cursor-handoff-spec — writing a Cursor handoff under `.cline/handoff/`."

## When to use

User wants **you (Cline)** to plan and **Cursor** to implement. If user wants you to implement, use `execute-cline-spec` on an existing spec or just code — do not write a Cursor handoff.

## Shared protocol (read once if needed)

Sibling files in this skill directory (after install):

- [lessons.md](lessons.md)
- [spec-template.md](spec-template.md)
- [review-gates.md](review-gates.md)
- [routing.md](routing.md)
- [TAXONOMY.md](TAXONOMY.md)

Project store: `.cline/handoff/` (same queue as Cursor→Cline).

## Workflow

1. Confirm goal / scope / constraints.
2. **Lessons first** (cheap): follow lessons.md — `rg` only `lessons/INDEX.md`, read ≤3 `L-*.md` bodies.
3. Inspect repo for **concrete paths** only.
4. Slug: lowercase kebab-case, ≤40 chars.
5. Write `specs/SPEC-YYYYMMDD-HHMM-<slug>.md` from spec-template with:
   - `author: cline`
   - `executor: cursor`  ← required
6. Overwrite `ACTIVE.md`:

```markdown
# Agent Handoff Active Pointer

- **spec**: specs/SPEC-YYYYMMDD-HHMM-<slug>.md
- **executor**: cursor
- **status**: ready
- **updated**: YYYY-MM-DD HH:MM (local)
- **one_liner**: <one sentence goal>
- **author**: cline

## For Cursor

Say: `执行 handoff` or `execute the active cursor handoff spec`

Cursor skill: `execute-cursor-spec`
```

7. Reply with: spec path, **paste prompt for Cursor**, allowlist summary, `lessons: N hits`.

## Spec quality bar

Same as Cursor→Cline: executable alone, hard Allowlist/Forbidden, checkbox steps + verify, binary acceptance, no commit unless `allow_commit: true`.

## Paste prompt → Cursor

```text
使用 skill execute-cursor-spec。读取并严格执行 .cline/handoff/ACTIVE.md 指向的 spec（executor 必须是 cursor）。只改 allowlist，完成后按 Done protocol 汇报，并请我（或 Cline）做质量门禁复审。
```

## After Cursor finishes

When user says 审一下 / review：

1. Follow `review-gates.md` (G1–G5) on `git diff`.
2. FAIL → write `SPEC-…-fix-N.md` with `executor: cursor`, point ACTIVE at it, give paste prompt for Cursor.
3. PASS → ACTIVE `done`; record lesson per lessons.md.

## Do not

- Set `executor: cline` in this skill (wrong direction).
- Implement the task yourself unless user cancels handoff.
- Dump full lesson corpus into the SPEC.
- Commit/push.
