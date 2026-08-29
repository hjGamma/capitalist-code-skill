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

INDEX 含 `kind|facet|module|layer|signature|git|path`。正文含 style_anchor、git.branch/commits/status。未提交用 `pending`。

## 写 SPEC 前（强制、省 token）

1. rg INDEX（症状 / module / **facet** / kind），取 ≤3 条。  
2. 读对应 `L-*.md`。  
3. **若 git ≠ pending：必须读相关提交**  
   ```bash
   git show <sha> --stat --format='%h %s%n%an %ad' --date=short
   git show <sha> -- <style_anchor 或 lesson 中 1–3 个文件>
   ```  
   优先 `--stat`；全文 patch 每课最多 2 个文件。规划中写清「来自 `<sha>` 的模式」。  
4. SPEC `## Lessons applied` 引用 id + git sha。聊天汇报：`lessons: N hits; git-read: …`

## PASS 后必记

分类 + git + INDEX。归档无 lesson = 未完成。

## FAIL

不写正式 lesson；等最终 PASS。门禁失败时由复审方给出**可粘贴 AI 提示词**（含分条修改建议）。

## 效率

只扫 INDEX；≤3 正文；读命中 sha；禁止整库 diff 进 SPEC。
