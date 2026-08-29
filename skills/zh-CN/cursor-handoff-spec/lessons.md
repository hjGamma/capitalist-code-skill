# Lessons 账本（廉价记忆 + 团队风格记忆）

目标：复用历史结果，**避免**每次把整库历史塞进上下文。  
对象：Cursor ↔ Cline **与** 人类队友。INDEX 一行 ≈ 一条可检索记忆；正文 ≤20 行。

## 布局

```text
.cline/handoff/lessons/
  INDEX.md
  TAXONOMY.md
  L-YYYYMMDD-<slug>.md
```

请把 `lessons/` 提交进业务仓库。打标签时优先用项目内 TAXONOMY.md。

## 分类（每条必填）

| 轴 | 字段 | 用途 | 例 |
|----|------|------|-----|
| 改动类型 | `kind` | 编辑类别 | `bugfix`, `i18n`, `style-ui` |
| 功能切面 | `facet` | **跨模块同能力**（风格迁移） | `form-char-count`, `audit-action-i18n` |
| 模块 | `module` | 限界上下文 | `probe_management` |
| 层级 | `layer` | 代码所在层 | `frontend`, `full-stack` |

词表见 [TAXONOMY.md](TAXONOMY.md)。新 facet 仅在无法复用时新增，并同步写入 TAXONOMY。

## INDEX 格式

```markdown
| id | date | status | kind | facet | module | layer | signature | git | path |
```

- **git**：短 sha，或多提交 `a1b2c3d+`，未提交则 `pending`
- **signature**：≤16 词

## 正文要点（≤20 行）

含：symptom / root_cause / fix_pattern / **style_anchor** / avoid / files / spec / **git.branch|commits|status** / gates / seen

### 采集 git

```bash
git rev-parse --abbrev-ref HEAD
git log -5 --oneline -- <相关路径>
```

未提交用 `pending`；之后「补记 git」只改该条。

## 写 SPEC 前（强制、省 token）

预算：工具 <30s，正文 ≤3 篇。分层检索：症状 → module → **facet（跨模块）** → kind。排序：facet > module > kind。

## PASS 后必记

分类 + git + INDEX 行。归档无 lesson = 未完成。

## 团队

开模块/功能前按 module/facet 扫 INDEX；PR 可引用 `L-…` / `facet=…`；有 facet lesson 时智能体应对齐 style_anchor。

## 效率硬规则

只扫 INDEX；≤3 正文；短 sha；禁止全文 diff 进 lesson。
