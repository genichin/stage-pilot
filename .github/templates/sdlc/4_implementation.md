# 0. 문서 상태
이 문서의 현재 상태와 식별 정보를 기록한다. 문서 추적과 승인 흐름에 필요한 최소 메타데이터를 적는다.

- 상태: {{DOC_STATUS:draft|review|confirmed}}
- 문서 ID: {{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}
- 이슈명: {{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}
- 참조 Design: {{DESIGN_PATH:docs/sdlc/<CYCLE_ID>/3_design.md}}
- 작성 시각(KST): {{CREATED_AT_KST:TBD}}
- 마지막 갱신 시각(KST): {{UPDATED_AT_KST:TBD}}

# 1. Design 인계 요약
Design에서 확정된 핵심 내용을 요약한다. 원본은 3_design.md를 참조하며, 이 섹션은 Implementation 작업의 입력 기준선이 된다.

## 이슈 목적
- {{IMP_ISSUE_PURPOSE:Design 이슈명과 핵심 목적 1-2줄}}

## 확정 태스크 및 변경 대상
| ID | 태스크 제목 | 변경 대상 파일/함수 | 담당자 |
|----|-----------|-------------------|--------|
| T-1 | {{IMP_TASK_TITLE_1}} | {{IMP_TASK_TARGET_1}} | {{IMP_TASK_OWNER_1:TBD}} |
| T-2 | {{IMP_TASK_TITLE_2}} | {{IMP_TASK_TARGET_2}} | {{IMP_TASK_OWNER_2:TBD}} |
| T-3 | {{IMP_TASK_TITLE_3:필요 없으면 삭제}} | {{IMP_TASK_TARGET_3}} | {{IMP_TASK_OWNER_3:TBD}} |

## 이월된 오픈 질문 / 리스크
Design에서 `Deferred` 처리되어 Implementation 단계에서 해소해야 하는 항목을 기록한다.

- {{IMP_DEFERRED_ITEM_1:없으면 "없음"}}
- {{IMP_DEFERRED_ITEM_2:필요 없으면 삭제}}

# 2. 구현 계획
태스크(T-N)별 구현 순서와 접근 방법을 기술한다.

## 구현 순서
태스크 간 의존 관계와 우선순위를 고려한 구현 순서를 정의한다.

1. {{IMP_ORDER_1:예. T-1 — 기반 구조 구현 (다른 태스크의 의존 대상)}}
2. {{IMP_ORDER_2:예. T-2 — 핵심 기능 구현}}
3. {{IMP_ORDER_3:필요 없으면 삭제}}

## T-1: {{IMP_TASK_TITLE_1}}
- 구현 방법: {{IMP_METHOD_1:설계 방향을 실제 코드/설정으로 구현하는 접근}}
- 변경 대상: {{IMP_TARGET_1:실제 파일 경로, 함수명, 설정 키}}
- 완료 조건: {{IMP_DOD_1:이 태스크가 완료된 것으로 간주하는 기준}}
- 주의사항: {{IMP_NOTE_1:구현 중 주의해야 할 사항. 필요 없으면 삭제}}

## T-2: {{IMP_TASK_TITLE_2}}
- 구현 방법: {{IMP_METHOD_2}}
- 변경 대상: {{IMP_TARGET_2}}
- 완료 조건: {{IMP_DOD_2}}
- 주의사항: {{IMP_NOTE_2:필요 없으면 삭제}}

## T-3: {{IMP_TASK_TITLE_3:필요 없으면 삭제}}
- 구현 방법: {{IMP_METHOD_3}}
- 변경 대상: {{IMP_TARGET_3}}
- 완료 조건: {{IMP_DOD_3}}
- 주의사항: {{IMP_NOTE_3:필요 없으면 삭제}}

# 3. 변경 파일 목록
이번 Implementation에서 생성/수정/삭제되는 파일을 미리 나열한다. 구현 완료 후 실제 결과를 반영해 갱신한다.

| 파일 경로 | 변경 유형 | 관련 태스크 | 비고 |
|---------|---------|-----------|------|
| {{IMP_FILE_1}} | {{IMP_FILE_TYPE_1:생성\|수정\|삭제}} | {{IMP_FILE_TASK_1:T-1}} | {{IMP_FILE_NOTE_1:필요 없으면 삭제}} |
| {{IMP_FILE_2}} | {{IMP_FILE_TYPE_2:생성\|수정\|삭제}} | {{IMP_FILE_TASK_2}} | {{IMP_FILE_NOTE_2:필요 없으면 삭제}} |
| {{IMP_FILE_3:필요 없으면 삭제}} | {{IMP_FILE_TYPE_3:생성\|수정\|삭제}} | {{IMP_FILE_TASK_3}} | {{IMP_FILE_NOTE_3:필요 없으면 삭제}} |

# 4. 리스크 및 제약
Implementation 단계에서 새로 식별된 리스크와 제약사항을 기록한다.

## 리스크
- R-1 ({{IMP_RISK_LEVEL_1:High|Medium|Low}}): {{IMP_RISK_1}}
  - 완화 방안: {{IMP_MITIGATION_1}}
- R-2 ({{IMP_RISK_LEVEL_2:High|Medium|Low}}): {{IMP_RISK_2:필요 없으면 삭제}}
  - 완화 방안: {{IMP_MITIGATION_2:필요 없으면 삭제}}

## 가정
Implementation 수행의 전제가 되는 가정을 적는다.

- IA-1: {{IMP_ASSUMPTION_1}}
- IA-2: {{IMP_ASSUMPTION_2:필요 없으면 삭제}}

## 오픈 질문
Implementation 진행 중 확인이 필요한 질문을 적는다.

- OQ-1: {{IMP_OPEN_QUESTION_1}}
  - 상태: {{IMP_OQ_STATUS_1:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{IMP_OQ_ACTION_1}}
  - 종료 조건: {{IMP_OQ_EXIT_1}}
- OQ-2: {{IMP_OPEN_QUESTION_2:필요 없으면 삭제}}
  - 상태: {{IMP_OQ_STATUS_2:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{IMP_OQ_ACTION_2}}
  - 종료 조건: {{IMP_OQ_EXIT_2}}

# 5. Verification으로 넘기기 전 확인 체크
Verification 단계로 넘기기 전에 무엇이 완료되어야 하는지 확인한다.

- [ ] 모든 T-N 태스크 구현 완료
  - 기준: {{CHECK_ALL_TASKS:각 태스크의 완료 조건(DoD)을 충족해야 한다}}
- [ ] 변경 파일 목록과 실제 변경 일치
  - 기준: {{CHECK_FILE_LIST:3_design.md의 변경 대상과 실제 변경된 파일이 일치해야 한다}}
- [ ] 단위 테스트 또는 로컬 검증 완료
  - 기준: {{CHECK_LOCAL_VERIFY:변경 사항이 로컬 환경에서 의도대로 동작하는지 확인해야 한다}}
- [ ] 모든 오픈 질문(OQ) `Open` 상태 없음 확인
  - 기준: OQ 목록에 `Open` 상태 항목이 0개이거나, 잔여 항목 전부 `Deferred` 처리 완료
- [ ] Freeze 확정 담당자(CONFIRMED_BY) 지정
  - 기준: {{CHECK_CONFIRMEDBY_CRITERIA:문서 승인 또는 인계 결정을 내릴 담당자가 명시되어야 한다}}

# 6. 파일 처리 결과
이 Implementation 문서 생성/갱신 결과와 참조 문서를 기록한다.

- 처리 결과: {{FILE_RESULT:생성|갱신|미생성}}
- 생성 경로: {{OUTPUT_PATH}}
- 참조 문서:
  - {{DESIGN_PATH:docs/sdlc/<CYCLE_ID>/3_design.md}}
  - {{REFERENCE_1:필요 없으면 삭제}}

# 7. 사용자 결정 필요 항목 요약
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

# 8. Implementation Freeze
Verification 인계 시점의 확정 플래그와 섹션 참조만 기록한다. 내용 재작성 없이 원본 섹션을 링크로 대신한다.

## 섹션 참조
- 구현 계획: [# 2. 구현 계획](#2-구현-계획)
- 변경 파일 목록: [# 3. 변경 파일 목록](#3-변경-파일-목록)
- 리스크/오픈 질문: [# 4. 리스크 및 제약](#4-리스크-및-제약)

## 확정 플래그
- Handoff Decision: {{FREEZE_HANDOFF_DECISION:보류}}
- Handoff Rationale: {{FREEZE_HANDOFF_RATIONALE:구현 완료 및 로컬 검증 후 Verification으로 인계}}
- Ready for Verification: {{READY_FOR_VERIFICATION:false}}
- Confirmed By: {{CONFIRMED_BY:TBD}}
- Confirmed At (KST): {{CONFIRMED_AT_KST:TBD}}

---

# 12. 작성 가이드
*이 섹션은 작성 참고용이다. 문서 완성 후 삭제해도 된다.*

- **변경 대상 파일 경로**: 실제 저장소 파일 경로를 명시한다. 추정이나 가상 경로를 쓰지 않는다.
- **완료 조건(DoD)**: "구현 완료"처럼 모호한 표현 대신 "파일 X에 함수 Y가 추가되고 입력 Z에 대해 올바른 결과를 반환한다"처럼 측정 가능하게 작성한다.
- **오픈 질문**: 구현 중 발생한 기술적 판단 사항, 외부 확인 필요 항목 등을 기록한다.
- **Freeze 섹션**: 모든 태스크 완료 및 로컬 검증 후 담당자가 직접 갱신한다.
