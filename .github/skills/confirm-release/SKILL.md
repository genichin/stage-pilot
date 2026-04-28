---
name: confirm-release
description: "Use when: approving a release plan, running /confirm-release with a REL ID or release path, promoting docs/releases/rel-XXX_*.md from draft to confirmed, or validating rollout and rollback readiness before deployment."
argument-hint: "예: rel-001 또는 docs/releases/rel-001_20260424_scaffold.md"
user-invocable: true
---

# Purpose

This skill validates a release document and promotes it to `confirmed` only when rollout, rollback, and verification checks are ready.

# Inputs

- `REL-ID` 또는 release 경로
- 대상 release 문서
- `docs/releases/index.md`
- 포함 batch 문서들

# Core Rules

- Included Batch가 모두 release-candidate여야 한다.
- Rollout Plan, Rollback Plan, Verification Checklist가 비어 있으면 승인하지 않는다.
- 승인 성공 시 release 상태를 `confirmed`로 바꾸고 index를 갱신한다.

# Execution Procedure

1. release 문서와 포함 batch 상태를 확인한다.
2. rollout, rollback, verification 준비도를 점검한다.
3. 게이트 통과 시 release 상태와 index를 `confirmed`로 갱신한다.
4. 미통과 시 상태는 유지하고 blocker를 보고한다.

# Validation

- 승인 성공인 경우 release 문서와 index 상태가 모두 `confirmed`인지 확인한다.
- 승인 보류인 경우 누락 항목이 명시됐는지 확인한다.