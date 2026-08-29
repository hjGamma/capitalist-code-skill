---
name: execute-cursor-spec
description: >-
  严格执行 executor 为 cursor 的交接 SPEC（含 fix pack）。用于：执行 handoff、
  execute-cursor-spec、跑 ACTIVE、执行 Cline 方案、Cursor 执行任务。若 executor
  为 cline，停止并改用 execute-cline-spec。
---

# 执行 Cursor 交接规格

## 开场

「使用 execute-cursor-spec — 从 `.cline/handoff/` 加载任务。」

## 定位

优先用户路径，否则 `ACTIVE.md`；缺失则请先跑 `cursor-handoff-spec`。

## 预检

通读 SPEC；`executor` 必须是 `cursor`；status `ready`/`in_progress`；ACTIVE `in_progress`；Allowlist 沙箱；默认不 commit。

## Fix pack

先撤销不合格改动，再最小补丁；勿复现 G3/G4/G5。

## 执行

只改规格要求；勾选进度；Verify；本地风格；最小 hunk。受阻 → `blocked`。

## 完成

验收、文件列表、命令结果；ACTIVE → `ready` 待同伴门禁。勿自称最终 PASS / 写 lesson。

## 禁止

执行 cline 单；名单外修改；首轮自封门禁通过；未授权 commit/push。
