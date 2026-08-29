---
name: cline-handoff-spec
description: >-
  Bidirectional agent handoff with a classified lessons ledger (kind/facet/module/
  layer + git sha) for token-cheap recall and team style consistency. Writes
  Cline specs, runs G1–G5 gates, records lessons on PASS. Use for 给 Cline、
  handoff、审一下、质量门禁、lessons、补记 git、监管 Cline. Cline→Cursor write
  uses cursor-handoff-spec.
---

# Handoff Spec Writer (Cursor → Cline) + shared review

See [routing.md](routing.md) for Cursor ↔ Cline direction table.

## When to use

1. User wants **Cline** to implement → you write SPEC with `executor: cline`.
2. User says 审一下 / 质量门禁 on any ACTIVE handoff (Cline or Cursor executed) → **Quality gates**.
3. Do **not** use this skill to write `executor: cursor` specs — that is Cline’s `cursor-handoff-spec`.

If user wants you to implement a Cursor-bound ACTIVE spec → use `execute-cursor-spec`.

## Storage

```text
.cline/handoff/
  ACTIVE.md
  specs/
  reviews/
  lessons/
    INDEX.md       # kind|facet|module|layer|git — cheap filter
    TAXONOMY.md    # controlled vocab (team + agents)
    L-*.md
  archive/
```

Lessons are **team style memory**: commit them. Before SPEC, filter INDEX by facet/module (see [lessons.md](lessons.md)); on PASS record classification + git sha (or `pending` → later 补记 git).

## Workflow (write → Cline)

1. Confirm goal / scope.
2. **Lessons first** — [lessons.md](lessons.md) (rg INDEX → ≤3 bodies).
3. Concrete paths only; slug ≤40 chars kebab-case.
4. Write SPEC from [spec-template.md](spec-template.md) with `author: cursor-agent`, `executor: cline`.
5. ACTIVE per [routing.md](routing.md) / [review-gates.md](review-gates.md) with **executor: cline**.
6. Reply: path, paste prompt, allowlist, `lessons: N hits`.

### Paste → Cline

```text
使用 skill execute-cline-spec。读取并严格执行 .cline/handoff/ACTIVE.md（executor 必须是 cline）。只改 allowlist，完成后按 Done protocol 汇报。
```

## Quality gates

Follow [review-gates.md](review-gates.md). Works for either executor; fix packs **keep the same executor**.

| Gate | Fail if |
|------|---------|
| G1 Allowlist | Outside allowlist |
| G2 Acceptance | Criteria unmet |
| G3 Regression | Unscoped blast radius |
| G4 Style | Fights local conventions |
| G5 Minimal | Non-minimal / drive-by |

**FAIL** → `SPEC-…-fix-N.md` + ACTIVE + paste prompt for **that** executor’s execute skill.  
**PASS** → ACTIVE `done` + [lessons.md](lessons.md) record (**kind/facet/module/layer** + **git** sha or `pending`). Archive SPEC only together with lesson row.

### Paste → fix (by executor)

- `executor: cline` → `execute-cline-spec` + fix-pack path  
- `executor: cursor` → `execute-cursor-spec` + fix-pack path  

```text
使用 skill <execute-*-spec>。严格执行 ACTIVE 指向的 fix pack：先 Revert/remove，再 Required edits。只改 allowlist。不要 commit。完成后让对方做质量门禁。
```

## Do not

- Write `executor: cursor` from this skill.
- Rubber-stamp gates; dump all lessons; essay lessons; secrets in specs.
- Archive without INDEX lesson; omit git field (`pending` OK until 补记 git).
