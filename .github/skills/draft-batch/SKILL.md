---
name: draft-batch
description: "Use when: creating a new batch from approved REQ IDs, running /draft-batch with one or more req IDs, scaffolding docs/batches/<BAT_ID>/ files, or updating docs/batches/index.md for a new delivery unit."
argument-hint: "예: req-001 req-002 req-003"
user-invocable: true
---

# Purpose

This skill creates a new batch delivery unit from approved requirements, scaffolds its folder and documents, and updates the batch register.

# Inputs

- Approved `REQ-ID` 목록
- `docs/srs/index.md`
- 대상 REQ 문서들
- `docs/batches/index.md`
- `.github/templates/batches/` 아래 템플릿

# Core Rules

- `Approved` 상태가 아닌 REQ는 batch에 포함하지 않는다.
- 새 batch 폴더는 `docs/batches/bat-XXX_YYYYMMDD_scope/` 형식을 사용한다.
- 생성 시 아래 파일을 함께 만든다.
  - `index.md`
  - `planning.md`
  - `design.md`
  - `implementation.md`
  - `verification.md`
- `docs/batches/index.md`의 register를 함께 갱신한다.

# Execution Procedure

1. 입력된 REQ 경로와 상태를 확인한다.
2. 배치 제목과 slug를 결정하고 다음 `BAT-ID`를 계산한다.
3. 템플릿 기반으로 batch 폴더와 문서를 생성한다.
4. `index.md`에 포함 REQ, source discovery, 공통 범위를 채운다.
5. `docs/batches/index.md`에 새 register 행을 추가한다.

# Validation

- 포함 REQ가 모두 `Approved`인지 확인한다.
- batch 폴더와 5개 문서가 모두 생성되었는지 확인한다.
- `docs/batches/index.md`에 새 batch 행이 추가되었는지 확인한다.