---
name: cline-handoff-spec
description: >-
  双向智能体交接：分类 lessons 账本（kind/facet/module/layer + git sha），低 token
  检索并保持团队代码风格一致。为 Cline 写可执行 SPEC，跑 G1–G5 质量门禁，PASS
  后记 lesson。用于：给 Cline、handoff、审一下、质量门禁、lessons、补记 git、
  监管 Cline。写给 Cursor 的任务请用 cursor-handoff-spec。
---

# 交接规格撰写（Cursor → Cline）+ 共享复审

方向表见 [routing.md](routing.md)。

## 何时使用

1. 用户要 **Cline** 实现 → 写 `executor: cline` 的 SPEC。
2. 用户说「审一下 / 质量门禁」→ 跑 **质量门禁**。
3. **不要**用本 skill 写 `executor: cursor`（用 Cline 的 `cursor-handoff-spec`）。

若 ACTIVE 指向 Cursor 执行 → 用 `execute-cursor-spec`。

## 存储

```text
.cline/handoff/
  ACTIVE.md
  specs/
  reviews/
  lessons/
    INDEX.md
    TAXONOMY.md
    L-*.md
  archive/
```

Lessons 为团队风格记忆，请提交进 git。写 SPEC 前过滤 INDEX；PASS 后记分类 + git（或 `pending`）。

## 工作流（写给 Cline）

1. 确认目标 / 范围。
2. **先查 lessons** — [lessons.md](lessons.md)。
3. 真实路径；slug ≤40 kebab-case。
4. [spec-template.md](spec-template.md)：`executor: cline`。
5. 更新 ACTIVE（`executor: cline`）。
6. 回复路径、粘贴提示、allowlist、`lessons: N hits`。

### 粘贴给 Cline

```text
使用 skill execute-cline-spec。读取并严格执行 .cline/handoff/ACTIVE.md（executor 必须是 cline）。只改 allowlist，完成后按 Done protocol 汇报。
```

## 质量门禁

见 [review-gates.md](review-gates.md)。

| 门禁 | 失败条件 |
|------|----------|
| G1 Allowlist | 名单外修改 |
| G2 Acceptance | 未达验收 |
| G3 Regression | 误伤失控 |
| G4 Style | 风格冲突 |
| G5 Minimal | 非最小改动 |

**FAIL** → fix pack；**PASS** → 记 lesson。无 INDEX 勿只归档。

## 禁止

写 `executor: cursor`；放水门禁；散文 lesson；规格含密钥；无 lesson 归档。
