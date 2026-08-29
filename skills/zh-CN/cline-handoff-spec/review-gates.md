# 质量门禁与修订单

执行方完成后由同伴复审。证据来自 `git diff`。见 [routing.md](routing.md)。

## ACTIVE.md

须含 `executor: cline | cursor`、`status`、`spec`、`author`。fix pack 继承同一 executor。

## 复审步骤

1. 读 ACTIVE → SPEC  
2. `git status` + `git diff`  
3. 打分 G1–G5（每项 PASS/FAIL + 证据）  
4. 全 PASS → `done` + 记 lesson（分类 + git + style_anchor）  
5. 任一 FAIL → 写 fix pack，更新 ACTIVE，**并在聊天中给出可直接粘贴给执行方 AI 的提示词**（含分条「修改建议」）

### G1–G5

G1 Allowlist · G2 Acceptance · G3 Regression · G4 Style · G5 Minimal  

## FAIL 时必须输出的粘贴提示词

聊天回复中给出一个 `text` 代码块（按 executor 选 skill），模板：

```text
使用 skill execute-cline-spec。读取并严格执行 .cline/handoff/ACTIVE.md（fix pack：.cline/handoff/specs/SPEC-…-fix-N.md）。

修改建议（按顺序做，不要扩大范围）：
1) Revert/remove：<具体文件与符号/hunk>
2) 最小补丁：<怎么改；对齐哪个 style_anchor / git sha>
3) Verify：<命令或手工>
4) 只改 allowlist；不要 commit；完成后请对方重新质量门禁。
```

`executor: cursor` 时把 skill 换成 `execute-cursor-spec`。G4/G5 失败时必须点名 style_anchor 和/或 lesson 的 git sha。

## Fix pack 正文

先「Revert / remove」，再「Required edits」。复审对**完整剩余 diff**再跑 G1–G5。
