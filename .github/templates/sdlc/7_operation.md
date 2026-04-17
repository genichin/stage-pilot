# 0. 문서 상태
이 문서의 현재 상태와 식별 정보를 기록한다. 문서 추적과 승인 흐름에 필요한 최소 메타데이터를 적는다.

- 상태: {{DOC_STATUS:draft|review|confirmed}}
- 문서 ID: {{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}
- 이슈명: {{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}
- 참조 Release: {{REL_PATH:docs/sdlc/<CYCLE_ID>/6_release.md}}
- 작성 시각(KST): {{CREATED_AT_KST:TBD}}
- 마지막 갱신 시각(KST): {{UPDATED_AT_KST:TBD}}

# 1. Release 인계 요약
Release에서 완료된 핵심 내용을 요약한다. 원본은 6_release.md를 참조하며, 이 섹션은 Operations 작업의 입력 기준선이 된다.

## 이슈 목적
- {{OPS_ISSUE_PURPOSE:Release 이슈명과 핵심 목적 1-2줄}}

## 배포 결과 요약
- 배포 환경: {{OPS_DEPLOY_ENV:예. production}}
- 배포 완료 시각(KST): {{OPS_DEPLOYED_AT:TBD}}
- 스모크 테스트 결과: {{OPS_SMOKE_RESULT:통과|일부 실패|미완료}}

## 이월된 오픈 질문 / 리스크
Release에서 `Deferred` 처리되어 Operations 단계에서 해소해야 하는 항목을 기록한다.

- {{OPS_DEFERRED_ITEM_1:없으면 "없음"}}
- {{OPS_DEFERRED_ITEM_2:필요 없으면 삭제}}

# 2. 운영 모니터링
배포 후 지속적으로 모니터링해야 하는 항목과 기준을 정의한다.

## 모니터링 항목
| 항목 | 확인 방법 | 임계값 / 이상 기준 | 대응 방안 |
|------|---------|----------------|---------|
| {{OPS_MONITOR_ITEM_1}} | {{OPS_MONITOR_METHOD_1}} | {{OPS_MONITOR_THRESHOLD_1}} | {{OPS_MONITOR_ACTION_1}} |
| {{OPS_MONITOR_ITEM_2}} | {{OPS_MONITOR_METHOD_2}} | {{OPS_MONITOR_THRESHOLD_2}} | {{OPS_MONITOR_ACTION_2}} |
| {{OPS_MONITOR_ITEM_3:필요 없으면 삭제}} | {{OPS_MONITOR_METHOD_3}} | {{OPS_MONITOR_THRESHOLD_3}} | {{OPS_MONITOR_ACTION_3}} |

## 모니터링 담당자
- {{OPS_MONITOR_OWNER:TBD}}

# 3. 운영 절차 (런북)
이 변경 사항과 관련된 운영 중 발생할 수 있는 상황별 대응 절차를 정의한다.

## 정상 운영 확인 절차
배포 후 일정 주기로 정상 동작을 확인하는 절차를 기술한다.

1. {{OPS_ROUTINE_STEP_1:예. 오류 로그 확인 (일 1회)}}
2. {{OPS_ROUTINE_STEP_2:필요 없으면 삭제}}

## 장애 대응 절차
이 변경과 관련된 장애가 발생했을 때의 초기 대응 절차를 기술한다.

1. {{OPS_INCIDENT_STEP_1:예. 오류 로그에서 관련 스택 트레이스 확인}}
2. {{OPS_INCIDENT_STEP_2:예. 롤백 판단 기준 확인 후 롤백 또는 핫픽스 결정}}
3. {{OPS_INCIDENT_STEP_3:필요 없으면 삭제}}

## 에스컬레이션 경로
장애 대응 중 에스컬레이션이 필요한 경우 연락 대상을 기록한다.

- {{OPS_ESCALATION_1:TBD}}

# 4. 운영 중 발생한 이슈
운영 중 발견된 이슈를 기록한다. 초안 생성 시 비워 두고 운영 중 갱신한다.

- {{OPS_ISSUE_1:없음 (운영 중 발견 시 기록)}}

# 5. 리스크 및 오픈 질문
Operations 단계에서 새로 식별된 리스크와 오픈 질문을 기록한다.

## 리스크
- R-1 ({{OPS_RISK_LEVEL_1:High|Medium|Low}}): {{OPS_RISK_1}}
  - 완화 방안: {{OPS_MITIGATION_1}}
- R-2 ({{OPS_RISK_LEVEL_2:High|Medium|Low}}): {{OPS_RISK_2:필요 없으면 삭제}}
  - 완화 방안: {{OPS_MITIGATION_2:필요 없으면 삭제}}

## 오픈 질문
- OQ-1: {{OPS_OPEN_QUESTION_1}}
  - 상태: {{OPS_OQ_STATUS_1:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{OPS_OQ_ACTION_1}}
  - 종료 조건: {{OPS_OQ_EXIT_1}}
- OQ-2: {{OPS_OPEN_QUESTION_2:필요 없으면 삭제}}
  - 상태: {{OPS_OQ_STATUS_2:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{OPS_OQ_ACTION_2}}
  - 종료 조건: {{OPS_OQ_EXIT_2}}

# 6. 다음 Discovery 환류
운영 중 발견된 인사이트와 개선 사항을 다음 SDLC Discovery의 입력으로 기록한다.

- {{OPS_FEEDBACK_1:없으면 "없음"}}
- {{OPS_FEEDBACK_2:필요 없으면 삭제}}
- {{OPS_FEEDBACK_3:필요 없으면 삭제}}

# 7. 확인 체크
Operations 문서가 완성되었는지 확인한다.

- [ ] 모니터링 항목 및 임계값 정의 완료
  - 기준: {{CHECK_MONITORING:모니터링 항목에 임계값과 대응 방안이 명시되어야 한다}}
- [ ] 런북(정상 운영/장애 대응 절차) 정의 완료
  - 기준: {{CHECK_RUNBOOK:운영 중 발생 가능한 상황에 대한 절차가 1단계 이상 있어야 한다}}
- [ ] 에스컬레이션 경로 정의 완료
  - 기준: {{CHECK_ESCALATION:장애 시 연락할 담당자가 명시되어야 한다}}
- [ ] 다음 Discovery 환류 항목 작성 (없으면 "없음" 기재)
  - 기준: OPS_FEEDBACK 항목이 "없음"이 아닐 경우 구체적으로 기술되었는가
- [ ] Freeze 확정 담당자(CONFIRMED_BY) 지정
  - 기준: {{CHECK_CONFIRMEDBY_CRITERIA:문서 승인 담당자가 명시되어야 한다}}

# 8. 파일 처리 결과
이 Operations 문서 생성/갱신 결과와 참조 문서를 기록한다.

- 처리 결과: {{FILE_RESULT:생성|갱신|미생성}}
- 생성 경로: {{OUTPUT_PATH}}
- 참조 문서:
  - {{REL_PATH:docs/sdlc/<CYCLE_ID>/6_release.md}}
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

# 10. Operations Freeze
이 SDLC 주기의 최종 확정 플래그를 기록한다.

## 섹션 참조
- 운영 모니터링: [# 2. 운영 모니터링](#2-운영-모니터링)
- 런북: [# 3. 운영 절차 런북](#3-운영-절차-런북)
- 다음 Discovery 환류: [# 6. 다음 Discovery 환류](#6-다음-discovery-환류)

## 확정 플래그
- Handoff Decision: {{FREEZE_HANDOFF_DECISION:보류}}
- Handoff Rationale: {{FREEZE_HANDOFF_RATIONALE:모니터링 안정화 및 런북 완비 후 주기 완료}}
- SDLC 주기 완료: {{SDLC_CYCLE_COMPLETE:false}}
- Confirmed By: {{CONFIRMED_BY:TBD}}
- Confirmed At (KST): {{CONFIRMED_AT_KST:TBD}}

---

# 11. 작성 가이드
*이 섹션은 작성 참고용이다. 문서 완성 후 삭제해도 된다.*

- **모니터링 항목**: "오류가 없는지 확인"처럼 모호한 기준 대신 "5xx 오류율 1% 이상 시 알림" 같이 수치화된 임계값을 명시한다.
- **런북**: 실제 운영자가 참고할 수 있도록 구체적인 명령, 경로, 연락처를 기록한다.
- **다음 Discovery 환류**: 이 주기에서 발견된 기술 부채, 개선 아이디어, 범위에서 제외된 요구사항 등을 기록한다. 이 항목이 다음 `/new-sdlc` 의 입력이 된다.
- **SDLC 주기 완료**: 모니터링 안정화 기간(배포 후 일정 시간 경과, 이상 없음) 확인 후 `true`로 변경한다.
