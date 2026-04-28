---
name: confirm-req
description: "Use when: reviewing a proposed REQ for approval, running /confirm-req with a REQ ID or file path, running /confirm-req without arguments to review all unapproved REQs, promoting docs/srs/<Type>/req-XXX_<slug>.md from Proposed to Approved, updating docs/srs/index.md after approval, or when the user asks in Korean to '요구 사항 명세를 검토하고 승인해줘', '요구사항 명세를 검토하고 승인해줘', 'REQ를 검토하고 승인해줘', or '승인되지 않은 전체 req를 검토하고 승인해줘'."
argument-hint: "예: req-001 또는 docs/srs/Interface/req-001_picker-cli-run.md 또는 인자 없이 /confirm-req"
user-invocable: true
---

# Purpose

This skill validates a proposed requirement document and promotes it to `Approved` only when it is ready to be used as delivery input.

# When to use

- `/confirm-req req-001`처럼 REQ 승인 게이트를 통과시켜야 할 때
- `/confirm-req`처럼 입력 없이 승인되지 않은 전체 REQ를 일괄 검토하고 승인 가능한 항목만 승격해야 할 때
- REQ 문서의 필수 필드와 Acceptance Criteria 충족 여부를 다시 확인해야 할 때
- `docs/srs/index.md` 상태를 REQ 문서와 맞춰야 할 때

# Inputs

- 선택 입력: REQ 식별자
  - `req-001` 같은 prefix
  - 전체 REQ 파일 경로
- 입력이 없으면 `docs/srs/**/req-*.md` 전체를 스캔해 승인되지 않은 REQ를 대상으로 삼는다.
- 대상 REQ 문서 또는 대상 REQ 문서 목록
- `docs/srs/index.md`

# Core Rules

## 1. 입력 해석

- prefix 입력이면 `docs/srs/**/req-001_*.md` 형식으로 찾는다.
- 입력이 없으면 `docs/srs/` 아래에서 `req-template.md`를 제외한 모든 `req-*.md`를 찾고, 그중 `Status: Proposed`인 문서를 승인 후보로 삼는다.
- 후보가 0개면 진행하지 않는다.
- 후보가 여러 개면 임의 선택하지 않는다.
- 입력이 없는 일괄 모드에서는 여러 후보가 정상이며, 각 후보를 개별 승인 게이트로 평가한다.

## 2. 승인 게이트

- 아래 항목이 모두 있어야 승인 가능하다.
  - `Status`, `Type`, `Priority`, `Owner`
  - `Intent`
  - `Requirement`
  - 구체적인 `Acceptance Criteria`
  - `Impacted Area`
  - `Change Log`
- 미해결 placeholder, 사람 결정 필요 메모, blocker가 남아 있으면 승인하지 않는다.
- `Status`가 이미 `Approved`, `Implemented`, `Deprecated`이면 중복 승인하지 않는다.
- 일괄 모드에서는 승인 불가한 문서가 있더라도 전체 실행을 중단하지 않는다. 승인 가능한 문서만 승격하고, 나머지는 blocker와 함께 별도 보고한다.

## 3. 허용되는 수정

- AI가 근거 있게 바로 고칠 수 있는 표현, 오타, 누락 제목 정리는 보강할 수 있다.
- 승인 성공 시 아래 변경을 수행한다.
  - REQ 문서의 `Status`를 `Approved`로 변경
  - `Change Log`에 승인 기록 추가
  - `docs/srs/index.md`의 해당 Register 행 상태 갱신
  - 필요하면 `Recent Change Log Summary` 갱신
- 사람 판단이 필요한 우선순위, 범위, Owner는 임의로 확정하지 않는다.
- 일괄 모드에서도 허용되는 수정 범위는 동일하며, 승인 불가 문서의 상태는 바꾸지 않는다.

# Execution Procedure

1. 입력에서 대상 REQ 경로 하나 또는 대상 REQ 문서 목록을 확정한다.
2. 입력이 없는 경우 `docs/srs/**/req-*.md`를 스캔해 `Status: Proposed` 문서를 승인 후보 목록으로 만든다.
3. 대상 REQ들와 `docs/srs/index.md`를 읽는다.
4. 각 REQ마다 필수 필드, Acceptance Criteria, Notes의 blocker 여부를 확인한다.
5. AI가 근거 있게 정리할 수 있는 사소한 일관성 문제를 먼저 고친다.
6. 각 REQ에 대해 승인 게이트를 다시 평가한다.
7. 게이트 통과한 REQ만 `Approved`로 전환하고 인덱스를 갱신한다.
8. 게이트 미통과한 REQ는 상태를 유지하고 남은 blocker를 수집한다.
9. 입력이 없는 경우 승인 성공 목록과 승인 불가 목록을 분리해 함께 보고한다.

# Output Expectations

- 단일 입력 모드:
  - 대상 REQ 경로
  - 승인 성공 여부
  - 자동 보강한 항목 목록
  - 남은 blocker 또는 미해결 항목
  - `docs/srs/index.md` 갱신 결과
- 무인자 일괄 모드:
  - 검토한 REQ 전체 목록
  - 승인 성공한 REQ 목록
  - 승인 불가한 REQ 목록과 각 blocker
  - 자동 보강한 항목 목록
  - `docs/srs/index.md` 갱신 결과

# Validation

- 승인 성공인 경우 REQ 문서와 index 상태가 모두 `Approved`인지 확인한다.
- 승인 보류인 경우 상태가 잘못 바뀌지 않았는지 확인한다.
- 무인자 일괄 모드에서는 승인 성공한 REQ만 상태가 바뀌고, 승인 불가한 REQ는 기존 상태가 유지되는지 확인한다.