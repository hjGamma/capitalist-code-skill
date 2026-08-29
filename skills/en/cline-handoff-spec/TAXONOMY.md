# Lessons taxonomy (controlled vocabulary)

Extend sparingly. When adding a value, append here in the same PR/lesson update.

## kind (change class) — pick 1, or 2 if inseparable

| id | Use when |
|----|----------|
| `bugfix` | Correct wrong behavior |
| `feature` | New capability |
| `i18n` | Locale keys / copy / locale parity |
| `style-ui` | Layout, Ant Design usage, visual placement (e.g. char count) |
| `test` | Tests only |
| `audit` | Audit ACL / entries / display of audit fields |
| `api` | REST/WS contract or handlers at boundary |
| `config` | Config / feature flags |
| `docs` | Docs/YAML truth only |

## facet (cross-module capability type) — style transfer key

Reuse these so “不同模块同一功能类型” hits the same rows:

| id | Meaning |
|----|---------|
| `audit-action-i18n` | `logs.action` keys from action_code (`A.B.C` → `A_B_C`) |
| `audit-client-ip` | Fill `AuditContext.client_ip` / login IP column |
| `audit-resource-i18n` | resourceType / detail locale keys |
| `form-char-count` | Input/textarea show-count placement |
| `locale-key-parity` | zh/en key set must match |
| `drawer-form` | Create/edit drawer form patterns |
| `list-filter` | List page filter / toolbar |
| `error-code-domain` | Domain error_code without prose |
| `acl-audit-bridge` | Audit ACL wiring in application handlers |
| `handler-audit-record` | `_record_*_audit` / FakeAuditAcl test patterns |

Add new facet only if none of the above fits; name: lowercase kebab, capability-oriented (not ticket id).

## module (bounded context / area)

Examples: `audit`, `probe_management`, `scan-orchestration`, `scan-policy`, `iam`, `workgroup`, `license_management`, `vulnerability-knowledge`, `vulnerability-governance`, `network-topology`, `platform-configuration`, `shared-i18n`, `frontend-shared`.

Use repo folder / context name; stay stable.

## layer

`frontend` | `backend` | `full-stack` | `docs` | `test`
