# Agent handoff routing (Cursor ↔ Cline)

Single queue: `.cline/handoff/`. Direction is the **executor** field.

| Author | executor | Write skill | Execute skill |
|--------|----------|-------------|---------------|
| Cursor | `cline` | Cursor: `cline-handoff-spec` | Cline: `execute-cline-spec` |
| Cline | `cursor` | Cline: `cursor-handoff-spec` | Cursor: `execute-cursor-spec` |

## ACTIVE.md

```markdown
# Agent Handoff Active Pointer

- **spec**: specs/SPEC-YYYYMMDD-HHMM-<slug>.md
- **executor**: cline | cursor
- **status**: ready
- **updated**: YYYY-MM-DD HH:MM (local)
- **one_liner**: <goal>
- **author**: cursor-agent | cline
- **parent_spec**: <optional>

## For executor

- If executor is `cline` → Cline skill `execute-cline-spec`
- If executor is `cursor` → Cursor skill `execute-cursor-spec`
```

## Review

Non-implementing peer (or user asking either agent) runs G1–G5 from `review-gates.md`.
Fix packs keep the **same** `executor` as the parent so the same agent applies fixes.

## Lessons

Shared: `.cline/handoff/lessons/` — both writers consult INDEX before drafting; record only after gates PASS.
