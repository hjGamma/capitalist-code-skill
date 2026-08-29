# 质量门禁与修订单

执行方完成后由同伴复审。证据来自 `git diff`。见 [routing.md](routing.md)。

## ACTIVE.md

须含 `executor: cline | cursor`、`status`、`spec`、`author`。fix pack 继承同一 executor。

## 复审步骤

1. 读 ACTIVE → SPEC  
2. `git status` + `git diff`  
3. 打分 G1–G5（每项 PASS/FAIL + 1–3 条证据）  
4. 全 PASS → `done` + 按 [lessons.md](lessons.md) 记 lesson（分类 + git + style_anchor）  
5. 任一 FAIL → 写 fix pack，ACTIVE 指向之，给出执行方粘贴提示  

### G1 Allowlist — 名单外即 FAIL  
### G2 Acceptance — 验收未满足即 FAIL  
### G3 Regression — 共享 API/默认值/双 locale 等误伤  
### G4 Style — 与同文件惯例冲突  
### G5 Minimal — 顺手重构 / 可用更小补丁  

## Fix pack

先「Revert / remove」，再「Required edits」。粘贴提示按 executor 选择 `execute-cline-spec` 或 `execute-cursor-spec`。
