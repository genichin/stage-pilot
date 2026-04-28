---
name: draft-req
description: "Use when: turning a confirmed Discovery into one or more REQ documents, running /draft-req with a dcy-id or Discovery path, creating docs/srs/<Type>/req-XXX_<slug>.md files, or updating docs/srs/index.md from FR/NFR input."
argument-hint: "예: dcy-001 또는 docs/discovery/dcy-001_20260424_krx-stock-picker-python-scaffold.md"
user-invocable: true
---

# Purpose

This skill converts a Discovery document into one or more requirement documents under `docs/srs/`, updates the SRS register, and writes the generated REQ references back to the source Discovery document.

# When to use

- `/draft-req dcy-001`처럼 Discovery를 REQ backlog로 정규화해야 할 때
- Discovery의 FR/NFR을 구현 가능한 requirement 문서로 분리해야 할 때
- `docs/srs/index.md`의 register와 Next Requirement ID를 함께 갱신해야 할 때

# Inputs

- Discovery 식별자
  - `dcy-001` 같은 prefix
  - 전체 Discovery ID
  - `docs/discovery/<DISCOVERY_ID>.md` 경로
- 대상 Discovery 문서 본문
- `docs/srs/index.md`
- `docs/srs/req-template.md`

# Core Rules

## 1. 입력 해석

- 입력이 prefix면 `docs/discovery/` 아래에서 일치하는 문서를 찾는다.
- 여러 후보가 나오면 임의 선택하지 않고 사용자 확인이 필요하다고 보고한다.
- `.vendor/` 경로는 탐색 대상에서 제외한다.

## 2. REQ 분해 원칙

- FR은 기본적으로 독립 구현과 독립 검증 가능 단위로 REQ 후보를 만든다.
- 하나의 FR이 과도하게 크면 복수 REQ로 분해한다.
- NFR은 독립 측정 가능성, 독립 backlog 가치, 운영 영향도가 충분할 때만 별도 REQ로 승격한다.
- 특정 FR 또는 batch 검증 기준에 흡수하는 편이 적절한 NFR은 별도 REQ를 만들지 말고 Notes에 연결 근거를 남긴다.

## 3. Type 및 경로 규칙

- 아래 폴더 중 정확히 하나를 선택한다.
  - `Configuration`
  - `Data`
  - `Deployment`
  - `Documentation`
  - `Exception`
  - `Installation`
  - `Integration`
  - `Interface`
  - `Non-Functional`
  - `Testing`
- 새 REQ 경로는 `docs/srs/<Type>/req-XXX_<slug>.md` 형식을 사용한다.
- `REQ-XXX` 번호는 `docs/srs/index.md`의 `Next Requirement ID`를 source of truth로 사용한다.

## 4. 문서 작성 규칙

- `docs/srs/req-template.md`를 기준으로 문서를 만든다.
- `Status` 기본값은 `Proposed`다.
- `Intent`, `Requirement`, `Acceptance Criteria`, `Impacted Area`, `Notes`를 실제 문장으로 채운다.
- 사람 승인 없이는 확정할 수 없는 항목은 비워 두지 말고 `Notes`에 결정 필요 또는 가정으로 명시한다.
- Change Log는 최초 생성 기록을 남긴다.

## 5. 인덱스 갱신 규칙

- REQ를 하나 이상 생성하면 `docs/srs/index.md`의 아래 항목을 함께 갱신한다.
  - `Next Requirement ID`
  - `Requirement Register`
  - `Recent Change Log Summary`
- Register에는 ID, Title, Type, Status, Priority, Owner, Link를 추가한다.

## 6. Source Discovery 역참조 갱신 규칙

- REQ를 하나 이상 생성하면 source Discovery 문서의 `# 0. 문서 상태`에도 어떤 REQ가 생성됐는지 기록해야 한다.
- Discovery 문서에 `생성된 REQ 참조` 항목이 이미 있으면 생성된 REQ 목록으로 갱신하고, 없으면 `후속 Discovery 참조` 바로 아래에 추가한다.
- `생성된 REQ 참조`는 생성된 REQ 번호 순서대로 유지하고 중복을 허용하지 않는다.
- source Discovery 문서를 갱신했다면 `마지막 갱신 시각(KST)`도 함께 갱신한다.
- 생성된 REQ가 아직 없으면 `생성된 REQ 참조: 없음`을 유지한다.

# Execution Procedure

1. 입력에서 Discovery 경로를 확정한다.
2. Discovery 문서에서 FR/NFR, 범위 경계, 리스크, 성공 기준을 읽는다.
3. FR/NFR별 REQ 후보 목록을 만든다.
4. 각 후보에 대해 Type, 제목, slug, Acceptance Criteria를 결정한다.
5. `docs/srs/index.md`의 다음 번호부터 순서대로 REQ 파일을 생성한다.
6. `docs/srs/index.md`를 갱신한다.
7. source Discovery 문서의 `생성된 REQ 참조`와 `마지막 갱신 시각(KST)`를 갱신한다.
8. 생성 결과와 제외한 NFR이 있으면 그 이유를 함께 보고한다.

# Output Expectations

- 생성된 REQ 파일 목록
- 각 REQ의 Type과 핵심 의도
- `docs/srs/index.md` 갱신 결과
- source Discovery 문서의 `생성된 REQ 참조` 갱신 결과
- 별도 REQ로 승격하지 않은 NFR 목록과 처리 이유

# Validation

- 모든 REQ 경로가 `docs/srs/<Type>/req-XXX_<slug>.md` 형식을 만족하는지 확인한다.
- 생성된 REQ 수와 `Requirement Register` 행 수가 일치하는지 확인한다.
- `Next Requirement ID`가 마지막 생성 번호보다 정확히 1 큰지 확인한다.