---
name: draft-release
description: "Use when: creating a release document from one or more release-candidate batches, running /draft-release with BAT IDs, generating docs/releases/rel-XXX_YYYYMMDD_<slug>.md, or updating docs/releases/index.md before release approval."
argument-hint: "예: bat-001 또는 bat-001 bat-002"
user-invocable: true
---

# Purpose

This skill creates a profile-aware release document from one or more verified batches and registers it in the release index.

# Inputs

- `BAT-ID` 목록
- `docs/batches/index.md`
- 각 batch의 `verification.md`
- `docs/releases/index.md`
- `.github/templates/releases/release.md`

# Core Rules

- `release-candidate`가 아닌 batch는 release에 포함하지 않는다.
- 새 release 경로는 `docs/releases/rel-XXX_YYYYMMDD_<slug>.md` 형식을 사용한다.
- release는 `docs-only`, `tooling`, `app-service` profile 중 하나를 가진다.
- release profile은 포함 batch의 운영 부담 중 가장 무거운 것을 따른다. 기본 우선순위는 `app-service` > `tooling` > `docs-only`다.
- `docs-only`는 문서, 가이드, 템플릿, 정적 산출물 변경에 사용한다.
- `tooling`은 bootstrap, 스크립트, CLI, 자동화, 패키지 동작 검증이 필요한 변경에 사용한다.
- `app-service`는 실제 서비스 배포, runtime health, 로그, 운영 확인이 필요한 변경에 사용한다.
- release 문서 생성 시 Included Batch, Profile, Scope, Rollout Plan, Rollback Plan, Verification Checklist를 채운다.

# Execution Procedure

1. 입력 batch들의 상태와 verification 결과를 확인한다.
2. 포함 batch의 변경 성격과 검증 evidence를 기준으로 release profile을 결정한다.
3. 다음 `REL-ID`를 계산하고 제목/slug를 정한다.
4. 템플릿 기반으로 release 문서를 생성한다.
5. `docs/releases/index.md`에 register 행을 추가한다.

# Validation

- 포함 batch가 모두 `release-candidate`인지 확인한다.
- release 문서에 `Profile`이 있고 profile별 검증 항목이 비어 있지 않은지 확인한다.
- release 문서와 index register 행이 함께 생성됐는지 확인한다.