---
name: draft-release
description: "Use when: creating a release document from one or more release-candidate batches, running /draft-release with BAT IDs, generating docs/releases/rel-XXX_YYYYMMDD_<slug>.md, or updating docs/releases/index.md before release approval."
argument-hint: "예: bat-001 또는 bat-001 bat-002"
user-invocable: true
---

# Purpose

This skill creates a release document from one or more verified batches and registers it in the release index.

# Inputs

- `BAT-ID` 목록
- `docs/batches/index.md`
- 각 batch의 `verification.md`
- `docs/releases/index.md`
- `.github/templates/releases/release.md`

# Core Rules

- `release-candidate`가 아닌 batch는 release에 포함하지 않는다.
- 새 release 경로는 `docs/releases/rel-XXX_YYYYMMDD_<slug>.md` 형식을 사용한다.
- release 문서 생성 시 Included Batch, Scope, Rollout Plan, Rollback Plan, Verification Checklist를 채운다.

# Execution Procedure

1. 입력 batch들의 상태와 verification 결과를 확인한다.
2. 다음 `REL-ID`를 계산하고 제목/slug를 정한다.
3. 템플릿 기반으로 release 문서를 생성한다.
4. `docs/releases/index.md`에 register 행을 추가한다.

# Validation

- 포함 batch가 모두 `release-candidate`인지 확인한다.
- release 문서와 index register 행이 함께 생성됐는지 확인한다.