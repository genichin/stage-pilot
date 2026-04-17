# 0. 문서 상태
이 문서의 현재 상태와 식별 정보를 기록한다. 문서 추적과 승인 흐름에 필요한 최소 메타데이터를 적는다.

- 상태: {{DOC_STATUS:draft|review|confirmed}}
- 문서 ID: {{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}
- 이슈명: {{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}
- 참조 Verification: {{VER_PATH:docs/sdlc/<CYCLE_ID>/5_verification.md}}
- 작성 시각(KST): {{CREATED_AT_KST:TBD}}
- 마지막 갱신 시각(KST): {{UPDATED_AT_KST:TBD}}

# 1. Verification 인계 요약
Verification에서 완료된 핵심 내용을 요약한다. 원본은 5_verification.md를 참조하며, 이 섹션은 Release 작업의 입력 기준선이 된다.

## 이슈 목적
- {{REL_ISSUE_PURPOSE:Verification 이슈명과 핵심 목적 1-2줄}}

## 검증 결과 요약
- 검증 항목 수: {{REL_VC_TOTAL}}개
- 전체 통과 여부: {{REL_VC_ALL_PASS:true|false}}
- 결함(BUG) 잔여: {{REL_BUG_REMAIN:0}}건

## 이월된 오픈 질문 / 리스크
Verification에서 `Deferred` 처리되어 Release 단계에서 해소해야 하는 항목을 기록한다.

- {{REL_DEFERRED_ITEM_1:없으면 "없음"}}
- {{REL_DEFERRED_ITEM_2:필요 없으면 삭제}}

# 2. 배포 준비
배포 환경, 배포 전 체크리스트, 배포 순서를 정의한다.

## 배포 환경
- 대상 환경: {{REL_TARGET_ENV:예. production, staging}}
- 배포 방식: {{REL_DEPLOY_METHOD:예. git push, CI/CD 파이프라인, 수동 복사}}
- 배포 도구/채널: {{REL_DEPLOY_TOOL:예. GitHub Actions, 수동 SSH, 없음}}

## 배포 전 체크리스트
배포 실행 전에 확인해야 할 항목을 나열한다.

- [ ] {{REL_PRE_CHECK_1:예. 대상 환경 설정 파일 백업 완료}}
- [ ] {{REL_PRE_CHECK_2:예. 롤백 계획 확인 완료}}
- [ ] {{REL_PRE_CHECK_3:필요 없으면 삭제}}

## 배포 순서
변경 사항의 배포 순서를 적는다. 의존 관계가 있는 경우 순서를 명확히 기술한다.

1. {{REL_STEP_1:예. 설정 파일 배포}}
2. {{REL_STEP_2:예. 코드 변경 배포}}
3. {{REL_STEP_3:필요 없으면 삭제}}

# 3. 롤백 계획
배포 후 문제가 발생했을 때 이전 상태로 되돌리는 방법을 기술한다.

## 롤백 조건
아래 조건 중 하나라도 충족되면 롤백을 즉시 실행한다.

- {{REL_ROLLBACK_TRIGGER_1:예. 배포 후 핵심 기능 오류 발생}}
- {{REL_ROLLBACK_TRIGGER_2:예. 성능 지표가 임계값 이하로 하락}}
- {{REL_ROLLBACK_TRIGGER_3:필요 없으면 삭제}}

## 롤백 절차
1. {{REL_ROLLBACK_STEP_1:예. 이전 버전 파일/설정 복원}}
2. {{REL_ROLLBACK_STEP_2:예. 배포 채널에서 롤백 실행}}
3. {{REL_ROLLBACK_STEP_3:필요 없으면 삭제}}

## 롤백 담당자
- {{REL_ROLLBACK_OWNER:TBD}}

# 4. 배포 후 확인
배포 완료 후 정상 동작을 확인하는 방법을 기술한다.

## 스모크 테스트 항목
| 항목 | 확인 방법 | 성공 기준 |
|------|---------|---------|
| {{REL_SMOKE_ITEM_1}} | {{REL_SMOKE_METHOD_1}} | {{REL_SMOKE_CRITERIA_1}} |
| {{REL_SMOKE_ITEM_2}} | {{REL_SMOKE_METHOD_2}} | {{REL_SMOKE_CRITERIA_2}} |
| {{REL_SMOKE_ITEM_3:필요 없으면 삭제}} | {{REL_SMOKE_METHOD_3}} | {{REL_SMOKE_CRITERIA_3}} |

## 모니터링 확인 항목
배포 후 일정 시간 동안 모니터링해야 하는 지표나 로그를 기록한다.

- {{REL_MONITOR_1:예. 오류 로그 발생 여부 확인 (1시간)}}
- {{REL_MONITOR_2:필요 없으면 삭제}}

# 5. 리스크 및 오픈 질문
Release 단계에서 새로 식별된 리스크와 오픈 질문을 기록한다.

## 리스크
- R-1 ({{REL_RISK_LEVEL_1:High|Medium|Low}}): {{REL_RISK_1}}
  - 완화 방안: {{REL_MITIGATION_1}}
- R-2 ({{REL_RISK_LEVEL_2:High|Medium|Low}}): {{REL_RISK_2:필요 없으면 삭제}}
  - 완화 방안: {{REL_MITIGATION_2:필요 없으면 삭제}}

## 오픈 질문
- OQ-1: {{REL_OPEN_QUESTION_1}}
  - 상태: {{REL_OQ_STATUS_1:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{REL_OQ_ACTION_1}}
  - 종료 조건: {{REL_OQ_EXIT_1}}
- OQ-2: {{REL_OPEN_QUESTION_2:필요 없으면 삭제}}
  - 상태: {{REL_OQ_STATUS_2:Open|Answered|Deferred|Dropped}}
  - 처리 방안: {{REL_OQ_ACTION_2}}
  - 종료 조건: {{REL_OQ_EXIT_2}}

# 6. Operations로 넘기기 전 확인 체크
Operations 단계로 넘기기 전에 무엇이 완료되어야 하는지 확인한다.

- [ ] 배포 완료 및 스모크 테스트 통과
  - 기준: {{CHECK_DEPLOY:배포 절차대로 실행되었고 스모크 테스트 전 항목이 통과되었는가}}
- [ ] 롤백 계획 확정
  - 기준: {{CHECK_ROLLBACK:롤백 조건, 절차, 담당자가 모두 명시되었는가}}
- [ ] 모든 오픈 질문(OQ) `Open` 상태 없음 확인
  - 기준: OQ 목록에 `Open` 상태 항목이 0개이거나, 잔여 항목 전부 `Deferred` 처리 완료
- [ ] Freeze 확정 담당자(CONFIRMED_BY) 지정
  - 기준: {{CHECK_CONFIRMEDBY_CRITERIA:문서 승인 또는 인계 결정을 내릴 담당자가 명시되어야 한다}}

# 7. 파일 처리 결과
이 Release 문서 생성/갱신 결과와 참조 문서를 기록한다.

- 처리 결과: {{FILE_RESULT:생성|갱신|미생성}}
- 생성 경로: {{OUTPUT_PATH}}
- 참조 문서:
  - {{VER_PATH:docs/sdlc/<CYCLE_ID>/5_verification.md}}
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

# 9. Release Freeze
Operations 인계 시점의 확정 플래그와 섹션 참조만 기록한다. 내용 재작성 없이 원본 섹션을 링크로 대신한다.

## 섹션 참조
- 배포 준비: [# 2. 배포 준비](#2-배포-준비)
- 롤백 계획: [# 3. 롤백 계획](#3-롤백-계획)
- 배포 후 확인: [# 4. 배포 후 확인](#4-배포-후-확인)

## 확정 플래그
- Handoff Decision: {{FREEZE_HANDOFF_DECISION:보류}}
- Handoff Rationale: {{FREEZE_HANDOFF_RATIONALE:배포 완료 및 스모크 테스트 통과 후 Operations로 인계}}
- Ready for Operations: {{READY_FOR_OPERATIONS:false}}
- Confirmed By: {{CONFIRMED_BY:TBD}}
- Confirmed At (KST): {{CONFIRMED_AT_KST:TBD}}

---

# 10. 작성 가이드
*이 섹션은 작성 참고용이다. 문서 완성 후 삭제해도 된다.*

- **배포 방식**: git 기반 프로젝트는 커밋 해시, 브랜치, 태그를 명시하면 롤백이 쉽다.
- **롤백 계획**: "문제가 생기면 롤백한다"가 아니라 구체적인 조건, 절차, 담당자를 미리 정의한다.
- **스모크 테스트**: 배포 직후 서비스가 최소한 동작하는지 확인하는 핵심 시나리오만 포함한다. 전체 기능 검증은 Verification 단계에서 완료한 것을 전제로 한다.
- **모니터링**: 배포 후 지켜봐야 하는 지표(오류율, 응답 시간, 로그 패턴 등)를 구체적으로 기록한다.
