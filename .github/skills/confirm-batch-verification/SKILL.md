---
name: confirm-batch-verification
description: "Use when: approving a batch verification result, running /confirm-batch-verification with a BAT ID, promoting docs/batches/<BAT_ID> to release-candidate, or updating docs/batches/index.md after verification passes."
argument-hint: "예: bat-001 또는 docs/batches/bat-001_20260424_scaffold"
user-invocable: true
---

# Purpose

This skill checks whether a batch verification document has enough evidence to release the batch and, if so, promotes the batch to `release-candidate`.

# Inputs

- `BAT-ID` 또는 batch 경로
- `docs/batches/<BAT_ID>/verification.md`
- 포함된 REQ 문서들
- `docs/batches/index.md`

# Core Rules

- verification에 미해결 blocker가 있으면 승인하지 않는다.
- 포함된 REQ의 acceptance criteria가 evidence와 연결돼야 한다.
- `batch-lite`는 design 문서 없이도 승인할 수 있지만, planning의 `Design Gate`가 design 불필요를 명시하고 verification이 구조 영향 없음 또는 baseline 영향 없음을 확인해야 한다.
- 승인 성공 시 batch status는 `release-candidate`가 된다.

# Execution Procedure

1. batch와 verification 문서를 읽는다.
2. 필요하면 planning과 design을 함께 읽어 profile과 구조 영향 여부를 확인한다.
3. Acceptance Mapping, Evidence, Blocking Issues를 점검한다.
4. 승인 가능하면 verification 상태와 batch index 상태를 갱신한다.
5. 승인 불가면 상태는 유지하고 blocker를 보고한다.

# Validation

- 승인 성공인 경우 batch index 상태가 `release-candidate`인지 확인한다.
- 승인 보류인 경우 blocker가 명시됐는지 확인한다.
- `batch-lite` 승인 성공인 경우 design 부재가 검증 근거와 모순되지 않는지 확인한다.