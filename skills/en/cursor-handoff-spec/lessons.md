# Lessons ledger (cheap memory + team style memory)

Goal: reuse past outcomes **without** dumping history into every prompt.  
Audience: Cursor ↔ Cline agents **and** human teammates. One INDEX row ≈ one searchable memory; bodies stay ≤20 lines.

## Layout

```text
.cline/handoff/lessons/
  INDEX.md                 # ONLY full-scan file (one row per lesson)
  TAXONOMY.md              # controlled vocab (read only when tagging/unsure)
  L-YYYYMMDD-<slug>.md     # short body; read ≤3 per task after INDEX hits
```

Commit `.cline/handoff/lessons/` with the repo so the team shares style memory. Prefer not to gitignore it.
When tagging, use **project** `TAXONOMY.md` first; keep skill [TAXONOMY.md](TAXONOMY.md) in sync when adding facets.

---

## Classification (required on every lesson)

Every lesson carries **four orthogonal axes** (plus free tags). Agents and humans filter INDEX by these first — never by reading all bodies.

| Axis | Field | Purpose | Example |
|------|-------|---------|---------|
| Change kind | `kind` | What class of edit | `bugfix`, `i18n`, `feature`, `style-ui`, `test`, `audit`, `api` |
| Feature facet | `facet` | Cross-module **same capability type** (style transfer) | `audit-action-i18n`, `form-char-count`, `audit-client-ip` |
| Module | `module` | Bounded context / area | `probe_management`, `audit`, `scan-orchestration` |
| Layer | `layer` | Where code lives | `frontend`, `backend`, `full-stack`, `docs` |

**Rules**

- Prefer vocab in [TAXONOMY.md](TAXONOMY.md). New `facet` only when no existing facet fits; add it to TAXONOMY in the same change.
- One primary `kind` / `facet` / `module` / `layer` in INDEX (comma-join only if truly dual, max 2).
- Free `tags`: extra keywords (`client-ip`, `websocket`, …), lowercase kebab, ≤6.

---

## INDEX.md format

```markdown
# Handoff lessons index

<!-- kind/facet/module/layer: see TAXONOMY.md; git = short sha or pending -->

| id | date | status | kind | facet | module | layer | signature | git | path |
|----|------|--------|------|-------|--------|-------|-----------|-----|------|
| L-20260829-remote-support-audit-i18n-ip | 2026-08-29 | solved | bugfix,i18n | audit-action-i18n,audit-client-ip | probe_management | full-stack | remote support audit action untranslated; Opened/Closed IP blank | pending | L-20260829-remote-support-audit-i18n-ip.md |
```

- **signature**: ≤16 words, symptom or capability oriented.
- **git**: one short sha if single commit; `a1b2c3d+` if multiple (first sha + `+`); `pending` if not committed yet.
- **status**: `solved` | `partial` | `wontfix`
- Never put long prose in INDEX.

---

## Lesson body format (≤20 lines)

```markdown
# L-YYYYMMDD-<slug>

- **signature**: <same as INDEX>
- **kind** / **facet** / **module** / **layer**: <same as INDEX>
- **tags**: a, b, c
- **symptom**: <1-2 lines>
- **root_cause**: <1-2 lines>
- **fix_pattern**: <1-3 lines; what to copy next time>
- **style_anchor**: <file or symbol teammates/agents should mimic> — e.g. `remote_support_session_handlers.py::_audit_context_with_operator_ip`
- **avoid**: <1-2 lines>
- **files**: short paths/basenames
- **spec**: archive/SPEC-….md or specs/…
- **git.branch**: <branch or `-`>
- **git.commits**: `<shortsha> <subject>` (one per line under this key, max 5)
- **git.status**: committed | pending
- **gates**: Gx notes / none
- **seen**: 1
```

Recurring issue: update same id (`seen += 1`), refresh pattern/avoid/git; do not duplicate INDEX rows.

### Capturing git (on record or “补记 git”)

```bash
git rev-parse --abbrev-ref HEAD
git log -5 --oneline -- <paths from lesson files>
# or, if user just committed:
git log -1 --format='%h %s'
```

- If handoff merged/committed: fill `git.commits` + INDEX `git` column; `git.status: committed`.
- If still working tree only: `git.status: pending`, INDEX `git: pending`. When user later says 补记 git / 更新 lesson git → amend that lesson only (cheap).

Do **not** paste full diffs or patch text into lessons.

---

## Before writing a SPEC (mandatory, cheap)

Budget: **<30s tools**, **≤3 lesson bodies**.

1. Extract tokens from the request + classify intent → tentative `kind` / `facet` / `module`.
2. Search INDEX with **tiered queries** (stop early when ≤3 strong hits):

```bash
# A) Same bug / symptom
rg -i -n 'token1|token2' .cline/handoff/lessons/INDEX.md

# B) Same module (style + local patterns)
rg -i -n '\| *<module> *\|' .cline/handoff/lessons/INDEX.md

# C) Same facet across modules (cross-module style consistency)
rg -i -n '\|[^|]*<facet>[^|]*\|' .cline/handoff/lessons/INDEX.md

# D) Same kind (optional, broader)
rg -i -n '\| *bugfix *\||\| *i18n *\|' .cline/handoff/lessons/INDEX.md
```

3. Rank: facet match > module match > kind match > weak tag hit. Read top **≤3** bodies.
4. **Read related git (mandatory when `git.status` is `committed` / INDEX `git` ≠ `pending`)**:
   For each selected lesson with a short sha:
   ```bash
   git show <sha> --stat --format='%h %s%n%an %ad' --date=short
   # If style/facet match is the reason for the hit, also:
   git show <sha> -- <style_anchor path or top 1-3 files from lesson>
   ```
   Budget: prefer `--stat` always; full file patch only for **≤2** files / lesson, skip binary/huge files. Summarize into planning as “pattern from `<sha>`: …”.
   If `pending` or sha missing in this clone: note `git: unavailable` and rely on style_anchor + lesson body only.
5. When applying style: prefer hit’s **style_anchor** + patterns observed in that commit (do not invent a conflicting approach).
6. SPEC section if hits > 0:

```markdown
## Lessons applied

- L-… (facet=…, module=…, git=<sha|pending>): <one line; cite style_anchor>
```

Chat line: `lessons: N hits (ids…); git-read: <shas or none>` plus which tier (bug/module/facet).

**Do not** read all `L-*.md` or all old SPECs. **Do not** dump entire patches into the SPEC — cite sha + 1-line takeaway.

---

## After gates PASS (mandatory record)

1. Classify `kind` / `facet` / `module` / `layer` via TAXONOMY.
2. Collect git (or mark `pending`).
3. Dedup via INDEX `rg`; else append INDEX row + body.
4. Reply: `lesson recorded: L-…` / `lesson updated: L-… (seen=N)` + `git: <sha|pending>`.

Archive SPEC without lesson = incomplete. If archiving, ensure INDEX row exists or create it in the same turn.

## After gates FAIL

No full lesson until final PASS (`avoid` captures failed approaches).

---

## Team collaboration

- Humans: before starting a module/feature, skim INDEX filtered by `module` or `facet`; open 1–2 lessons + optional `git show <sha>`.
- PR description can cite `L-…` and `facet=…` so reviewers check style_anchor consistency.
- Agents must not invent conflicting patterns when a facet lesson exists — copy style_anchor approach unless SPEC explicitly overrides.
- Keep TAXONOMY.md small; reject one-off facet spam.

---

## Efficiency hard rules

| Do | Don't |
|----|--------|
| Filter INDEX by kind/facet/module first | Load entire lessons/ |
| ≤3 bodies per task | Embed commits’ full diffs in SPEC/lesson |
| Short sha + subject only | Duplicate near-identical lessons |
| `pending` then 补记 git | Block recording until commit |
| Shared TAXONOMY | Free-form essay categories |
| `git show` hit shas on recall | Ignore committed lessons’ git history |

## Global fallback

`~/.cline/handoff/<repo-dirname>/lessons/` only if project path unwritable. Prefer project-local for team visibility.
