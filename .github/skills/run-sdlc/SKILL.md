---
name: run-sdlc
description: "Use when: orchestrating the next SDLC action from the current 3-phase state, running /run-sdlc with a Discovery, REQ, Batch, or Release ID, resuming from the first incomplete unit in docs/discovery, docs/srs, docs/batches, or docs/releases, or guiding the user to the next skill-only step while checking docs/project-structure.md and docs/runtime-flows.md as baseline references."
argument-hint: "예: dcy-001, bat-001, rel-001, req-001 req-002"
user-invocable: true
---

# Purpose

This skill inspects the current state of Discovery, REQ, Batch, and Release documents and routes work to the next skill-only step in the 3-phase SDLC model.

`docs/project-structure.md`와 `docs/runtime-flows.md`는 별도 governance unit는 아니지만, 이 skill은 다음 단계를 추천할 때 해당 baseline 문서의 존재 여부와 갱신 필요 여부를 함께 확인한다.

# Inputs

- `DISCOVERY_ID`
- `REQ-ID` 목록
- `BAT-ID`
- `REL-ID`
- 관련 문서 경로
- `docs/project-structure.md` (존재하는 경우)
- `docs/runtime-flows.md` (존재하는 경우)

# Core Rules

- 이 skill은 `docs/discovery/`, `docs/srs/`, `docs/batches/`, `docs/releases/`만 active 경로로 사용한다.
- `docs/project-structure.md`와 `docs/runtime-flows.md`는 active routing 대상은 아니지만, 모든 단계에서 참고할 cross-cutting baseline 문서로 취급한다.
- prompt 기반 stage command는 사용하지 않는다.
- `review-*` 단계는 별도 명령으로 두지 않고 대응 `confirm-*` 절차에 흡수된 상태를 전제로 한다.
- 사람 선택이 필요한 경계에서는 자동으로 넘기지 않고 중단한다. 대표적으로 `suggest-batch-reqs` 결과에서 어떤 후보를 채택할지 결정하는 단계가 그렇다.
- baseline 문서가 아직 없고 저장소가 첫 반복 단계라면, 첫 Discovery는 baseline 문서 생성 범위를 포함해야 한다.

# Execution Procedure

## 1. 입력 해석

- 입력이 `dcy-`로 시작하면 Discovery를 기준으로 현재 상태를 확인한다.
- 입력이 `req-` 목록이면 REQ 상태를 읽고 batch 생성 또는 추천 단계로 보낸다.
- 입력이 `bat-`로 시작하면 batch delivery 상태를 확인한다.
- 입력이 `rel-`로 시작하면 release 상태를 확인한다.
- 어떤 입력이든 가능하면 `docs/project-structure.md`와 `docs/runtime-flows.md` 존재 여부를 함께 확인한다.

## 2. Discovery 기준 routing

- Discovery가 아직 `confirmed`가 아니면 `confirm-discovery`를 우선 실행한다.
- Discovery는 confirmed지만 연결된 REQ가 없으면 `draft-req`를 다음 단계로 사용한다.
- Approved REQ는 있으나 batch가 없으면 `suggest-batch-reqs`를 실행해 후보를 제시하고, 사용자가 후보를 선택한 뒤 `draft-batch`로 이어 가도록 멈춘다.
- 첫 Discovery이거나 baseline 문서가 없는 상태라면, 상태 요약에 `docs/project-structure.md`와 `docs/runtime-flows.md` 생성/정비 필요 여부를 함께 기록한다.

## 3. REQ 기준 routing

- `Proposed` REQ면 `confirm-req`를 다음 단계로 사용한다.
- Approved REQ 묶음이면 `suggest-batch-reqs` 또는 `draft-batch`로 이어진다.
- baseline 문서 생성 또는 갱신이 REQ에 포함돼 있으면 상태 요약에 이를 반영한다.

## 4. Batch 기준 routing

- `planning.md`가 비어 있거나 draft 수준이면 `draft-batch-planning`
- 설계가 비어 있거나 blocker가 있으면 `draft-batch-design`
- 구현 로그와 코드 변경이 아직 없으면 `run-batch-implementation`
- verification 문서가 없거나 불완전하면 `draft-batch-verification`
- verification evidence가 있지만 release-candidate가 아니면 `confirm-batch-verification`
- batch design 또는 verification에 structure/flow 영향이 보이면 baseline 문서 갱신 필요 여부를 상태 요약에 포함한다.

## 5. Release 기준 routing

- release 문서가 draft면 `confirm-release`
- release가 confirmed 이후 운영 관찰이 남아 있지 않으면 `capture-release-feedback`

# Output Expectations

- 입력으로 해석한 단위 종류
- 현재 상태 요약
- baseline 문서 상태 (`present` | `missing` | `update-likely-required`)
- 바로 실행할 다음 skill 1개 또는 추천 후보 목록
- 자동으로 진행하지 않고 멈춘 이유가 있으면 그 사유

# Validation

- 다음 단계가 현재 문서 상태와 모순되지 않는지 확인한다.
- 제안한 다음 skill이 실제 `.github/skills/` 아래 존재하는지 확인한다.
- baseline 문서가 필요한 상황에서 상태 요약 또는 추천 사유에 그 정보가 누락되지 않았는지 확인한다.