---
name: run-batch-implementation
description: "Use when: implementing a confirmed batch design, running /run-batch-implementation with a BAT ID, applying code changes for docs/batches/<BAT_ID>, or updating implementation logs and validation evidence for a batch."
argument-hint: "예: bat-001 또는 docs/batches/bat-001_20260424_scaffold"
user-invocable: true
---

# Purpose

This skill executes the implementation work for a batch, updates code, and records the changed files, execution log, validation, and remaining risks in the batch implementation document.

# Inputs

- `BAT-ID` 또는 batch 경로
- `docs/batches/<BAT_ID>/planning.md`
- `docs/batches/<BAT_ID>/design.md`
- `docs/batches/<BAT_ID>/implementation.md`
- 관련 REQ 문서와 실제 코드 경로

# Core Rules

- planning과 design이 없는 batch는 구현하지 않는다.
- 코드 변경 전 `implementation.md`의 Plan Summary와 Changed Files 초안을 먼저 맞춘다.
- 구현 직후 가장 좁은 테스트, lint, typecheck, 또는 동작 검증을 수행한다.
- blocker가 생기면 문서에 남기고 범위를 임의 확장하지 않는다.

# Execution Procedure

1. batch 경로, plan, design, 관련 REQ를 읽는다.
2. 구현 범위와 변경 파일 후보를 요약한다.
3. 실제 코드 변경을 수행한다.
4. `implementation.md`의 Changed Files, Execution Log, Validation, Remaining Risks를 갱신한다.
5. batch index 상태를 필요하면 `in-delivery`로 유지 또는 보정한다.

# Validation

- `implementation.md`에 실제 변경 파일과 검증 기록이 반영됐는지 확인한다.
- 구현 직후 수행한 가장 좁은 검증 명령 또는 결과가 문서에 남았는지 확인한다.