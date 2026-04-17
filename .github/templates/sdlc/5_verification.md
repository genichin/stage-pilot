# 0. 문서 상태
이 문서의 현재 상태와 식별 정보를 기록한다. 문서 추적과 승인 흐름에 필요한 최소 메타데이터를 적는다.

- 상태: {{DOC_STATUS:draft|review|confirmed}}
- 문서 ID: {{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}
- 이슈명: {{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}
- 참조 Implementation: {{IMP_PATH:docs/sdlc/<CYCLE_ID>/4_implementation.md}}
- 작성 시각(KST): {{CREATED_AT_KST:TBD}}
- 마지막 갱신 시각(KST): {{UPDATED_AT_KST:TBD}}

# 1. Implementation 인계 요약
Implementation에서 완료된 핵심 내용을 요약한다. 원본은 4_implementation.md를 참조하며, 이 섹션은 Verification 작업의 입력 기준선이 된다.

## 이슈 목적
- {{VER_ISSUE_PURPOSE:Implementation 이슈명과 핵심 목적 1-2줄}}

## 구현 완료 태스크
| ID | 태스크 제목 | 변경 파일/함수 | 완료 조건(DoD) |
|----|-----------|--------------|--------------|
| T-1 | {{VER_TASK_TITLE_1}} | {{VER_TASK_TARGET_1}} | {{VER_TASK_DOD_1}} |
| T-2 | {{VER_TASK_TITLE_2}} | {{VER_TASK_TARGET_2}} | {{VER_TASK_DOD_2}} |
| T-3 | {{VER_TASK_TITLE_3:필요 없으면 삭제}} | {{VER_TASK_TARGET_3}} | {{VER_TASK_DOD_3}} |

## 이월된 오픈 질문 / 리스크
Implementation에서 `Deferred` 처리되어 Verification 단계에서 해소해야 하는 항목을 기록한다.

- {{VER_DEFERRED_ITEM_1:없으면 "없음"}}
- {{VER_DEFERRED_ITEM_2:필요 없으면 삭제}}

# 2. 검증 계획
Discovery `# 7` 성공 기준(S-N)을 기반으로 Verification 항목을 정의한다.

## 검증 범위
- {{VER_SCOPE_1:예. 기능 요구사항(FR) 전체 충족 여부}}
- {{VER_SCOPE_2:예. 비기능 요구사항(NFR) 성능 기준 충족 여부}}
- {{VER_SCOPE_3:필요 없으면 삭제}}

## 검증 항목
| ID | 검증 항목 | 검증 방법 | 성공 기준 | 담당자 |
|----|---------|---------|---------|--------|
| VC-1 | {{VER_ITEM_1}} | {{VER_METHOD_1:수동\|자동\|혼합}} | {{VER_CRITERIA_1}} | {{VER_OWNER_1:TBD}} |
| VC-2 | {{VER_ITEM_2}} | {{VER_METHOD_2:수동\|자동\|혼합}} | {{VER_CRITERIA_2}} | {{VER_OWNER_2:TBD}} |
| VC-3 | {{VER_ITEM_3:필요 없으면 삭제}} | {{VER_METHOD_3:수동\|자동\|혼합}} | {{VER_CRITERIA_3}} | {{VER_OWNER_3:TBD}} |
| VC-4 | {{VER_ITEM_4:필요 없으면 삭제}} | {{VER_METHOD_4:수동\|자동\|혼합}} | {{VER_CRITERIA_4}} | {{VER_OWNER_4:TBD}} |

## 성공 기준 연결
Discovery의 성공 기준(S-N)과 검증 항목(VC-N)의 연결을 명시한다.

- S-1 → {{VER_S1_LINK:VC-1, VC-2 등}}
- S-2 → {{VER_S2_LINK:VC-3 등}}
- S-3 → {{VER_S3_LINK:필요 없으면 삭제}}

# 3. 검증 결과
검증 수행 후 각 항목의 결과를 기록한다. 초안 생성 시 모두 `미완료`로 초기화한다.

| ID | 검증 항목 | 결과 | 비고 |
|----|---------|------|------|
| VC-1 | {{VER_ITEM_1}} | {{VER_RESULT_1:미완료\|통과\|실패\|블로킹}} | {{VER_RESULT_NOTE_1:필요 없으면 삭제}} |
| VC-2 | {{VER_ITEM_2}} | {{VER_RESULT_2:미완료\|통과\|실패\|블로킹}} | {{VER_RESULT_NOTE_2:필요 없으면 삭제}} |
| VC-3 | {{VER_ITEM_3:필요 없으면 삭제}} | {{VER_RESULT_3:미완료\|통과\|실패\|블로킹}} | {{VER_RESULT_NOTE_3:필요 없으면 삭제}} |

## 전체 검증 결과
- 통과: {{VER_PASS_COUNT:0}} / {{VER_TOTAL_COUNT:0}}
- 실패/블로킹: {{VER_FAIL_COUNT:0}}
- 검증 완료 여부: {{VER_COMPLETE:false}}

# 4. 결함 및 재작업 사항
검증 중 발견된 결함과 재작업이 필요한 항목을 기록한다.

- BUG-1: {{BUG_1:없으면 "없음"}}
  - 심각도: {{BUG_SEVERITY_1:Critical|High|Medium|Low}}
  - 재작업 내용: {{BUG_FIX_1}}
  - 상태: {{BUG_STATUS_1:Open|Fixed|Deferred}}
- BUG-2: {{BUG_2:필요 없으면 삭제}}
  - 심각도: {{BUG_SEVERITY_2:Critical|High|Medium|Low}}
  - 재작업 내용: {{BUG_FIX_2}}
  - 상태: {{BUG_STATUS_2:Open|Fixed|Deferred}}

# 5. 리스크 및 오픈 질문
Verification 단계에서 새로 식별된 리스크와 오픈 질문을 기록한다.

## 리스크
- R-1 ({{VER_RISK_LEVEL_1:High|Medium|Low}}): {{VER_RISK_1}}
  - 완화 방안: {{VER_MITIGATION_1}}
- R-2 ({{VER_RISK_LEVEL_2:High|Medium|Low}}): {{VER_RISK_2:필요 없으면 삭제}}
  - 완화 방안: {{VER_MITIGATION_2:필요 없으면 삭제}}

## 오픈 질문
- OQ-1: {{VER_OPEN_QUESTION_1}}
  - 상태: {{VER_OQ_STATUS_1:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{VER_OQ_ACTION_1}}
  - 종료 조건: {{VER_OQ_EXIT_1}}
- OQ-2: {{VER_OPEN_QUESTION_2:필요 없으면 삭제}}
  - 상태: {{VER_OQ_STATUS_2:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{VER_OQ_ACTION_2}}
  - 종료 조건: {{VER_OQ_EXIT_2}}

# 6. Release로 넘기기 전 확인 체크
Release 단계로 넘기기 전에 무엇이 완료되어야 하는지 확인한다.

- [ ] 모든 검증 항목(VC-N) 통과
  - 기준: {{CHECK_ALL_VC:VC 목록의 모든 항목이 "통과" 상태여야 한다}}
- [ ] 결함(BUG) `Open` 상태 없음
  - 기준: {{CHECK_BUGS:BUG 목록에 `Open` 상태 항목이 0개여야 한다. `Deferred`는 근거와 함께 허용}}
- [ ] 성공 기준(S-N) 전체 충족
  - 기준: {{CHECK_SUCCESS_CRITERIA:Discovery에서 정의된 S-N 기준이 모두 VC 항목과 연결되어 통과되었는가}}
- [ ] 모든 오픈 질문(OQ) `Open` 상태 없음 확인
  - 기준: OQ 목록에 `Open` 상태 항목이 0개이거나, 잔여 항목 전부 `Deferred` 처리 완료
- [ ] Freeze 확정 담당자(CONFIRMED_BY) 지정
  - 기준: {{CHECK_CONFIRMEDBY_CRITERIA:문서 승인 또는 인계 결정을 내릴 담당자가 명시되어야 한다}}

# 7. 파일 처리 결과
이 Verification 문서 생성/갱신 결과와 참조 문서를 기록한다.

- 처리 결과: {{FILE_RESULT:생성|갱신|미생성}}
- 생성 경로: {{OUTPUT_PATH}}
- 참조 문서:
  - {{IMP_PATH:docs/sdlc/<CYCLE_ID>/4_implementation.md}}
  - {{REFERENCE_1:필요 없으면 삭제}}

# 8. 사용자 결정 필요 항목 요약
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

# 9. Verification Freeze
Release 인계 시점의 확정 플래그와 섹션 참조만 기록한다. 내용 재작성 없이 원본 섹션을 링크로 대신한다.

## 섹션 참조
- 검증 계획: [# 2. 검증 계획](#2-검증-계획)
- 검증 결과: [# 3. 검증 결과](#3-검증-결과)
- 결함/재작업: [# 4. 결함 및 재작업 사항](#4-결함-및-재작업-사항)

## 확정 플래그
- Handoff Decision: {{FREEZE_HANDOFF_DECISION:보류}}
- Handoff Rationale: {{FREEZE_HANDOFF_RATIONALE:검증 완료 및 결함 없음 확인 후 Release로 인계}}
- Ready for Release: {{READY_FOR_RELEASE:false}}
- Confirmed By: {{CONFIRMED_BY:TBD}}
- Confirmed At (KST): {{CONFIRMED_AT_KST:TBD}}

---

# 10. 작성 가이드
*이 섹션은 작성 참고용이다. 문서 완성 후 삭제해도 된다.*

- **검증 항목(VC-N)**: Discovery 성공 기준(S-N)과 반드시 연결한다. FR/NFR 각 항목이 하나 이상의 VC와 연결되어야 한다.
- **검증 방법**: 수동(테스터가 직접 실행), 자동(CI/테스트 코드), 혼합(일부 자동 + 수동 확인) 중 선택한다.
- **성공 기준**: "정상 동작"처럼 모호한 표현 대신 "입력 X에 대해 결과 Y를 반환한다"처럼 측정 가능하게 작성한다.
- **결함(BUG)**: 검증 중 발견된 모든 문제를 기록한다. `Deferred` 처리 시 근거와 후속 처리 계획을 명시한다.
- **Freeze 섹션**: 모든 VC 통과 및 BUG `Open` 없음 확인 후 담당자가 직접 갱신한다.
