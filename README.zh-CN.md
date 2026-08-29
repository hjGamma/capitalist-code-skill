# capitalist-code-skill

**Capitalist Code Skill** — [Cursor](https://cursor.com) 与 [Cline](https://docs.cline.bot/customization/skills) 双向交接，外加**分类 lessons 账本**，用尽量少的 token 保持智能体与团队代码风格一致。

> English: [README.md](README.md)  
> 作者：[hjGamma](https://github.com/hjGamma)

## 作用是什么

| 能力 | 说明 |
|------|------|
| **方案 → 规格** | 一方写出可执行 PRD/SPEC（`.cline/handoff/specs/`） |
| **规格 → 改代码** | 另一方只改 Allowlist 内文件 |
| **质量门禁** | G1–G5：名单 / 验收 / 回归 / 风格 / 最小改动 |
| **修订单** | 门禁失败 → 具体 fix SPEC + 粘贴提示词 |
| **Lessons 账本** | PASS 后记录 kind/facet/module/layer + **git sha**，便于检索 |

```text
Cursor ──cline-handoff-spec──▶ SPEC(executor:cline) ──execute-cline-spec──▶ Cline
Cline  ──cursor-handoff-spec──▶ SPEC(executor:cursor) ──execute-cursor-spec──▶ Cursor
                                      │
                                      ▼
                         同伴复审 G1–G5 → lessons/（含 git）
```

## 包含的 Skill

| Skill | 安装位置 | 职责 |
|-------|----------|------|
| `cline-handoff-spec` | `~/.cursor/skills/` | Cursor 给 Cline 写单 + 复审/账本协议 |
| `execute-cursor-spec` | `~/.cursor/skills/` | Cursor 执行 cursor 单 |
| `cursor-handoff-spec` | `~/.cline/skills/` | Cline 给 Cursor 写单 |
| `execute-cline-spec` | `~/.cline/skills/` | Cline 执行 cline 单 |

中英双版目录：`skills/en/`、`skills/zh-CN/`。

## 快速安装

```bash
git clone https://github.com/hjGamma/capitalist-code-skill.git
cd capitalist-code-skill
./install.sh zh-CN     # 或: ./install.sh en
```

Cline：设置 → Features → **Enable Skills**。

## 日常怎么用

### Cursor → Cline

1. 在 Cursor 说需求 +「给 Cline / handoff」。
2. Cursor 走 `cline-handoff-spec`（先查 lessons → 写 SPEC + ACTIVE）。
3. 粘贴到 Cline：

```text
使用 skill execute-cline-spec。读取并严格执行 .cline/handoff/ACTIVE.md（executor 必须是 cline）。
```

4. 做完后对 Cursor 说「审一下」→ 门禁 → 记 lesson（含 git 或 `pending`）。

### Cline → Cursor

1. 对 Cline 说「给 Cursor」→ `cursor-handoff-spec`。
2. 粘贴到 Cursor 用 `execute-cursor-spec`。
3. 同样复审 + 记账。

### Lessons（团队 + 智能体）

业务仓库内建议提交：

```text
.cline/handoff/lessons/
  INDEX.md
  TAXONOMY.md
  L-*.md
```

- 同类 bug → 搜 signature  
- 同模块 → 滤 `module`  
- **不同模块同一功能类型** → 滤 `facet`  
- 对齐风格 → 看 `style_anchor`，必要时 `git show <sha>`  

未提交：`git: pending`，提交后说「补记 git」。

## 设计原则

- **省 token**：只扫 INDEX，每任务 ≤3 篇正文  
- **沙箱**：硬 Allowlist，禁止顺手重构  
- **双受众**：智能体协作 + 团队维护同一账本  
- **不放水**：风格/误伤/非最小必须 FAIL  

## 仓库结构

```text
capitalist-code-skill/
  README.md / README.zh-CN.md
  install.sh
  skills/en/ …
  skills/zh-CN/ …
```

## License

MIT — 见 [LICENSE](LICENSE)。
