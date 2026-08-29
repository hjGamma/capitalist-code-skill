# 交接 SPEC 模板

复制到 `.cline/handoff/specs/SPEC-YYYYMMDD-HHMM-<slug>.md` 并填空。

```markdown
---
id: SPEC-YYYYMMDD-HHMM-<slug>
title: <短标题>
status: ready
priority: normal
created: YYYY-MM-DDTHH:MM:SS
author: cursor-agent
executor: cline
repo_root: .
branch_hint: <可选>
allow_commit: false
allow_push: false
---

<!-- Cline 写给 Cursor 时：author: cline，executor: cursor -->

# <title>

## Meta

| 字段 | 值 |
|------|-----|
| Goal | <一句话> |
| Context | <背景 2–5 句> |
| Out of scope | <列表> |

## Lessons applied

无命中可删。有命中：`- L-…: <如何影响方案>`

## Constraints

- 遵循现有约定；未列出则不新增依赖
- 只改 **Allowlist**（新建文件须 `create:`）
- 默认不 commit/push
- 禁止顺手重构

## Allowlist

- `path` — modify: <做什么>
- `create: path` — create: <职责>

## Forbidden

- 名单外文件；未授权改契约；删测试凑绿；commit/push

## Current behavior / bug

## Target behavior

## Implementation plan

### Step 1 — <名>

- [ ] <动作>
- [ ] Verify: <命令或手工>

## Acceptance criteria

- [ ] …
- [ ] `git diff` 仅 Allowlist
- [ ] 无新增 lint/类型错误

## Verification commands

```bash
# 项目真实命令
```

## Done protocol

勾选完成项；更新 ACTIVE；汇报摘要/文件/命令；未授权不 commit。

## Notes for executor

Allowlist 不对则停止上报；最小 diff；贴合本地风格。
```
