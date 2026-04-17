---
name: "draft-planning"
description: "Create a 2_planning.md draft from a confirmed Discovery document"
argument-hint: "예: sdlc-001 또는 docs/sdlc/sdlc-001_20260417_stage-pilot/1_discovery.md"
agent: "agent"
---
확정된 Discovery 문서를 기반으로 Planning 초안(`2_planning.md`)을 생성한다.

목표:
- `docs/sdlc/<CYCLE_ID>/2_planning.md`를 생성한다.
- `1_discovery.md`의 확정 내용(FR/NFR, 범위, 성공 기준, 리스크)을 Planning 초안의 입력으로 사용한다.
- 추론 가능한 항목은 초안 문장으로 채우고, 사용자 결정이 필요한 항목만 플레이스홀더로 남긴다.

---

## 실행 절차

### 1. 입력 해석

- 사용자가 CYCLE_ID(예: `sdlc-001`)를 제공했으면 `docs/sdlc/` 아래에서 해당 패턴으로 시작하는 폴더를 찾아 `1_discovery.md` 경로를 확정한다.
- 사용자가 파일 경로를 직접 제공했으면 해당 경로의 상위 폴더에서 `1_discovery.md`를 찾는다.
- 파일이 없으면 사용자에게 피드백하고 중단한다.

### 2. Discovery 인계 조건 확인

`1_discovery.md`에서 아래 조건을 확인한다. 미충족 시 중단하고 이유를 보고한다.

| 항목 | 기준 |
|------|------|
| 문서 상태 | `confirmed`여야 한다 |
| Ready for Planning | `true`여야 한다 |
| 2_planning.md 존재 여부 | 이미 존재하면 덮어쓰기 의사를 확인하고, 의사 표현이 없으면 중단한다 |

### 3. Discovery 내용 추출

`1_discovery.md`에서 아래 항목을 읽어 Planning 초안 작성에 사용한다.

- 이슈명 (`# 0`의 `이슈명:`)
- 문서 ID / CYCLE_ID
- In Scope / Out of Scope (`# 5`)
- FR 전체 목록 (`# 5`)
- NFR 전체 목록 (`# 5`)
- 성공 기준 S-1~S-N (`# 7`)
- 리스크 R-1~R-N 및 완화 방안 (`# 6`)
- Deferred 처리된 오픈 질문 (`# 6`)
- 가정 A-1~A-N (`# 6`)

### 4. Planning 초안 작성 원칙

- 입력 요청과 Discovery 내용을 바탕으로 합리적으로 추론 가능한 항목은 자연어 문장으로 채운다.
- 아래 항목은 추론 불가 또는 사용자 확인 필요이므로 플레이스홀더로 남긴다.
  - 태스크 담당자 (`{{TASK_OWNER_N:TBD}}`)
  - 마일스톤 목표 날짜 (`{{MILESTONE_N_DATE:TBD}}`)
  - 이터레이션 기간 (`{{ITERATION_N_PERIOD:TBD}}`)
  - Freeze 확정 담당자 (`{{CONFIRMED_BY:TBD}}`)
- 공수 추정은 유사 작업 기준 또는 태스크 복잡도 기반으로 초안 값을 제안한다. 불확실하면 범위(예: `2-4 SP`)로 표기한다.
- 태스크는 각 FR 1개당 최소 1개를 생성하되, 구현/검토/문서화를 묶거나 분리하는 것이 합리적이면 그렇게 한다.

### 5. 자동으로 채워야 하는 항목

| 항목 | 채움 방법 |
|------|---------|
| `# 0` 메타데이터 | 현재 시각, CYCLE_ID, 이슈명, Discovery 경로를 자동 입력 |
| `# 1` Discovery 인계 요약 | Discovery `# 5` 범위/FR/NFR 내용 요약 이식 |
| `# 1` 이월 오픈 질문 | Discovery `# 6`의 `Deferred` 항목 이식 |
| `# 2` 태스크 분해 | FR/NFR 기반으로 최소 2개 이상의 태스크 생성 |
| `# 2` 태스크 DoD | 각 태스크의 완료 조건을 FR 내용 기반으로 초안 작성 |
| `# 3` 공수 추정 | 각 태스크에 초안 공수값 또는 범위 제안 |
| `# 4` 마일스톤 | 태스크 그룹 기반으로 최소 1개 이상 초안 작성 |
| `# 5` 의존성 | 태스크 간 의존 관계를 분석해 초안 작성 |
| `# 6` 검증 계획 | Discovery 성공 기준(S-N)과 연결해 검증 방법 초안 작성 |
| `# 7` 리스크 | Discovery 이월 리스크 중 Planning 관련 항목 포함 및 신규 Planning 리스크 추가 |
| `# 9` 파일 처리 결과 | 생성 결과와 참조 문서 경로 채움 |
| `# 10` 사용자 결정 필요 | 담당자 지정, 일정 확정, 예산/환경 제약 등 사용자 결정 필요 항목 정리 |
| `# 11` Freeze 플래그 | `Handoff Decision: 보류`, `Ready for Design: false` 초기값 입력 |

### 6. 파일 생성

- 경로: `docs/sdlc/<CYCLE_ID>/2_planning.md`
- 기반: `.github/templates/sdlc/2_planning.md`를 구조 기준으로 사용하되, 위 작성 원칙에 따라 채운 초안을 생성한다.

### 7. 결과 보고

응답에 아래 내용을 포함한다.

- **생성 결과**: 파일 경로
- **채워진 항목 요약**: 자동 추론으로 채운 주요 내용 목록
- **사용자 결정 필요 항목**: `# 10`에 정리된 항목 요약
- **다음 단계 안내**: Planning 검토 후 `/confirm-planning <CYCLE_ID>` 실행 안내

---

## 중요 규칙

- Discovery가 `confirmed` 상태가 아니면 초안을 생성하지 않는다.
- 이미 `2_planning.md`가 존재하는 경우 사용자 명시 없이 덮어쓰지 않는다.
- 추론 불가 항목은 `TBD` 대신 의미 있는 플레이스홀더(`{{TASK_OWNER_1:TBD}}` 등)로 남긴다.
- 공수 추정 초안은 반드시 근거(유사 사례, 복잡도 판단 등)와 함께 `# 3`에 명시한다.
- 현재 시각은 시스템 또는 컨텍스트에서 제공된 날짜/시간을 사용한다.
