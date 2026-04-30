---
name: draft-batch-verification
description: "Use when: drafting verification evidence for a batch, running /draft-batch-verification with a BAT ID, filling docs/batches/<BAT_ID>/verification.md, mapping REQ acceptance criteria to evidence before release approval, or verifying sync with docs/project-structure.md and docs/runtime-flows.md."
argument-hint: "예: bat-001 또는 docs/batches/bat-001_20260424_scaffold"
user-invocable: true
---

# Purpose

This skill drafts the verification document for a batch by mapping included REQ acceptance criteria to available evidence and identifying remaining blockers.

batch design 또는 REQ가 baseline 문서 생성/갱신 또는 구조/흐름 영향이 있음을 나타내면, verification은 `docs/project-structure.md`와 `docs/runtime-flows.md`가 코드와 설계에 맞게 동기화되었는지도 확인해야 한다.

# Inputs

- `BAT-ID` 또는 batch 경로
- 포함된 REQ 문서들
- `docs/batches/<BAT_ID>/design.md` (존재하는 경우)
- `docs/batches/<BAT_ID>/planning.md`
- `docs/batches/<BAT_ID>/implementation.md`
- `docs/batches/<BAT_ID>/verification.md`
- `docs/project-structure.md` (존재하는 경우)
- `docs/runtime-flows.md` (존재하는 경우)

# Core Rules

- verification은 Discovery 성공 기준이 아니라 REQ acceptance criteria에 직접 연결한다.
- evidence가 없는 항목은 통과로 간주하지 않는다.
- 확인되지 않은 항목은 `Blocking Issues`에 명시한다.
- `batch-lite`에서 design 문서가 없다면 planning의 `Design Gate`와 implementation 결과를 기준으로 구조 영향이 실제로 없었는지 확인해야 한다.
- design의 Architecture Impact가 `none`이 아니거나 baseline 문서 생성/갱신이 batch 범위에 있으면, baseline 문서 동기화 evidence를 verification에 포함해야 한다.
- baseline 문서 동기화가 필요한데 evidence가 없으면 release-ready로 간주하지 않는다.

# Execution Procedure

1. batch와 포함 REQ를 확정한다.
2. REQ acceptance criteria를 목록화한다.
3. design 문서가 있으면 Architecture Impact와 Reference Doc Update Plan을 읽고, 없으면 planning의 `Design Gate`를 읽는다.
4. implementation 결과와 테스트 로그를 근거로 evidence를 연결한다.
5. baseline 문서 동기화가 필요하면 `docs/project-structure.md`와 `docs/runtime-flows.md`의 생성/갱신 여부를 evidence에 포함한다.
6. `batch-lite`에서 design이 없었다면 verification에 `no architecture impact confirmed` 여부를 남긴다.
7. `verification.md`의 Acceptance Mapping, Evidence, Result를 채운다.

# Validation

- 포함 REQ마다 acceptance mapping이 존재하는지 확인한다.
- evidence 없는 항목이 있으면 Result에 blocker로 반영했는지 확인한다.
- Architecture Impact가 있는 batch라면 baseline 문서 동기화 evidence 또는 blocker가 명시됐는지 확인한다.
- `batch-lite`에서 design이 없는 경우 planning과 implementation을 기준으로 구조 영향 없음 또는 design 누락 blocker 중 하나가 명시됐는지 확인한다.