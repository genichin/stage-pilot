# 플레이스홀더 가이드

이 파일은 active workspace 기준으로 `.github/templates/`와 `.github/skills/`에서 사용하는 플레이스홀더의 문법과 처리 원칙을 정의한다.

기본 전제는 아래와 같다.

- active SDLC 진입점은 skill-only 체계다.
- `.github/prompts/`는 active 기준 문서가 아니다.
- active 산출물 경로는 `docs/discovery/`, `docs/srs/`, `docs/batches/`, `docs/releases/`다.

## 1. 문법 규칙

| 형식 | 의미 | 예시 |
| --- | --- | --- |
| `{{KEY}}` | 단순 치환 대상 | `{{DISCOVERY_ID}}` |
| `{{KEY:hint}}` | 힌트 포함 치환 대상 | `{{CONFIRMED_AT_KST:TBD}}` |
| `{{KEY:opt1\|opt2}}` | 열거형 선택 값 | `{{DOC_STATUS:draft\|confirmed}}` |

규칙:

- 최종 문서에는 `{{...}}` 문법이 남지 않아야 한다.
- 힌트 텍스트는 치환 시 함께 제거한다.
- 사람 승인 없이는 확정할 수 없는 값은 본문에 무리하게 확정하지 말고 Notes 또는 결정 필요 항목으로 남긴다.

## 2. 처리 주체

플레이스홀더는 아래 세 가지 처리 주체 중 하나에 속한다.

### A. 자동 치환

- ID, 생성 시각, 갱신 시각, 상태 기본값처럼 실행 시점에 자동으로 정해지는 값
- 예:
  - `{{DISCOVERY_ID}}`
  - `{{CONFIRMED_AT_KST}}`
  - `{{BAT_ID}}`
  - `{{REL_ID}}`

### B. AI 근거 기반 치환

- 현재 저장소 상태, 상위 문서, 이미 확정된 값으로 채울 수 있는 항목
- 예:
  - Discovery의 현재 상태 요약
  - REQ의 Impacted Area 초안
  - Batch planning의 dependency 정리
  - Release rollout checklist 초안

### C. 사람 결정 필요

- 정책 선택, 승인자 지정, 우선순위 확정, 외부 환경 정보처럼 사람 판단이 필요한 값
- 이런 항목은 무리하게 확정하지 않는다.

## 3. 경로별 플레이스홀더 원칙

### 3.1 Discovery 템플릿

대상 경로:

- `.github/templates/discovery/discovery.md`
- `docs/discovery/*.md`

주요 키:

- `{{DISCOVERY_ID}}`
- `{{ISSUE_NAME}}`
- `{{CREATED_AT_KST}}`
- `{{UPDATED_AT_KST}}`
- `{{FREEZE_HANDOFF_DECISION}}`
- `{{READY_FOR_REQ_DRAFTING}}`
- `{{CONFIRMED_BY}}`
- `{{CONFIRMED_AT_KST}}`

처리 원칙:

- Discovery는 REQ 초안 작성으로 넘길 수 있을 때만 freeze handoff를 완료한다.
- Discovery 문서의 용어는 `Planning` 직결이 아니라 `REQ Drafting` 기준으로 유지한다.

### 3.2 SRS 템플릿

대상 경로:

- `docs/srs/req-template.md`
- `docs/srs/index.md`

주요 키:

- `REQ-XXX`
- `Status`
- `Type`
- `Priority`
- `Owner`

처리 원칙:

- REQ는 `Proposed -> Approved -> Implemented -> Deprecated` 상태를 따른다.
- `draft-req`는 초안을 만들고, `confirm-req`는 승인 전환을 담당한다.

### 3.3 Batch 템플릿

대상 경로:

- `.github/templates/batches/*`
- `docs/batches/*`

주요 키:

- `{{BAT_ID}}`
- Included REQ 목록
- Source Discovery

처리 원칙:

- batch는 Approved REQ만 포함한다.
- planning, design, implementation, verification 문서는 같은 batch 폴더 아래에서 관리한다.
- `confirm-batch-verification` 성공 전에는 `release-candidate`로 올리지 않는다.

### 3.4 Release 템플릿

대상 경로:

- `.github/templates/releases/*`
- `docs/releases/*`

주요 키:

- `{{REL_ID}}`
- Included Batch
- Rollout Plan
- Rollback Plan

처리 원칙:

- release는 `release-candidate` batch만 포함한다.
- `confirm-release`는 release 승인, `capture-release-feedback`는 운영 환류 기록을 담당한다.

## 4. Active Skill Summary

| 목적 | Skill | 주요 입력 | 주요 출력 |
| --- | --- | --- | --- |
| Discovery 초안 생성 | `.github/skills/new-discovery/SKILL.md` | 이슈/요청 요약 | `docs/discovery/*.md` |
| Discovery 확정 | `.github/skills/confirm-discovery/SKILL.md` | `DISCOVERY_ID` | confirmed Discovery |
| REQ 초안 생성 | `.github/skills/draft-req/SKILL.md` | `DISCOVERY_ID` | `docs/srs/<Type>/req-*.md` |
| REQ 확정 | `.github/skills/confirm-req/SKILL.md` | `REQ-ID` | Approved REQ |
| Batch 추천 | `.github/skills/suggest-batch-reqs/SKILL.md` | `DISCOVERY_ID` 또는 REQ 목록 | batch 후보안 |
| Batch 생성 | `.github/skills/draft-batch/SKILL.md` | Approved REQ 목록 | `docs/batches/<BAT_ID>/` |
| Delivery 진행 | `.github/skills/draft-batch-planning/SKILL.md`, `.github/skills/draft-batch-design/SKILL.md`, `.github/skills/run-batch-implementation/SKILL.md`, `.github/skills/draft-batch-verification/SKILL.md`, `.github/skills/confirm-batch-verification/SKILL.md` | `BAT-ID` | batch 문서와 상태 |
| Release 진행 | `.github/skills/draft-release/SKILL.md`, `.github/skills/confirm-release/SKILL.md`, `.github/skills/capture-release-feedback/SKILL.md` | `BAT-ID` 또는 `REL-ID` | release 문서와 운영 환류 |
| 상위 orchestration | `.github/skills/run-sdlc/SKILL.md` | Discovery/REQ/Batch/Release 식별자 | 다음 skill 라우팅 |

## 5. 금지 사항

- active 설명 문서에서 `.github/prompts/`를 기준 경로로 안내하지 않는다.
- `review-*`를 별도 active 단계로 서술하지 않는다.
- `docs/sdlc/`를 신규 active 산출물 경로로 사용하지 않는다.