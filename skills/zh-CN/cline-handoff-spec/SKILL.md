---
name: cline-handoff-spec
description: >-
  双向智能体交接：分类 lessons 账本（kind/facet/module/layer + git sha），回忆时读取
  相关 git；为 Cline 写 SPEC；G1–G5 门禁；FAIL 时输出可直接粘贴的 AI 修改提示词。
  用于：给 Cline、handoff、审一下、质量门禁、lessons、补记 git、监管 Cline。
---

# 交接规格撰写（Cursor → Cline）+ 共享复审

方向表见 [routing.md](routing.md)。

## 何时使用

1. 用户要 **Cline** 实现 → 写 `executor: cline` 的 SPEC。
2. 用户说「审一下 / 质量门禁」→ 跑门禁。
3. 不要用本 skill 写 `executor: cursor`。

## 存储

`.cline/handoff/`（ACTIVE / specs / lessons / archive）。Lessons 请提交进业务仓库。

## 工作流（写给 Cline）

1. 确认目标。  
2. **先查 lessons**（[lessons.md](lessons.md)）：rg INDEX → ≤3 正文 → **`git show` 相关 sha**。  
3. 写 SPEC + ACTIVE。  
4. 回复路径、粘贴提示、`lessons: N hits; git-read: …`。

## 质量门禁

见 [review-gates.md](review-gates.md)。

**FAIL** → fix pack + ACTIVE + **聊天里必须给出可直接粘贴的修改建议提示词**。  
**PASS** → 记 lesson（含 git）。

## 禁止

写 cursor 单；放水门禁；回忆时忽略已提交 lesson 的 git；无 lesson 归档。
