# 0. 문서 상태
이 문서의 현재 상태와 식별 정보를 기록한다. 문서 추적과 승인 흐름에 필요한 최소 메타데이터를 적는다.

- 상태: {{DOC_STATUS:draft|review|confirmed}}
- 문서 ID: {{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}
- 이슈명: {{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}
- 참조 Discovery: {{DISCOVERY_PATH:docs/sdlc/<CYCLE_ID>/1_discovery.md}}
- 작성 시각(KST): {{CREATED_AT_KST:TBD}}
- 마지막 갱신 시각(KST): {{UPDATED_AT_KST:TBD}}

# 1. Discovery 인계 요약
Discovery에서 확정된 핵심 내용을 요약한다. 원본은 1_discovery.md를 참조하며, 이 섹션은 Planning 작업의 입력 기준선이 된다.

## 이슈 목적
- {{PLANNING_ISSUE_PURPOSE:Discovery 이슈명과 핵심 목적 1-2줄}}

## 확정 범위
- In Scope
	- {{PLANNING_IN_SCOPE_1}}
	- {{PLANNING_IN_SCOPE_2}}
- Out of Scope
	- {{PLANNING_OUT_OF_SCOPE_1}}
	- {{PLANNING_OUT_OF_SCOPE_2}}

## 기능 요구사항 (FR) 요약
- FR-1: {{PLANNING_FR_1}}
- FR-2: {{PLANNING_FR_2}}
- FR-3: {{PLANNING_FR_3:필요 없으면 삭제}}
- FR-4: {{PLANNING_FR_4:필요 없으면 삭제}}

## 비기능 요구사항 (NFR) 요약
- NFR-1: {{PLANNING_NFR_1}}
- NFR-2: {{PLANNING_NFR_2:필요 없으면 삭제}}

## 이월된 오픈 질문 / 리스크
Discovery에서 `Deferred` 처리되어 Planning 단계에서 해소해야 하는 항목을 기록한다.

- {{DEFERRED_ITEM_1:없으면 "없음"}}
- {{DEFERRED_ITEM_2:필요 없으면 삭제}}

# 2. 작업 분해 (Task Breakdown)
FR/NFR 각각을 실행 가능한 단위 태스크로 분해한다. 각 태스크는 하나의 완료 조건을 가져야 한다.

| ID | 태스크 제목 | 유형 | 참조 요구사항 | 의존 태스크 | 담당자 |
|-----|-----------|------|--------------|------------|--------|
| T-1 | {{TASK_TITLE_1}} | {{TASK_TYPE_1:개발\|문서\|검토\|설계\|운영}} | {{TASK_REF_1:FR-1}} | - | {{TASK_OWNER_1:TBD}} |
| T-2 | {{TASK_TITLE_2}} | {{TASK_TYPE_2:개발\|문서\|검토\|설계\|운영}} | {{TASK_REF_2:FR-2}} | {{TASK_DEP_2:-}} | {{TASK_OWNER_2:TBD}} |
| T-3 | {{TASK_TITLE_3:필요 없으면 삭제}} | {{TASK_TYPE_3:개발\|문서\|검토\|설계\|운영}} | {{TASK_REF_3}} | {{TASK_DEP_3:-}} | {{TASK_OWNER_3:TBD}} |
| T-4 | {{TASK_TITLE_4:필요 없으면 삭제}} | {{TASK_TYPE_4:개발\|문서\|검토\|설계\|운영}} | {{TASK_REF_4}} | {{TASK_DEP_4:-}} | {{TASK_OWNER_4:TBD}} |

## 태스크 완료 조건 (DoD)
각 태스크의 완료 기준을 명시한다.

- T-1: {{TASK_DOD_1}}
- T-2: {{TASK_DOD_2}}
- T-3: {{TASK_DOD_3:필요 없으면 삭제}}
- T-4: {{TASK_DOD_4:필요 없으면 삭제}}

# 3. 공수 추정
각 태스크의 예상 공수를 적는다. 단위는 팀 기준에 맞게 선택한다(SP 또는 시간).

| ID | 태스크 제목 | 추정 공수 | 추정 단위 | 비고 |
|-----|-----------|---------|---------|------|
| T-1 | {{TASK_TITLE_1}} | {{EFFORT_1}} | {{EFFORT_UNIT:SP\|시간\|일}} | {{EFFORT_NOTE_1:필요 없으면 삭제}} |
| T-2 | {{TASK_TITLE_2}} | {{EFFORT_2}} | {{EFFORT_UNIT}} | {{EFFORT_NOTE_2:필요 없으면 삭제}} |
| T-3 | {{TASK_TITLE_3:필요 없으면 삭제}} | {{EFFORT_3}} | {{EFFORT_UNIT}} | {{EFFORT_NOTE_3:필요 없으면 삭제}} |
| T-4 | {{TASK_TITLE_4:필요 없으면 삭제}} | {{EFFORT_4}} | {{EFFORT_UNIT}} | {{EFFORT_NOTE_4:필요 없으면 삭제}} |

- 총 추정 공수: {{TOTAL_EFFORT}}
- 추정 신뢰도: {{EFFORT_CONFIDENCE:High|Medium|Low}}
- 추정 근거: {{EFFORT_BASIS:추정에 사용한 방법 또는 유사 사례}}

# 4. 일정 계획
이터레이션 또는 스프린트 단위로 태스크 배분 계획을 적는다.

## 마일스톤
| 마일스톤 | 목표 날짜 | 포함 태스크 | 완료 조건 |
|---------|---------|-----------|---------|
| M-1: {{MILESTONE_1_NAME}} | {{MILESTONE_1_DATE:TBD}} | {{MILESTONE_1_TASKS:T-1, T-2}} | {{MILESTONE_1_DONE}} |
| M-2: {{MILESTONE_2_NAME:필요 없으면 삭제}} | {{MILESTONE_2_DATE:TBD}} | {{MILESTONE_2_TASKS}} | {{MILESTONE_2_DONE}} |

## 이터레이션 계획
- 이터레이션 단위: {{ITERATION_UNIT:스프린트|주|없음(단일 배포)}}
- 이터레이션 1 ({{ITERATION_1_PERIOD:날짜 범위 또는 TBD}}): {{ITERATION_1_TASKS:T-1, T-2}}
- 이터레이션 2 ({{ITERATION_2_PERIOD:날짜 범위 또는 TBD}}): {{ITERATION_2_TASKS:T-3, T-4}}

# 5. 의존성 및 제약
태스크 간 의존 관계와 외부 의존성을 기록한다.

## 태스크 간 의존성
- {{TASK_DEPENDENCY_1:예. T-2는 T-1 완료 후 시작 가능}}
- {{TASK_DEPENDENCY_2:필요 없으면 삭제}}

## 외부 의존성
다른 팀, 시스템, 도구에 의존하는 항목을 적는다.

- {{EXTERNAL_DEP_1:예. CI/CD 파이프라인 설정 필요}}
- {{EXTERNAL_DEP_2:필요 없으면 삭제}}

## 기술/환경 제약
- {{TECH_CONSTRAINT_1}}
- {{TECH_CONSTRAINT_2:필요 없으면 삭제}}

# 6. 검증 계획 개요
Discovery의 성공 기준과 연결해 어떻게 검증할지 초안을 적는다. 상세 검증은 Verification 단계에서 정의한다.

| 성공 기준 | 검증 방법 초안 | 담당자 |
|---------|-------------|--------|
| {{VERIFY_CRITERIA_1:S-1 요약}} | {{VERIFY_METHOD_1}} | {{VERIFY_OWNER_1:TBD}} |
| {{VERIFY_CRITERIA_2:S-2 요약}} | {{VERIFY_METHOD_2}} | {{VERIFY_OWNER_2:TBD}} |
| {{VERIFY_CRITERIA_3:S-3 요약 또는 삭제}} | {{VERIFY_METHOD_3}} | {{VERIFY_OWNER_3:TBD}} |

# 7. 리스크
Planning 단계에서 새로 식별된 리스크를 기록한다. Discovery에서 이월된 리스크는 `# 1` 이월 항목에서 확인한다.

## 리스크
- R-1 ({{PLAN_RISK_LEVEL_1:High|Medium|Low}}): {{PLAN_RISK_1}}
	- 완화 방안: {{PLAN_MITIGATION_1}}
- R-2 ({{PLAN_RISK_LEVEL_2:High|Medium|Low}}): {{PLAN_RISK_2:필요 없으면 삭제}}
	- 완화 방안: {{PLAN_MITIGATION_2:필요 없으면 삭제}}

## 가정
Planning 수행의 전제가 되는 가정을 적는다.

- PA-1: {{PLAN_ASSUMPTION_1}}
- PA-2: {{PLAN_ASSUMPTION_2:필요 없으면 삭제}}

## 오픈 질문
Planning 진행 중 확인이 필요한 질문을 적는다.

- OQ-1: {{PLAN_OPEN_QUESTION_1}}
	- 상태: {{PLAN_OQ_STATUS_1:Open|Answered|Deferred|Dropped}}
	- 처리 방안: {{PLAN_OQ_ACTION_1}}
	- 종료 조건: {{PLAN_OQ_EXIT_1}}
- OQ-2: {{PLAN_OPEN_QUESTION_2:필요 없으면 삭제}}
	- 상태: {{PLAN_OQ_STATUS_2:Open|Answered|Deferred|Dropped}}
	- 처리 방안: {{PLAN_OQ_ACTION_2}}
	- 종료 조건: {{PLAN_OQ_EXIT_2}}

# 8. Design으로 넘기기 전 확인 체크
Design 단계로 넘기기 전에 무엇이 확정되어야 하는지 확인한다.

- [ ] 전체 태스크 목록 확정 및 담당자 지정
	- 기준: {{CHECK_TASKS_CRITERIA:모든 태스크에 담당자가 지정되어야 한다}}
- [ ] 공수 추정 완료 및 총 공수 확인
	- 기준: {{CHECK_EFFORT_CRITERIA:모든 태스크의 추정 공수가 채워져야 한다}}
- [ ] 마일스톤 및 이터레이션 계획 확정
	- 기준: {{CHECK_SCHEDULE_CRITERIA:M-1 이상의 마일스톤과 이터레이션 경계가 정의되어야 한다}}
- [ ] 외부 의존성 해소 계획 확인
	- 기준: {{CHECK_DEP_CRITERIA:외부 의존성 각 항목에 담당자 또는 해소 방안이 있어야 한다}}
- [ ] 모든 오픈 질문(OQ) `Open` 상태 없음 확인
	- 기준: OQ 목록에 `Open` 상태 항목이 0개이거나, 잔여 항목 전부 `Deferred` 처리 완료
- [ ] Freeze 확정 담당자(CONFIRMED_BY) 지정
	- 기준: {{CHECK_CONFIRMEDBY_CRITERIA:문서 승인 또는 인계 결정을 내릴 담당자가 명시되어야 한다}}

# 9. 파일 처리 결과
이 Planning 문서 생성/갱신 결과와 참조 문서를 기록한다.

- 처리 결과: {{FILE_RESULT:생성|갱신|미생성}}
- 생성 경로: {{OUTPUT_PATH}}
- 참조 문서:
	- {{DISCOVERY_PATH:docs/sdlc/<CYCLE_ID>/1_discovery.md}}
	- {{REFERENCE_1:필요 없으면 삭제}}

# 10. 사용자 결정 필요 항목 요약
사용자나 승인자가 결정해야 하는 항목만 모아 정리한다.

## DECIDE
- {{DECIDE_ITEM_1}}
- {{DECIDE_ITEM_2:필요 없으면 삭제}}

## CONFIRM
- {{CONFIRM_ITEM_1}}
- {{CONFIRM_ITEM_2:필요 없으면 삭제}}

## DATA
- {{DATA_ITEM_1}}
- {{DATA_ITEM_2:필요 없으면 삭제}}

# 11. Planning Freeze
Design 인계 시점의 확정 플래그와 섹션 참조만 기록한다. 내용 재작성 없이 원본 섹션을 링크로 대신한다.

## 섹션 참조
- 작업 분해: [# 2. 작업 분해](#2-작업-분해-task-breakdown)
- 공수/일정: [# 3. 공수 추정](#3-공수-추정), [# 4. 일정 계획](#4-일정-계획)
- 의존성: [# 5. 의존성 및 제약](#5-의존성-및-제약)
- 검증 계획: [# 6. 검증 계획 개요](#6-검증-계획-개요)
- 리스크/오픈 질문: [# 7. 리스크](#7-리스크)
- 인계 전 확인: [# 8. Design으로 넘기기 전 확인 체크](#8-design으로-넘기기-전-확인-체크)
- 사용자 결정 필요: [# 10. 사용자 결정 필요 항목 요약](#10-사용자-결정-필요-항목-요약)

## Freeze 플래그
- Handoff Decision: {{FREEZE_HANDOFF_DECISION:Design 진행 가능|보류}}
- Handoff Rationale: {{FREEZE_HANDOFF_RATIONALE:진행 가능 또는 보류 판단 근거 1-2줄}}
- Ready for Design: {{READY_FOR_DESIGN:false}}
- Confirmed By: {{CONFIRMED_BY:TBD}}
- Confirmed At (KST): {{CONFIRMED_AT_KST:TBD}}

# 12. 작성 가이드
템플릿 사용 시의 기본 규칙을 적는다. 실제 문서를 만들 때는 이 가이드를 기준으로 플레이스홀더를 치환한다.

- 이 파일은 템플릿이다. 실제 문서 작성 시 `{{...}}` 플레이스홀더를 구체 값으로 교체한다.
- 필요 없는 태스크/마일스톤 행은 삭제하고, 부족한 항목은 같은 형식으로 추가한다.
- 공수 추정은 팀 기준 단위(SP/시간/일)를 통일해서 사용한다.
- Planning Freeze는 문서 하단에 반드시 유지한다.
