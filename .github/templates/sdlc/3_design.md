# 0. 문서 상태
이 문서의 현재 상태와 식별 정보를 기록한다. 문서 추적과 승인 흐름에 필요한 최소 메타데이터를 적는다.

- 상태: {{DOC_STATUS:draft|review|confirmed}}
- 문서 ID: {{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}
- 이슈명: {{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}
- 참조 Planning: {{PLANNING_PATH:docs/sdlc/<CYCLE_ID>/2_planning.md}}
- 작성 시각(KST): {{CREATED_AT_KST:TBD}}
- 마지막 갱신 시각(KST): {{UPDATED_AT_KST:TBD}}

# 1. Planning 인계 요약
Planning에서 확정된 핵심 내용을 요약한다. 원본은 2_planning.md를 참조하며, 이 섹션은 Design 작업의 입력 기준선이 된다.

## 이슈 목적
- {{DESIGN_ISSUE_PURPOSE:Planning 이슈명과 핵심 목적 1-2줄}}

## 확정 태스크 목록
| ID | 태스크 제목 | 참조 요구사항 | 담당자 |
|----|-----------|------------|--------|
| T-1 | {{DESIGN_TASK_TITLE_1}} | {{DESIGN_TASK_REF_1}} | {{DESIGN_TASK_OWNER_1:TBD}} |
| T-2 | {{DESIGN_TASK_TITLE_2}} | {{DESIGN_TASK_REF_2}} | {{DESIGN_TASK_OWNER_2:TBD}} |
| T-3 | {{DESIGN_TASK_TITLE_3:필요 없으면 삭제}} | {{DESIGN_TASK_REF_3}} | {{DESIGN_TASK_OWNER_3:TBD}} |

## 이월된 오픈 질문 / 리스크
Planning에서 `Deferred` 처리되어 Design 단계에서 해소해야 하는 항목을 기록한다.

- {{DESIGN_DEFERRED_ITEM_1:없으면 "없음"}}
- {{DESIGN_DEFERRED_ITEM_2:필요 없으면 삭제}}

# 2. 아키텍처 및 구조 설계
변경이 미치는 전체 구조와 주요 컴포넌트 관계를 설명한다.

## 전체 구조 개요
{{ARCH_OVERVIEW:시스템/모듈/파일 구조를 개요 수준으로 설명. 다이어그램 또는 목록 형태 모두 가능}}

## 주요 컴포넌트
| 컴포넌트 | 역할 | 영향 범위 |
|---------|------|---------|
| {{COMPONENT_1_NAME}} | {{COMPONENT_1_ROLE}} | {{COMPONENT_1_SCOPE}} |
| {{COMPONENT_2_NAME}} | {{COMPONENT_2_ROLE}} | {{COMPONENT_2_SCOPE}} |
| {{COMPONENT_3_NAME:필요 없으면 삭제}} | {{COMPONENT_3_ROLE}} | {{COMPONENT_3_SCOPE}} |

## 데이터 흐름
변경과 관련된 주요 데이터 흐름 또는 처리 순서를 적는다. 복잡하면 단계별 목록으로 표현한다.

- {{DATA_FLOW_1}}
- {{DATA_FLOW_2}}
- {{DATA_FLOW_3:필요 없으면 삭제}}

# 3. 상세 설계
태스크(T-N)별로 구체적인 구현/변경 방법을 기술한다.

## T-1: {{DESIGN_TASK_TITLE_1}}
- 설계 방향: {{DESIGN_DETAIL_1}}
- 변경 대상: {{DESIGN_TARGET_1:파일 경로, 함수명, 설정 키 등}}
- 입력/출력: {{DESIGN_IO_1:입력값과 출력값 또는 사이드이펙트}}
- 예외/엣지 케이스: {{DESIGN_EDGE_1:필요 없으면 삭제}}

## T-2: {{DESIGN_TASK_TITLE_2}}
- 설계 방향: {{DESIGN_DETAIL_2}}
- 변경 대상: {{DESIGN_TARGET_2}}
- 입력/출력: {{DESIGN_IO_2}}
- 예외/엣지 케이스: {{DESIGN_EDGE_2:필요 없으면 삭제}}

## T-3: {{DESIGN_TASK_TITLE_3:필요 없으면 삭제}}
- 설계 방향: {{DESIGN_DETAIL_3}}
- 변경 대상: {{DESIGN_TARGET_3}}
- 입력/출력: {{DESIGN_IO_3}}
- 예외/엣지 케이스: {{DESIGN_EDGE_3:필요 없으면 삭제}}

# 4. 인터페이스 정의
외부 시스템, 모듈 간 계약(API, 이벤트, 파일 포맷 등)을 명시한다. 해당 없으면 "해당 없음"으로 기재한다.

## API / 함수 시그니처
- {{INTERFACE_1:예. function foo(bar: string): boolean — 설명}}
- {{INTERFACE_2:필요 없으면 삭제}}

## 데이터 스키마 / 포맷
- {{SCHEMA_1:예. { id: string, status: "draft"|"confirmed" } — 설명}}
- {{SCHEMA_2:필요 없으면 삭제}}

## 이벤트 / 메시지
- {{EVENT_1:필요 없으면 삭제}}
- {{EVENT_2:필요 없으면 삭제}}

# 5. 보안 고려사항
OWASP Top 10 기준으로 이번 변경에서 주의해야 할 보안 항목을 점검한다.

| 항목 | 해당 여부 | 대응 방안 |
|------|---------|---------|
| 입력값 검증 (Injection) | {{SEC_INJECTION:해당|비해당}} | {{SEC_INJECTION_ACTION:비해당이면 삭제}} |
| 인증/인가 | {{SEC_AUTH:해당|비해당}} | {{SEC_AUTH_ACTION:비해당이면 삭제}} |
| 민감 데이터 노출 | {{SEC_DATA:해당|비해당}} | {{SEC_DATA_ACTION:비해당이면 삭제}} |
| 의존성 취약점 | {{SEC_DEP:해당|비해당}} | {{SEC_DEP_ACTION:비해당이면 삭제}} |
| 기타 | {{SEC_OTHER:필요 없으면 삭제}} | {{SEC_OTHER_ACTION:필요 없으면 삭제}} |

# 6. 리스크
Design 단계에서 새로 식별된 리스크를 기록한다. Planning에서 이월된 리스크는 `# 1` 이월 항목에서 확인한다.

## 리스크
- R-1 ({{DESIGN_RISK_LEVEL_1:High|Medium|Low}}): {{DESIGN_RISK_1}}
	- 완화 방안: {{DESIGN_MITIGATION_1}}
- R-2 ({{DESIGN_RISK_LEVEL_2:High|Medium|Low}}): {{DESIGN_RISK_2:필요 없으면 삭제}}
	- 완화 방안: {{DESIGN_MITIGATION_2:필요 없으면 삭제}}

## 가정
Design 수행의 전제가 되는 가정을 적는다.

- DA-1: {{DESIGN_ASSUMPTION_1}}
- DA-2: {{DESIGN_ASSUMPTION_2:필요 없으면 삭제}}

## 오픈 질문
Design 진행 중 확인이 필요한 질문을 적는다.

- OQ-1: {{DESIGN_OPEN_QUESTION_1}}
	- 상태: {{DESIGN_OQ_STATUS_1:Open|Answered|Deferred|Dropped}}
	- 처리 방안: {{DESIGN_OQ_ACTION_1}}
	- 종료 조건: {{DESIGN_OQ_EXIT_1}}
- OQ-2: {{DESIGN_OPEN_QUESTION_2:필요 없으면 삭제}}
	- 상태: {{DESIGN_OQ_STATUS_2:Open|Answered|Deferred|Dropped}}
	- 처리 방안: {{DESIGN_OQ_ACTION_2}}
	- 종료 조건: {{DESIGN_OQ_EXIT_2}}

# 7. Implementation으로 넘기기 전 확인 체크
Implementation 단계로 넘기기 전에 무엇이 확정되어야 하는지 확인한다.

- [ ] 전체 컴포넌트 및 태스크별 설계 완성
	- 기준: {{CHECK_DESIGN_COMPLETE:모든 T-N 태스크에 설계 방향과 변경 대상이 채워져야 한다}}
- [ ] 인터페이스 계약 확정
	- 기준: {{CHECK_INTERFACE:외부 의존 컴포넌트와의 계약이 명시되어야 한다}}
- [ ] 보안 점검 완료
	- 기준: {{CHECK_SECURITY:OWASP 점검 항목 중 해당 항목은 대응 방안이 있어야 한다}}
- [ ] 모든 오픈 질문(OQ) `Open` 상태 없음 확인
	- 기준: OQ 목록에 `Open` 상태 항목이 0개이거나, 잔여 항목 전부 `Deferred` 처리 완료
- [ ] Freeze 확정 담당자(CONFIRMED_BY) 지정
	- 기준: {{CHECK_CONFIRMEDBY_CRITERIA:문서 승인 또는 인계 결정을 내릴 담당자가 명시되어야 한다}}

# 8. 파일 처리 결과
이 Design 문서 생성/갱신 결과와 참조 문서를 기록한다.

- 처리 결과: {{FILE_RESULT:생성|갱신|미생성}}
- 생성 경로: {{OUTPUT_PATH}}
- 참조 문서:
	- {{PLANNING_PATH:docs/sdlc/<CYCLE_ID>/2_planning.md}}
	- {{REFERENCE_1:필요 없으면 삭제}}

# 9. 사용자 결정 필요 항목 요약
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

# 10. Design Freeze
Implementation 인계 시점의 확정 플래그와 섹션 참조만 기록한다. 내용 재작성 없이 원본 섹션을 링크로 대신한다.

## 섹션 참조
- 아키텍처/구조: [# 2. 아키텍처 및 구조 설계](#2-아키텍처-및-구조-설계)
- 상세 설계: [# 3. 상세 설계](#3-상세-설계)
- 인터페이스: [# 4. 인터페이스 정의](#4-인터페이스-정의)
- 보안: [# 5. 보안 고려사항](#5-보안-고려사항)
- 리스크/오픈 질문: [# 6. 리스크](#6-리스크)
- 인계 전 확인: [# 7. Implementation으로 넘기기 전 확인 체크](#7-implementation으로-넘기기-전-확인-체크)
- 사용자 결정 필요: [# 9. 사용자 결정 필요 항목 요약](#9-사용자-결정-필요-항목-요약)

## Freeze 플래그
- Handoff Decision: {{FREEZE_HANDOFF_DECISION:Implementation 진행 가능|보류}}
- Handoff Rationale: {{FREEZE_HANDOFF_RATIONALE:진행 가능 또는 보류 판단 근거 1-2줄}}
- Ready for Implementation: {{READY_FOR_IMPLEMENTATION:false}}
- Confirmed By: {{CONFIRMED_BY:TBD}}
- Confirmed At (KST): {{CONFIRMED_AT_KST:TBD}}

# 11. 작성 가이드
템플릿 사용 시의 기본 규칙을 적는다. 실제 문서를 만들 때는 이 가이드를 기준으로 플레이스홀더를 치환한다.

- 이 파일은 템플릿이다. 실제 문서 작성 시 `{{...}}` 플레이스홀더를 구체 값으로 교체한다.
- 필요 없는 컴포넌트/태스크 항목은 삭제하고, 부족한 항목은 같은 형식으로 추가한다.
- 보안 고려사항은 "비해당"이라도 근거를 남긴다.
- Design Freeze는 문서 하단에 반드시 유지한다.
