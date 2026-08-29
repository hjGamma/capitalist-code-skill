# 智能体交接路由（Cursor ↔ Cline）

同一队列：`.cline/handoff/`。方向由 **executor** 决定。

| 作者 | executor | 写单 skill | 执行 skill |
|------|----------|------------|------------|
| Cursor | `cline` | `cline-handoff-spec` | `execute-cline-spec` |
| Cline | `cursor` | `cursor-handoff-spec` | `execute-cursor-spec` |

复审：非执行方跑 G1–G5。Fix pack 保持父单同一 executor。  
Lessons：共享 `.cline/handoff/lessons/`；仅门禁 PASS 后记录。
