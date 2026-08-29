---
name: cursor-handoff-spec
description: >-
  规划后检索 lessons INDEX，写出 executor 为 cursor 的 SPEC 并更新 ACTIVE。
  用于：给 Cursor、发给 Cursor、handoff to Cursor、让 Cursor 改代码。
---

# 交接规格撰写（Cline → Cursor）

「使用 cursor-handoff-spec — 写入 Cursor 任务单。」

用户要你规划、Cursor 实现时使用。协议见同目录 lessons / spec-template / review-gates / routing / TAXONOMY。

工作流：先查 INDEX（≤3 篇）→ 写 SPEC（`executor: cursor`）→ 更新 ACTIVE → 给出 Cursor 粘贴提示。

```text
使用 skill execute-cursor-spec。读取并严格执行 .cline/handoff/ACTIVE.md（executor 必须是 cursor）。只改 allowlist，完成后请对方质量门禁。
```

审一下 → G1–G5；FAIL 出 fix pack；PASS 记 lesson。禁止写成 cline 单或擅自实现。
