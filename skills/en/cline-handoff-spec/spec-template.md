# Spec template for Cline handoff

Copy into `.cline/handoff/specs/SPEC-YYYYMMDD-HHMM-<slug>.md` and fill. Keep YAML frontmatter valid.

```markdown
---
id: SPEC-YYYYMMDD-HHMM-<slug>
title: <short title>
status: ready
priority: normal
created: YYYY-MM-DDTHH:MM:SS
author: cursor-agent
executor: cline
repo_root: .
branch_hint: <optional current branch or leave empty>
allow_commit: false
allow_push: false
---

<!-- Set executor to `cursor` when Cline authors a handoff for Cursor (skill cursor-handoff-spec). -->

# <title>

## Meta

| Field | Value |
|-------|-------|
| Goal | <one sentence> |
| Context | <why / background, 2-5 sentences max> |
| Out of scope | <bullets> |

## Lessons applied

Omit this section if INDEX had 0 hits. Otherwise one bullet per used lesson (no pasted bodies):

- L-…: <how it shaped allowlist / approach / avoid>

## Constraints

- Follow existing project conventions; do not introduce new deps unless listed below.
- Only edit files in **Allowlist**. Creating a new file is allowed only if listed as `create:`.
- Do not commit or push unless frontmatter `allow_commit` / `allow_push` is true.
- Do not drive-by refactor, renames, or formatting outside touched hunks.
- <project-specific hard rules, e.g. i18n, tenant_id, no frontend_demo>

## Allowlist

Paths relative to repo root. Anything not listed is **forbidden**.

- `path/to/existing.ts` — modify: <what>
- `create: path/to/new.ts` — create: <responsibility>
- `path/to/locale.ts` — modify: <keys only>

## Forbidden

- Editing files outside Allowlist
- Changing public API / YAML truth sources unless listed
- Deleting tests to make suite green
- `git commit` / `git push` / force checkout
- <extra forbids>

## Current behavior / bug

<what happens now; optional repro steps>

## Target behavior

<what should happen after the change>

## Implementation plan

Ordered steps. Check boxes as you complete them.

### Step 1 — <name>

- [ ] <concrete action>
- [ ] Verify: <command or manual check>

### Step 2 — <name>

- [ ] <concrete action>
- [ ] Verify: <command or manual check>

## Acceptance criteria

- [ ] <observable criterion 1>
- [ ] <observable criterion 2>
- [ ] `git diff` only touches Allowlist paths
- [ ] No new linter/type errors in touched files

## Verification commands

```bash
# fill with real commands for this repo, or "manual: …"
```

## Done protocol

When finished (or blocked):

1. Mark completed steps / acceptance checkboxes in this file.
2. Update `.cline/handoff/ACTIVE.md`:
   - `status: done` if all acceptance pass
   - `status: blocked` + reason if stuck
3. Reply with:
   - Summary (3–6 bullets)
   - Files changed (list)
   - Commands run + results
   - Residual risks / follow-ups
4. Do **not** commit unless `allow_commit: true`.

## Notes for executor

- If Allowlist is wrong or a required file is missing, **stop** and report; do not expand scope silently.
- Prefer minimal diffs. Match local style.
```
