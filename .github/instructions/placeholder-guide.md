# 플레이스홀더 가이드

이 파일은 `.github/templates/` 및 `.github/prompts/`에서 사용하는 `{{...}}` 플레이스홀더의 문법, 처리 주체, 전체 목록을 정의한다.
템플릿을 수정하거나 새 프롬프트를 작성할 때 이 파일을 기준으로 한다.

---

## 1. 문법 규칙

| 형식 | 의미 | 예시 |
|---|---|---|
| `{{KEY}}` | 단순 치환 대상. 힌트 없음. | `{{CYCLE_ID}}` |
| `{{KEY:hint}}` | 힌트 포함. 치환 시 힌트 텍스트도 함께 제거. | `{{CREATED_AT_KST:TBD}}` |
| `{{KEY:opt1\|opt2\|opt3}}` | 열거형. 나열된 값 중 하나를 선택. | `{{DOC_STATUS:draft\|review\|confirmed}}` |
| `{{KEY_N_DECISION:hint}}` | AI agent가 섹션 본문에 임시로 삽입하는 판단 대기 마커. `review-discovery` 등 검토 단계에서 실제 문장으로 치환하거나 `#10`으로 이동. | `{{TARGET_STATE_2_DECISION:...}}` |

> **규칙**: 플레이스홀더를 채울 때는 `{{...}}` 전체를 값으로 교체한다. 힌트나 파이프(`|`) 열거는 최종 문서에 남기지 않는다.

---

## 2. 처리 주체 분류

플레이스홀더는 **누가 채워야 하는가**에 따라 세 가지로 나뉜다.

### A. 자동 치환 (Auto — 프롬프트 실행 시 agent가 즉시 채움)

| 키 | 치환 값 | 사용 위치 |
|---|---|---|
| `{{DOC_STATUS}}` / `{{DOC_STATUS:draft\|review\|confirmed}}` | `draft` | 모든 SDLC 문서 `#0` |
| `{{CYCLE_ID}}` / `{{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}` | 계산된 주기 ID | 모든 SDLC 문서 `#0`, index, summary |
| `{{ISSUE_NAME}}` / `{{ISSUE_NAME:...}}` | 사용자 입력 원문 | 모든 SDLC 문서 `#0`, summary |
| `{{CREATED_AT_KST}}` / `{{CREATED_AT_KST:TBD}}` | 현재 시각 (KST) | 모든 SDLC 문서 `#0`, summary |
| `{{UPDATED_AT_KST}}` / `{{UPDATED_AT_KST:TBD}}` | 현재 시각 (KST) | 모든 SDLC 문서 `#0`, summary |
| `{{OUTPUT_PATH}}` | 생성 파일 경로 | `1_discovery.md` `#9` |
| `{{FILE_RESULT}}` / `{{FILE_RESULT:생성\|갱신\|미생성}}` | `생성` (신규) 또는 `갱신` | `1_discovery.md` `#9` |
| `{{SUMMARY_STATUS}}` / `{{SUMMARY_STATUS:draft\|review\|confirmed}}` | `draft` | `summary.md` |

---

### B. AI 추론 치환 (Infer — agent가 입력 요청과 저장소 맥락을 바탕으로 초안을 채움)

> 입력만으로 합리적 추론이 가능한 항목은 플레이스홀더로 남기지 않고 자연어 문장으로 채운다.
> 추론이 불확실한 경우에는 `_DECISION` 접미사 형태로 남기고 `review-discovery` 단계에서 처리한다.

| 키 | 설명 | 위치 |
|---|---|---|
| `{{PLANNING_SCORE_FILE}}` | Planning 점수 파일 경로 또는 `미생성` | `#1` |
| `{{TODO_FILE}}` | 관련 TODO/메모 경로 또는 `없음` | `#1` |
| `{{SUMMARY_LINE_1}}`, `{{SUMMARY_LINE_2}}` | 현재 검토 배경 및 이번 Discovery 핵심 요약 | `#1` |
| `{{REQUIREMENT_CLASSIFICATION}}` | `신규` / `유사` / `완전 중복` | `#2` |
| `{{CLASSIFICATION_REASON_1}}`, `{{CLASSIFICATION_REASON_2}}` | 판정 근거 2줄 | `#2` |
| `{{CURRENT_STATE_1}}`, `{{CURRENT_STATE_2}}` | 현재 문제 상태 | `#3` |
| `{{TARGET_STATE_1}}`, `{{TARGET_STATE_2}}` | 기대 상태 | `#3` |
| `{{STAKEHOLDER_1~3}}` | 이해관계자 | `#3` |
| `{{CONSTRAINT_1}}`, `{{CONSTRAINT_2}}` | 제약사항 | `#3` |
| `{{USER_SCENARIO_1~3}}` | 주요 사용자 시나리오 | `#3` |
| `{{CHANGE_ITEM_1~3}}` | 핵심 변경 항목 | `#4` |
| `{{CODE_IMPACT_1~2}}`, `{{DOC_IMPACT_1~2}}`, `{{OPS_IMPACT_1~2}}` | 영향 범위 | `#4` |
| `{{FR_1~4}}` | 기능 요구사항 (최소 2개) | `#5` |
| `{{NFR_1~3}}` | 비기능 요구사항 (최소 1개) | `#5` |
| `{{IN_SCOPE_1~2}}`, `{{OUT_OF_SCOPE_1~2}}` | 범위 경계 | `#5` |
| `{{RISK_LEVEL_1~3}}`, `{{RISK_1~3}}`, `{{MITIGATION_1~3}}` | 리스크 항목 (최소 2개) | `#6` |
| `{{ASSUMPTION_1~3}}` | 가정 (최소 2개) | `#6` |
| `{{OPEN_QUESTION_1~3}}`, `{{OPEN_QUESTION_STATUS_1~3}}` | 오픈 질문 | `#6` |
| `{{OPEN_QUESTION_ACTION_1~3}}`, `{{OPEN_QUESTION_EXIT_1~3}}` | 오픈 질문 처리 방안/종료 조건 | `#6` |
| `{{SUCCESS_METRIC_1~3}}` | 성공 기준 (최소 2개) | `#7` |
| `{{MEASURE_METHOD_1~3}}`, `{{MEASURE_SOURCE_1~3}}` | 측정 방식 및 데이터 출처 | `#7` |
| `{{CHECK_SCOPE_CRITERIA}}` | 범위 확정 기준 | `#8` |
| `{{CHECK_METRICS_CRITERIA}}` | 성공 지표 확정 기준 | `#8` |
| `{{CHECK_RISK_OWNER_CRITERIA}}` | 리스크 책임자 지정 기준 | `#8` |
| `{{CHECK_CONFIRMEDBY_CRITERIA}}` | Freeze 담당자 지정 기준 | `#8` |
| `{{REFERENCE_1~3}}` | 참조 문서 목록 | `#9` |
| `{{SUMMARY_POINT_1~2}}` | summary.md 핵심 요약 | `summary.md` |

---

### C. 사용자 결정 필요 (Decide — 자동 추론 불가, 사용자/승인자가 직접 채워야 함)

> 이 항목들은 `#10 사용자 결정 필요 항목 요약`에 모아서 관리한다.
> 섹션 본문에는 최소 플레이스홀더만 남기거나 맥락 설명 문장으로 대체한다.

| 키 | 설명 | 위치 |
|---|---|---|
| `{{DECIDE_ITEM_1~2}}` | 정책/구조 결정이 필요한 항목 | `#10 > DECIDE` |
| `{{CONFIRM_ITEM_1~2}}` | 범위나 책임자 확인이 필요한 항목 | `#10 > CONFIRM` |
| `{{DATA_ITEM_1~2}}` | 외부 데이터나 환경 정보가 필요한 항목 | `#10 > DATA` |
| `{{FREEZE_HANDOFF_DECISION}}` | Planning 진행 가능 여부 (`Planning 진행 가능` / `보류`) | `#11` |
| `{{FREEZE_HANDOFF_RATIONALE}}` | Handoff Decision 판단 근거 | `#11` |
| `{{READY_FOR_PLANNING}}` | `true` / `false` | `#11` |
| `{{CONFIRMED_BY}}` | Freeze 확정 담당자 이름 | `#11` |
| `{{CONFIRMED_AT_KST}}` | Freeze 확정 시각 (KST) | `#11` |

---

## 3. `_DECISION` 접미사 패턴

섹션 본문에 판단이 필요한 항목이 생겼을 때 AI agent가 임시로 삽입하는 마커이다.

- **형식**: `{{원래키_N_DECISION:판단 내용 또는 질문}}`
- **예시**: `{{TARGET_STATE_2_DECISION:README 확장으로 할지, 별도 파일로 분리할지 결정 필요}}`
- **처리 규칙**:
  - `review-discovery` 프롬프트 실행 시 각 항목을 검토하여 아래 중 하나로 처리한다.
    - 추론 가능 → 자연어 문장으로 치환
    - 사용자 결정 필요 → `#10`으로 이동하고 본문은 맥락 설명 문장으로 대체

---

## 4. 참조 위치 요약

| 파일 | 역할 | 관련 플레이스홀더 |
|---|---|---|
| `.github/prompts/new-sdlc.prompt.md` | 주기 생성, 자동/추론 치환 실행 | A, B 전체 |
| `.github/prompts/review-discovery.prompt.md` | 검토, `_DECISION` 처리, 사용자 결정 항목 정리 | B (`_DECISION`), C |
| `.github/templates/sdlc/1_discovery.md` | Discovery 원본 템플릿 | A, B, C 전체 |
