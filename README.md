
# 사용방법

## 최초 등록

```bash
# 리모트 등록
git remote add stage-pilot https://github.com/genichin/stage-pilot.git
# subtree 추가
git fetch stage-pilot main
git subtree add --prefix=.vendor/stage-pilot stage-pilot main --squash
# 설치
bash .vendor/stage-pilot/bootstrap/install.sh .
```

## 업데이트

```bash
# 원격이 등록된 경우(stage-pilot remote 우선 사용)
bash .vendor/stage-pilot/bootstrap/update.sh .

# 충돌 파일을 보존하고 싶을 때(덮어쓰기 비활성화)
bash .vendor/stage-pilot/bootstrap/update.sh --no-overwrite .

# 원격 없이 URL로 직접 업데이트
bash .vendor/stage-pilot/bootstrap/update.sh --repo-url https://github.com/genichin/stage-pilot.git .

# 설치 재적용 없이 subtree만 갱신
bash .vendor/stage-pilot/bootstrap/update.sh --skip-install .
```

## Active 문서 루트와 Source of Truth

### 필수 루트

| 경로 | 역할 |
| --- | --- |
| `docs/discovery/index.md` | Discovery 전역 인덱스 |
| `docs/discovery/*.md` | Discovery 본문 |
| `docs/srs/index.md` | REQ 전역 인덱스와 상태 정의 |
| `docs/srs/<Type>/req-XXX_<slug>.md` | 개별 REQ 문서 |
| `docs/batches/index.md` | batch 전역 인덱스 |
| `docs/batches/<BAT_ID>/planning.md` | batch 계획 |
| `docs/batches/<BAT_ID>/design.md` | batch 설계 |
| `docs/batches/<BAT_ID>/implementation.md` | batch 구현 로그 |
| `docs/batches/<BAT_ID>/verification.md` | batch 검증 근거 |
| `docs/releases/index.md` | release 전역 인덱스 |
| `docs/releases/rel-XXX_*.md` | 개별 release 문서 |

### 4.2 명령과 템플릿 경로

| 경로 | 역할 |
| --- | --- |
| `.github/skills/` | active skill entrypoint 집합 |
| `.github/skills/run-sdlc/SKILL.md` | 현재 상태를 읽고 다음 skill을 안내하는 orchestrator |
| `.github/templates/discovery/discovery.md` | Discovery 생성 템플릿 |
| `.github/workflows/draft-discovery-on-label.yml` | issue label 기반 Discovery 자동 생성 workflow |
| `.github/scripts/create-discovery-from-issue.mjs` | Discovery 자동 생성 스크립트 |

### 4.3 비활성 경로 정책

- prompt 기반 stage command는 active flow에 포함하지 않는다.
- legacy stage template는 active source of truth가 아니다.
- active 작업은 `docs/discovery/`, `docs/srs/`, `docs/batches/`, `docs/releases/` 기준으로만 수행한다.

## 5. 단위별 상태 모델

### 5.1 Discovery 상태

| 상태 | 의미 |
| --- | --- |
| `draft` | 초안 상태이며 REQ drafting 전 |
| `confirmed` | REQ drafting으로 넘길 수 있도록 확인 완료 |

Discovery는 구현 완료 상태를 표현하는 단위가 아니다. Discovery의 역할은 문제 정의와 handoff 준비다.

### 5.2 REQ 상태

| 상태 | 의미 |
| --- | --- |
| `Proposed` | 초안 상태이며 구현 기준으로 확정되지 않음 |
| `Approved` | 구현 기준으로 승인됨 |
| `Implemented` | 구현과 검증이 완료됨 |
| `Deprecated` | 더 이상 유지하지 않음 |

### 5.3 Batch 상태

| 상태 | 의미 |
| --- | --- |
| `draft` | batch 초안만 생성된 상태 |
| `in-delivery` | planning, design, implementation, verification 중 일부가 진행 중 |
| `release-candidate` | verification 확인이 끝나 release 입력으로 사용 가능 |
| `released` | 하나 이상의 release에 포함됨 |
| `archived` | 더 이상 active delivery 단위로 사용하지 않음 |

### 5.4 Release 상태

| 상태 | 의미 |
| --- | --- |
| `draft` | release 초안 상태 |
| `confirmed` | rollout, rollback, verification 준비가 승인됨 |
| `released` | 배포 실행이 완료됨 |
| `feedback-captured` | 운영 환류까지 기록 완료 |

## 6. 기본 운영 흐름

### 6.1 Requirements Phase

1. `new-discovery`
	사용자 요청, 운영 피드백, issue 입력을 Discovery 초안으로 만든다.
2. `confirm-discovery`
	Discovery를 저장소 현실과 대조하고 REQ drafting 가능 상태로 `confirmed` 전환한다.
3. `draft-req`
	confirmed Discovery에서 승인 가능한 REQ 문서를 만든다.
4. `confirm-req`
	REQ를 `Approved`로 전환한다.
5. `suggest-batch-reqs`
	Approved REQ를 어떤 batch로 묶을지 후보를 제시한다.
6. `draft-batch`
	선택된 REQ 묶음으로 batch 폴더와 기본 문서를 생성한다.

### 6.2 Delivery Phase

1. `draft-batch-planning`
	batch 범위, 제외 범위, 의존성, 마일스톤, 리스크를 정리한다.
2. `draft-batch-design`
	batch 수준의 architecture summary, changed areas, key decisions를 정리한다.
3. `run-batch-implementation`
	실제 코드 변경을 수행하고 implementation 문서에 changed files, execution log, validation을 기록한다.
4. `draft-batch-verification`
	REQ acceptance criteria를 evidence에 연결한다.
5. `confirm-batch-verification`
	evidence가 충분하면 batch를 `release-candidate`로 전환한다.

### 6.3 Release & Feedback Phase

1. `draft-release`
	하나 이상의 `release-candidate` batch로 release 문서를 생성한다.
2. `confirm-release`
	rollout, rollback, verification checklist를 점검하고 release를 `confirmed`로 전환한다.
3. `capture-release-feedback`
	배포 후 운영 관찰 결과와 후속 Discovery/REQ 입력을 release 문서에 남긴다.

### 6.4 Orchestrator 사용 기준

`run-sdlc`는 현재 문서 상태를 읽고 다음에 실행할 skill을 1단계씩 안내하는 entrypoint다.

- Discovery 입력이면 `confirm-discovery`, `draft-req`, `suggest-batch-reqs` 중 다음 단계를 제안한다.
- REQ 입력이면 `confirm-req`, `suggest-batch-reqs`, `draft-batch` 중 다음 단계를 제안한다.
- Batch 입력이면 planning, design, implementation, verification, confirm 중 다음 단계를 제안한다.
- Release 입력이면 `confirm-release` 또는 `capture-release-feedback`를 제안한다.

## 7. Phase Gate 기준

### 7.1 Requirements 완료 기준

아래 조건을 만족해야 Delivery로 넘어간다.

- Discovery가 `confirmed` 상태다.
- 구현 대상으로 채택할 REQ가 `Approved` 상태다.
- REQ의 Acceptance Criteria가 구현 판단 가능한 수준이다.
- 사람 결정 필요 항목과 후속 backlog 항목이 분리되어 있다.

### 7.2 Delivery 완료 기준

아래 조건을 만족해야 Release & Feedback으로 넘어간다.

- batch planning, design, implementation, verification 문서가 존재한다.
- batch에 포함된 REQ acceptance criteria가 evidence와 연결된다.
- verification blocker가 해소되었다.
- batch 상태가 `release-candidate`다.

### 7.3 Release & Feedback 완료 기준

아래 조건을 만족해야 release 단위를 닫는다.

- release 계획이 `confirmed` 상태를 통과했다.
- 배포 결과가 기록되었다.
- 운영 관찰 결과가 release 문서에 남았다.
- 후속 Discovery 또는 REQ 입력이 정리되었다.

## 8. 사람 판단이 필요한 경계

다음 항목은 AI가 임의로 확정하지 않는다.

- 승인자 지정
- Owner 지정
- 정책 선택
- 우선순위 승인
- 외부 시스템 또는 외부 데이터 확인 결과
- `suggest-batch-reqs` 결과 중 어떤 후보를 실제 batch로 채택할지에 대한 선택

특히 `suggest-batch-reqs`는 추천안을 만드는 단계이며, 최종 batch 묶음은 사람 선택이 필요하다. 따라서 orchestrator는 이 경계에서 자동 진행하지 않고 멈춘다.

## 9. 자동화 규칙

### 9.1 Discovery 자동 생성

GitHub issue에 `draft-discovery` 라벨이 붙으면 아래 자동화가 동작한다.

- workflow: `.github/workflows/draft-discovery-on-label.yml`
- script: `.github/scripts/create-discovery-from-issue.mjs`
- output: `docs/discovery/<DISCOVERY_ID>.md`, `docs/discovery/index.md`

이 자동화는 아래 규칙을 따른다.

- Discovery ID는 `dcy-<3자리>_<YYYYMMDD>_<topic-slug>` 형식을 사용한다.
- 동일 issue에 대해 반복 실행해도 중복 Discovery를 만들지 않는다.
- discovery index에 문서 링크와 상태를 등록한다.
- 결과는 issue comment로 다시 보고한다.

### 9.2 Index 관리 규칙

- `docs/discovery/index.md`는 자동 생성 및 자동 갱신 결과를 포함할 수 있다.
- `docs/srs/index.md`, `docs/batches/index.md`, `docs/releases/index.md`는 각 confirm 또는 draft 단계에서 상태와 register를 함께 맞춘다.
- 상태 변경은 본문 문서와 index가 항상 함께 갱신되어야 한다.

## 10. 표준 작업 절차

### 10.1 신규 기능 또는 운영 이슈가 들어온 경우

1. issue 또는 요청 내용을 기준으로 `new-discovery`를 실행한다.
2. Discovery를 저장소 현실과 맞춰 보강한 뒤 `confirm-discovery`를 실행한다.
3. Discovery를 REQ로 쪼개고 `draft-req`를 수행한다.
4. 각 REQ를 `confirm-req`로 승인한다.
5. `suggest-batch-reqs`로 batch 후보를 받고, 사람이 묶음을 선택한다.
6. `draft-batch`로 delivery 단위를 만든다.
7. planning, design, implementation, verification을 순서대로 수행한다.
8. `confirm-batch-verification`으로 release-candidate를 만든다.
9. `draft-release`, `confirm-release`로 배포를 준비하고 실행한다.
10. `capture-release-feedback`으로 운영 환류를 남긴다.

### 10.2 이미 존재하는 문서를 이어서 처리하는 경우

1. 가장 가까운 식별자 하나를 선택한다.
2. `run-sdlc <ID>`로 현재 단위의 다음 skill을 확인한다.
3. 제안된 다음 skill을 실행한다.
4. 사람이 결정해야 하는 경계에 도달하면 그 결정만 먼저 확정한다.

## 11. Hotfix 예외 경로

긴급 핫픽스는 Requirements와 Delivery 설계를 경량화할 수 있다. 단, 아래 4가지는 생략하지 않는다.

1. 최소 요구사항 정의
	증상, 영향, 성공 조건을 기록한다.
2. 최소 검증
	재현 테스트 또는 핵심 시나리오 확인을 남긴다.
3. 배포 전 롤백 계획
	실패 시 복구 방법을 명시한다.
4. 배포 후 Postmortem
	운영 결과를 기록하고 다음 sprint 입력으로 환류한다.

## 12. 유지보수 규칙

이 메뉴얼을 수정해야 하는 경우는 아래와 같다.

- skill 이름이 바뀌는 경우
- active 문서 루트가 바뀌는 경우
- 상태 모델이 바뀌는 경우
- workflow 또는 자동 생성 경로가 바뀌는 경우
- phase gate 기준이 바뀌는 경우

위 항목이 바뀌면 아래 파일들도 함께 점검한다.

- `.github/copilot-instructions.md`
- `.github/skills/run-sdlc/SKILL.md`
- 관련 `confirm-*`, `draft-*`, `run-*`, `capture-*` skill
- `docs/discovery/index.md`
- `docs/srs/index.md`
- `docs/batches/index.md`
- `docs/releases/index.md`

## 13. 빠른 점검표

### 13.1 Requirements 진입 전

- 요청 또는 운영 이슈가 명확한가
- 기존 Discovery를 갱신할지 새로 만들지 판단했는가

### 13.2 Delivery 진입 전

- 관련 REQ가 모두 `Approved`인가
- batch 범위와 제외 범위가 정리되었는가

### 13.3 Release 진입 전

- batch가 `release-candidate`인가
- rollout plan, rollback plan, verification checklist가 준비되었는가