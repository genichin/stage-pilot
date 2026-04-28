---
name: suggest-batch-reqs
description: "Use when: recommending delivery batch groupings from approved requirements, running /suggest-batch-reqs with a Discovery ID or REQ list, assessing cohesion and delivery risk, or preparing input for /draft-batch without changing repository state."
argument-hint: "예: dcy-001 또는 req-001 req-002 req-003"
user-invocable: true
---

# Purpose

This skill recommends one or more candidate batch groupings from approved requirements and reports rationale, exclusions, risk, and confidence without modifying any files. 입력이 없으면 현재 저장소에서 아직 delivery 입력으로 소모되지 않은 Approved REQ를 찾아 이번 batch 후보를 추천한다.

# When to use

- Approved REQ가 여러 개 쌓여 어떤 묶음으로 delivery를 시작할지 추천이 필요할 때
- `/suggest-batch-reqs dcy-001` 또는 `/suggest-batch-reqs req-001 req-002`처럼 batch 후보안을 받아야 할 때
- `/suggest-batch-reqs`처럼 인자 없이 현재 저장소의 Approved REQ 중 아직 구현 완료 또는 기존 batch 편성이 끝나지 않은 후보만 추려 이번 batch 권장안을 보고 싶을 때
- `draft-batch` 실행 전에 포함/제외 REQ 근거를 미리 보고 싶을 때

# Inputs

- 선택 입력
  - `DISCOVERY_ID` 또는 Approved `REQ-ID` 목록
  - 입력이 없으면 `docs/srs/**/req-*.md`와 `docs/srs/index.md`를 읽어 Approved REQ를 찾는다.
  - 입력이 없으면 `docs/batches/index.md`도 함께 읽어 이미 batch에 편성된 REQ를 제외한다.
- 선택 입력
  - batch 최대 크기
  - Type, Priority, Owner 필터
  - 제외할 REQ 목록
  - 강제로 함께 고려할 REQ 목록

# Core Rules

- 이 skill은 추천만 수행하고 저장소 상태를 바꾸지 않는다.
- `Approved`가 아닌 REQ는 후보에서 제외한다.
- 입력이 없는 경우 `Implemented` 상태 REQ는 후보에서 제외한다.
- 입력이 없는 경우 `docs/batches/index.md` 기준으로 `draft`, `in-delivery`, `release-candidate`, `released` batch에 이미 포함된 REQ는 중복 추천하지 않는다.
- 아래 조건을 많이 만족할수록 같은 batch 후보로 묶는다.
  - 같은 사용자 가치 또는 기능 흐름
  - 같은 모듈, 인터페이스, 런타임 경로
  - 같은 설계 전제와 환경 가정
  - 같은 iteration 안에서 구현과 검증 가능
  - acceptance criteria를 함께 검증하는 것이 효율적임
  - release 시 함께 배포해도 위험이 과도하지 않음
- 아래 조건이 있으면 같은 batch로 묶지 않는다.
  - 핵심 설계 전제 충돌
  - 완전히 다른 verification 흐름 필요
  - 독립 배포가 필요한 고위험 변경
  - 미해결 정책 결정이나 외부 의존성으로 planning이 불안정함

# Execution Procedure

1. 입력이 Discovery면 연결된 REQ 후보를 찾고, 입력이 REQ 목록이면 각 REQ 문서를 읽는다.
2. 입력이 없으면 `docs/srs/**/req-*.md`, `docs/srs/index.md`, `docs/batches/index.md`를 읽어 Approved REQ 전체를 찾고, `Implemented` 상태 또는 기존 batch에 이미 포함된 REQ를 제외해 현재 후보군을 만든다.
3. 각 REQ의 상태, Type, Impacted Area, Acceptance Criteria를 요약한다.
4. 후보군에서 Approved REQ만 추린 뒤 응집도와 delivery risk 기준으로 후보안을 1개 이상 만든다.
5. 각 후보에 대해 포함 REQ, 제외 REQ와 제외 이유, 추천 근거, 위험도, 신뢰도를 정리한다.
6. 바로 사용할 수 있는 `/draft-batch ...` 입력 예시를 제시한다.

# Output Expectations

- 후보 `BAT-CANDIDATE-N` 목록
- 입력이 없는 경우 스캔한 Approved REQ 목록
- 후보별 포함 REQ
- 후보별 제외 REQ와 제외 이유
- 후보별 추천 근거
- 후보별 위험도 (`Low|Medium|High`)
- 후보별 신뢰도 (`High|Medium|Low`)
- `draft-batch` 추천 명령 예시

# Validation

- 출력에 `Approved`가 아닌 REQ가 포함되지 않았는지 확인한다.
- 입력이 없는 경우 `Implemented` 상태 REQ와 기존 batch에 이미 포함된 REQ가 후보에 남아 있지 않은지 확인한다.
- 추천안이 2개 이상일 때는 최소 1개는 작은 묶음 또는 보수적 대안을 포함한다.
- 적절한 묶음이 없으면 `단일 REQ batch 권장`을 명시한다.