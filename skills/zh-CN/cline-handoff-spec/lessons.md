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

词表见 [TAXONOMY.md](TAXONOMY.md)。

## INDEX / 正文

含 signature、kind/facet/module/layer、**git**（短 sha 或 `pending`）、style_anchor、fix_pattern、avoid 等。详见英文版 lessons.md 字段表。

## 写 SPEC 前（强制、省 token）

预算：工具 <30s，正文 ≤3 篇。分层检索：症状 → module → **facet** → kind。

命中后：

1. 读 ≤3 篇 `L-*.md`
2. **必须读相关 git**（INDEX `git` ≠ `pending` 时）：
   ```bash
   git show <sha> --stat --format='%h %s%n%an %ad' --date=short
   git show <sha> -- <style_anchor 或 lesson 中至多 1–3 个文件>
   ```
   优先 `--stat`；完整 patch 每课最多 2 个文件。聊天回报：`git-read: <shas>`
3. 规划对齐 style_anchor + 该 commit 中的写法，禁止另起冲突风格

## PASS 后必记

分类 + git + INDEX。归档无 lesson = 未完成。

## 效率

只扫 INDEX；≤3 正文；短 sha；回忆时要 `git show`；禁止全文 diff 进 SPEC。
