# Lessons 分类词表（受控）

谨慎扩展；新增时同步改本文件。

## kind

| id | 何时用 |
|----|--------|
| `bugfix` | 修错误行为 |
| `feature` | 新能力 |
| `i18n` | 文案 / locale 对齐 |
| `style-ui` | 布局与控件呈现 |
| `test` | 仅测试 |
| `audit` | 审计写入/展示 |
| `api` | 边界契约 |
| `config` | 配置 |
| `docs` | 仅文档 |

## facet（跨模块风格迁移键）

| id | 含义 |
|----|------|
| `audit-action-i18n` | action_code → `logs.action` 键 |
| `audit-client-ip` | 补齐 `AuditContext.client_ip` |
| `audit-resource-i18n` | resourceType / detail 文案 |
| `form-char-count` | 输入框字数统计位置 |
| `locale-key-parity` | 中英文键集合一致 |
| `drawer-form` | 抽屉表单 |
| `list-filter` | 列表筛选工具栏 |
| `error-code-domain` | domain error_code |
| `acl-audit-bridge` | 审计 ACL 接线 |
| `handler-audit-record` | handler 记审计 + FakeAuditAcl |

## module / layer

module：限界上下文名。layer：`frontend` | `backend` | `full-stack` | `docs` | `test`。
