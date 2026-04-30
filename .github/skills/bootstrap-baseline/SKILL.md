---
name: bootstrap-baseline
description: "Use when: initializing StagePilot in a project before the first real Discovery, running /bootstrap-baseline to create baseline documents and active indexes, or backfilling missing docs/project-structure.md and docs/runtime-flows.md without creating a Discovery unit."
argument-hint: "예: 신규 저장소 baseline 초기화, StagePilot init, baseline 문서/인덱스 생성"
user-invocable: true
---

# Purpose

This skill initializes the StagePilot baseline outside the normal Discovery -> REQ -> Batch -> Release flow.

`docs/project-structure.md`, `docs/runtime-flows.md`, 그리고 active index 문서는 첫 real Discovery 전에 준비하는 bootstrap 산출물이다. 이 skill은 baseline과 index를 먼저 만들고, 첫 Discovery가 실제 제품/서비스 변경 주제로 시작되도록 만든다.

# When to use

다음 상황에서 사용한다.

- StagePilot을 새 프로젝트에 처음 적용한 직후 baseline 문서와 index를 만들 때
- `/bootstrap-baseline` 또는 유사한 init 요청으로 baseline 초기화를 수행할 때
- `docs/project-structure.md`, `docs/runtime-flows.md`, `docs/discovery/index.md`, `docs/srs/index.md`, `docs/batches/index.md`, `docs/releases/index.md` 중 일부가 없어서 SDLC를 시작하기 전에 뼈대를 복구해야 할 때
- 첫 real Discovery를 기능, 운영 문제, 기술 결정 같은 실제 변경 주제로 시작하고 싶을 때

다음 상황에는 이 skill을 기본 경로로 사용하지 않는다.

- 이미 진행 중인 Discovery/REQ/Batch/Release가 있고, baseline 변경 책임이 특정 active unit에 속하는 경우
- 실제 제품/서비스 변경 주제가 이미 명확하여 Discovery 초안 생성이 우선인 경우

# Inputs

이 skill은 아래 입력을 사용한다.

- 현재 저장소 루트와 디렉터리 구조
- `docs/discovery/`, `docs/srs/`, `docs/batches/`, `docs/releases/` 존재 여부
- `docs/project-structure.md`, `docs/runtime-flows.md` 존재 여부
- 템플릿 파일
	- `.github/templates/discovery/index.md`
	- `.github/templates/srs/index.md`
	- `.github/templates/batches/index.md`
	- `.github/templates/releases/index.md`
	- `.github/templates/project-structure.md`
	- `.github/templates/runtime-flows.md`
- 현재 시각 (KST)

# Core Rules

## 0. 단위 경계

- `bootstrap-baseline`은 Discovery, REQ, Batch, Release 중 어느 것도 아니다.
- 이 skill은 초기 운영 기준선을 만드는 bootstrap 단계다.
- 이 skill은 Discovery 문서를 생성하지 않는다.
- baseline 초기화가 끝난 뒤 첫 real Discovery는 실제 제품/서비스 변경, 운영 이슈, 기술 결정 같은 주제로 시작한다.

## 1. 생성 대상

- 아래 경로가 없으면 생성한다.
	- `docs/discovery/index.md`
	- `docs/srs/index.md`
	- `docs/batches/index.md`
	- `docs/releases/index.md`
	- `docs/project-structure.md`
	- `docs/runtime-flows.md`
- 이미 존재하는 파일은 임의로 덮어쓰지 않는다.
- 일부만 없는 경우에는 누락된 파일만 생성한다.

## 2. baseline 문서 작성 원칙

- `docs/project-structure.md`는 현재 저장소의 top-level 구조, 주요 패키지/모듈 책임, 의존 경계, 현재 구조 gap을 기준으로 초안을 채운다.
- `docs/runtime-flows.md`는 현재 저장소의 대표 entry point, 실행 흐름, 공용 컴포넌트, 흐름 제약을 기준으로 초안을 채운다.
- 입력만으로 알 수 없는 항목은 의미 있는 플레이스홀더로 남기되, 추론 가능한 구조 정보는 실제 문장으로 채운다.
- baseline 문서의 `Source Discovery / Batch`는 bootstrap 산출물임을 드러내는 값으로 채운다.

## 3. index 작성 원칙

- index 문서는 템플릿을 기반으로 생성한다.
- 초기화 시점에는 register 본문만 만들고 실제 Discovery/REQ/Batch/Release 항목은 비워 둔다.
- index 생성은 active unit 생성으로 간주하지 않는다.

## 4. 진행 중 unit가 있는 경우

- 진행 중인 Discovery/REQ/Batch/Release가 이미 있고 baseline 문서만 일부 비어 있다면, 먼저 현재 active unit가 그 변경을 소유해야 하는지 판정한다.
- 특정 active unit의 요구사항이나 설계/검증 근거로 baseline 변경이 필요한 경우에는 그 unit 안에서 처리한다.
- 단순 bootstrap 누락 복구이고 active unit 책임이 아니라면 `bootstrap-baseline`으로 누락 파일만 보강할 수 있다.

# Execution Procedure

1. 저장소에서 active docs 루트와 baseline 파일 존재 여부를 확인한다.
2. 누락된 디렉터리가 있으면 `docs/discovery`, `docs/srs`, `docs/batches`, `docs/releases`를 먼저 준비한다.
3. 누락된 index 파일을 각 템플릿으로 생성한다.
4. 누락된 baseline 파일이 있으면 현재 저장소 상태를 반영해 `docs/project-structure.md`와 `docs/runtime-flows.md`를 생성한다.
5. 이미 존재하는 파일은 보존하고, 필요한 경우에만 누락 복구 사실을 결과에 기록한다.
6. 완료 후 다음 단계로 `new-discovery`를 사용해 첫 real Discovery를 시작하도록 안내한다.

# Output Expectations

- 생성 또는 복구한 파일 목록
- baseline 문서 상태 (`created` | `preserved` | `missing-information`)
- index 문서 상태 (`created` | `preserved`)
- 첫 real Discovery에서 다뤄야 할 주제 후보 또는 다음 action

# Validation

- 생성한 파일 경로가 active docs 구조와 일치하는지 확인한다.
- baseline 문서와 index에 남아 있는 플레이스홀더가 정말 사람 결정이 필요한 값인지 점검한다.
- Discovery 문서를 생성하지 않았는지 확인한다.