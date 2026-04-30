---
name: draft-batch
description: "Use when: creating a new batch from approved REQ IDs, running /draft-batch with one or more req IDs, scaffolding docs/batches/<BAT_ID>/ files, or updating docs/batches/index.md for a new delivery unit."
argument-hint: "예: req-001 req-002 req-003"
user-invocable: true
---

# Purpose

This skill creates a new batch delivery unit from approved requirements, chooses the right delivery profile, scaffolds its folder and documents, and updates the batch register.

# Inputs

- Approved `REQ-ID` 목록
- 선택 입력
  - batch profile 힌트 (`standard` | `batch-lite` | `minor-change`)
- `docs/srs/index.md`
- 대상 REQ 문서들
- `docs/batches/index.md`
- `.github/templates/batches/` 아래 템플릿

# Core Rules

- `Approved` 상태가 아닌 REQ는 batch에 포함하지 않는다.
- 새 batch 폴더는 `docs/batches/bat-XXX_YYYYMMDD_scope/` 형식을 사용한다.
- 새 batch는 `standard` 또는 `batch-lite` profile 중 하나를 가진다.
- 입력이 정확히 1개의 `Approved` REQ이고 범위가 국소적이며 구조/인터페이스/런타임 흐름 변경이 없으면 `minor-change` fast path를 사용할 수 있다. 이 경우 결과 batch profile은 `batch-lite`로 기록한다.
- `standard` batch는 생성 시 아래 파일을 함께 만든다.
  - `index.md`
  - `planning.md`
  - `design.md`
  - `implementation.md`
  - `verification.md`
- `batch-lite`는 생성 시 아래 파일만 먼저 만든다.
  - `index.md`
  - `planning.md`
- `batch-lite`의 `implementation.md`와 `verification.md`는 해당 단계 진입 시 생성한다.
- `batch-lite`라도 구조/인터페이스/흐름 영향이 생기면 `design.md`를 추가하고 사실상 standard depth로 다룬다.
- `docs/batches/index.md`의 register를 함께 갱신하며, 가능하면 profile도 함께 기록한다.

# Execution Procedure

1. 입력된 REQ 경로와 상태를 확인한다.
2. REQ 수, 영향 범위, 구조/인터페이스/런타임 영향 여부를 기준으로 `standard` 또는 `batch-lite` profile을 결정한다.
3. 배치 제목과 slug를 결정하고 다음 `BAT-ID`를 계산한다.
4. 템플릿 기반으로 batch 폴더와 profile에 맞는 문서를 생성한다.
5. `index.md`에 `Profile`, 포함 REQ, source discovery, 공통 범위를 채운다.
6. `planning.md`에 `Design Gate`를 기록해 design이 즉시 필요한지 여부를 남긴다.
7. `docs/batches/index.md`에 새 register 행을 추가한다.

# Validation

- 포함 REQ가 모두 `Approved`인지 확인한다.
- `standard`면 5개 문서가 모두 생성되었는지 확인한다.
- `batch-lite`면 `index.md`, `planning.md`가 생성되었고 `Profile: batch-lite`가 기록되었는지 확인한다.
- `docs/batches/index.md`에 새 batch 행이 추가되었는지 확인한다.