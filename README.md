# capitalist-code-skill

**Capitalist Code Skill** — bidirectional handoff between [Cursor](https://cursor.com) Agent and [Cline](https://docs.cline.bot/customization/skills), plus a **classified lessons ledger** so agents and humans keep code style consistent with minimal token cost.

> Chinese README: [README.zh-CN.md](README.zh-CN.md)  
> Author: [hjGamma](https://github.com/hjGamma)

## What it does

| Capability | Description |
|------------|-------------|
| **Plan → Spec** | One agent writes a machine-executable PRD/SPEC under `.cline/handoff/specs/` |
| **Spec → Code** | The other agent executes only the allowlisted files |
| **Quality gates** | G1–G5 review (allowlist, acceptance, regression, style, minimal diff) |
| **Fix packs** | Failed gates → fix SPEC + **ready-to-paste AI prompt** with numbered change advice |
| **Lessons ledger** | On PASS, record `kind` / `facet` / `module` / `layer` + **git sha** for cheap recall |

```text
Cursor ──cline-handoff-spec──▶ SPEC (executor: cline) ──execute-cline-spec──▶ Cline
Cline  ──cursor-handoff-spec──▶ SPEC (executor: cursor) ──execute-cursor-spec──▶ Cursor
                                      │
                                      ▼
                         peer review G1–G5 → lessons/ (+ git)
```

## Skills included

| Skill | Install into | Role |
|-------|--------------|------|
| `cline-handoff-spec` | `~/.cursor/skills/` | Cursor writes tasks for Cline + shared review/lessons protocol |
| `execute-cursor-spec` | `~/.cursor/skills/` | Cursor executes `executor: cursor` specs |
| `cursor-handoff-spec` | `~/.cline/skills/` | Cline writes tasks for Cursor |
| `execute-cline-spec` | `~/.cline/skills/` | Cline executes `executor: cline` specs |

Each skill ships in **`skills/en/`** and **`skills/zh-CN/`**.

## Quick install

```bash
git clone https://github.com/hjGamma/capitalist-code-skill.git
cd capitalist-code-skill
./install.sh en          # or: ./install.sh zh-CN
```

Enable **Cline → Settings → Features → Enable Skills**.

## Daily usage

### Cursor → Cline

1. In Cursor: describe the change, say “hand off to Cline” / 「给 Cline」.
2. Cursor runs `cline-handoff-spec` (lessons INDEX first → SPEC + `ACTIVE.md`).
3. Paste into Cline:

```text
Use skill execute-cline-spec. Strictly execute the spec pointed by .cline/handoff/ACTIVE.md (executor must be cline).
```

4. When done, tell Cursor 「审一下」→ gates → lesson (+ git or `pending`).

### Cline → Cursor

1. In Cline: 「给 Cursor」→ `cursor-handoff-spec`.
2. Paste into Cursor with `execute-cursor-spec`.
3. Peer review + lesson as above.

### Lessons (team + agents)

Project path (commit this with your app repo):

```text
.cline/handoff/lessons/
  INDEX.md      # filter by kind | facet | module | layer | git
  TAXONOMY.md
  L-*.md        # ≤20 lines; style_anchor + git.commits
```

- **Same bug** → search signature / tags  
- **Same module** → filter `module`  
- **Same feature type across modules** → filter `facet` (style transfer)  
- **Align style** → open `style_anchor`, optionally `git show <sha>`

If work is not committed yet: `git: pending`, later say “backfill git on L-…”.

## Design principles

- **Token-cheap**: scan INDEX only; read ≤3 lesson bodies per task  
- **Sandbox**: hard file allowlist; no drive-by refactors  
- **Dual audience**: agents hand off; humans maintain the same ledger for style  
- **No rubber stamps**: G3–G5 must fail when style/blast/minimal are wrong  

## Layout of this repository

```text
capitalist-code-skill/
  README.md / README.zh-CN.md
  install.sh
  skills/
    en/…          # English skills (recommended default for agents)
    zh-CN/…       # Chinese skills
```

## License

MIT — see [LICENSE](LICENSE).
