---
name: execute-cline-spec
description: >-
  严格执行 executor 为 cline 的交接 SPEC（含 fix pack）。用于：执行 handoff、
  execute-cline-spec、跑 ACTIVE、按 spec 改代码、修订单。若 executor 为 cursor，
  停止并让用户改用 execute-cursor-spec。
---

# 执行 Cline 交接规格

## 开场

「使用 execute-cline-spec — 从 `.cline/handoff/` 加载任务。」

## 定位

1. 优先用户给出的路径。
2. 否则读 `ACTIVE.md` 的 `spec:`。
3. 缺失则请对方先跑 `cline-handoff-spec`。

## 预检

1. 通读 SPEC。
2. `executor` 必须是 `cline`；若是 `cursor` → **停止**。
3. status 为 `ready` / `in_progress`。
4. ACTIVE → `in_progress`；硬 Allowlist；默认不 commit/push。

## Fix pack

先 Revert/remove，再 Required edits；勿复现 G3/G4/G5 问题；完成后请对方复审，勿自称最终 PASS。

## 执行

只做规格要求；勾选步骤；跑 Verify；贴合本地风格；最小 diff。受阻 → `blocked`，勿擅自扩名单。

## 完成

验收对照、文件列表、命令结果；ACTIVE 置 `ready` 待复审。勿自行 `done` / 写 lesson。

## 禁止

执行 cursor 单；名单外修改；删测试凑绿；声称门禁通过；用本 skill 写给 Cursor 的单。
