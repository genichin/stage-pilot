---
name: run-sdlc
description: "Use when: orchestrating the next SDLC action from the current 3-phase state, running /run-sdlc with a Discovery, REQ, Batch, or Release ID, resuming from the first incomplete unit in docs/discovery, docs/srs, docs/batches, or docs/releases, or guiding the user to the next skill-only step."
argument-hint: "예: dcy-001, bat-001, rel-001, req-001 req-002"
user-invocable: true
---

# Purpose

This skill inspects the current state of Discovery, REQ, Batch, and Release documents and routes work to the next skill-only step in the 3-phase SDLC model.

# Inputs

- `DISCOVERY_ID`
- `REQ-ID` 목록
- `BAT-ID`
- `REL-ID`
- 관련 문서 경로

# Core Rules

- 이 skill은 `docs/discovery/`, `docs/srs/`, `docs/batches/`, `docs/releases/`만 active 경로로 사용한다.
- prompt 기반 stage command는 사용하지 않는다.
- `review-*` 단계는 별도 명령으로 두지 않고 대응 `confirm-*` 절차에 흡수된 상태를 전제로 한다.
- 사람 선택이 필요한 경계에서는 자동으로 넘기지 않고 중단한다. 대표적으로 `suggest-batch-reqs` 결과에서 어떤 후보를 채택할지 결정하는 단계가 그렇다.

# Execution Procedure

## 1. 입력 해석

- 입력이 `dcy-`로 시작하면 Discovery를 기준으로 현재 상태를 확인한다.
- 입력이 `req-` 목록이면 REQ 상태를 읽고 batch 생성 또는 추천 단계로 보낸다.
- 입력이 `bat-`로 시작하면 batch delivery 상태를 확인한다.
- 입력이 `rel-`로 시작하면 release 상태를 확인한다.

## 2. Discovery 기준 routing

- Discovery가 아직 `confirmed`가 아니면 `confirm-discovery`를 우선 실행한다.
- Discovery는 confirmed지만 연결된 REQ가 없으면 `draft-req`를 다음 단계로 사용한다.
- Approved REQ는 있으나 batch가 없으면 `suggest-batch-reqs`를 실행해 후보를 제시하고, 사용자가 후보를 선택한 뒤 `draft-batch`로 이어 가도록 멈춘다.

## 3. REQ 기준 routing

- `Proposed` REQ면 `confirm-req`를 다음 단계로 사용한다.
- Approved REQ 묶음이면 `suggest-batch-reqs` 또는 `draft-batch`로 이어진다.

## 4. Batch 기준 routing

- `planning.md`가 비어 있거나 draft 수준이면 `draft-batch-planning`
- 설계가 비어 있거나 blocker가 있으면 `draft-batch-design`
- 구현 로그와 코드 변경이 아직 없으면 `run-batch-implementation`
- verification 문서가 없거나 불완전하면 `draft-batch-verification`
- verification evidence가 있지만 release-candidate가 아니면 `confirm-batch-verification`

## 5. Release 기준 routing

- release 문서가 draft면 `confirm-release`
- release가 confirmed 이후 운영 관찰이 남아 있지 않으면 `capture-release-feedback`

# Output Expectations

- 입력으로 해석한 단위 종류
- 현재 상태 요약
- 바로 실행할 다음 skill 1개 또는 추천 후보 목록
- 자동으로 진행하지 않고 멈춘 이유가 있으면 그 사유

# Validation

- 다음 단계가 현재 문서 상태와 모순되지 않는지 확인한다.
- 제안한 다음 skill이 실제 `.github/skills/` 아래 존재하는지 확인한다.