---
name: draft-batch-verification
description: "Use when: drafting verification evidence for a batch, running /draft-batch-verification with a BAT ID, filling docs/batches/<BAT_ID>/verification.md, or mapping REQ acceptance criteria to evidence before release approval."
argument-hint: "예: bat-001 또는 docs/batches/bat-001_20260424_scaffold"
user-invocable: true
---

# Purpose

This skill drafts the verification document for a batch by mapping included REQ acceptance criteria to available evidence and identifying remaining blockers.

# Inputs

- `BAT-ID` 또는 batch 경로
- 포함된 REQ 문서들
- `docs/batches/<BAT_ID>/implementation.md`
- `docs/batches/<BAT_ID>/verification.md`

# Core Rules

- verification은 Discovery 성공 기준이 아니라 REQ acceptance criteria에 직접 연결한다.
- evidence가 없는 항목은 통과로 간주하지 않는다.
- 확인되지 않은 항목은 `Blocking Issues`에 명시한다.

# Execution Procedure

1. batch와 포함 REQ를 확정한다.
2. REQ acceptance criteria를 목록화한다.
3. implementation 결과와 테스트 로그를 근거로 evidence를 연결한다.
4. `verification.md`의 Acceptance Mapping, Evidence, Result를 채운다.

# Validation

- 포함 REQ마다 acceptance mapping이 존재하는지 확인한다.
- evidence 없는 항목이 있으면 Result에 blocker로 반영했는지 확인한다.