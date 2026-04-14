# 0. 문서 상태
- 상태: draft
- 승인자: {{DECIDE: 이 Operations의 최종 승인자는 누구인가?}}
- 승인 시각: {{CONFIRM: 배포 완료 후 Operations 확인}}

# 1. 배포 실행 기록
- 입력 Release: {{DATA: docs/sdlc/release/rel-XXX_YYYY-MM-DD_topic.release.md}}
- 배포 방식: {{DATA: 점진 배포/일괄 배포}}
- 배포 환경: {{DATA: production/staging 등}}
- 배포 창(UTC): {{DATA: 시작/종료 시각}}

## 사전 검증
- 체크리스트 점검 결과: {{DATA: 완료/미완료 항목}}
- 롤백 준비 상태: {{DATA: 준비됨/미준비 + 근거}}

## 실행 결과
- 실행 명령/절차 요약: {{DATA: 실행 로그 요약}}
- 결과: {{DATA: 성공/부분성공/실패}}
- 영향 범위: {{DATA: 사용자/시스템 영향}}

## 배포 직후 검증 결과
- 핵심 시나리오 검증: {{DATA: 통과/실패 + 근거}}
- 예외/알림 발생 여부: {{DATA: 있음/없음 + 내용}}

# 2. 모니터링 관찰 결과
| 모니터링 항목 | 측정 지표 | 정상 범위 | 이상 감지 기준 | 관찰 결과 | 비고 |
|---|---|---|---|---|---|
| {{DATA: 항목명}} | {{DATA: 지표}} | {{DATA: 정상 범위}} | {{DATA: 임계치}} | {{DATA: 결과}} |  |

## 관찰 기간
- 집중 관찰 기간: {{DATA: 시작~종료}}
- 일반 관찰 기간: {{DATA: 시작~종료}}

# 3. 인시던트 대응 기록
- 인시던트 발생 여부: {{DATA: 발생/해당없음}}

## 발생한 경우 기록
- 영향도 분류: {{DATA: 사용자/기능/데이터 영향}}
- 타임라인:
  - 탐지 시각(UTC): {{DATA: 시각}}
  - 대응 시작(UTC): {{DATA: 시각}}
  - 완화 시각(UTC): {{DATA: 시각}}
  - 복구 완료(UTC): {{DATA: 시각}}
- 커뮤니케이션:
  - 채널: {{DATA: 채널}}
  - 공지 시각(UTC): {{DATA: 시각}}
  - 업데이트 주기: {{DATA: 주기}}
- 우회책 실행 여부: {{DATA: 실행/미실행 + 내용}}
- 복구 절차 요약: {{DATA: 복구 단계}}

# 4. Postmortem
- What Happened: {{DATA: 사건 개요와 사용자 관찰 증상}}
- Impact: {{DATA: 서비스/사용자/비즈니스 영향}}
- Root Cause: {{DATA: 기술적 원인 + 시스템적 원인}}
- Detection: {{DATA: 탐지 경로/지연 요인/알림 품질}}
- Response: {{DATA: 대응 의사결정 및 실행 평가}}
- Recovery: {{DATA: 복구 절차와 검증 결과}}
- Preventive Actions: {{DATA: 재발 방지 액션(담당자/기한 포함)}}
- Follow-up Tracking: {{DATA: Discovery/Planning 백로그 연결 상태}}

# 5. 다음 반복 환류 항목
| 환류 ID | 개선 항목 | 연결 대상(Discovery/Planning) | 담당자 | 목표일 | 상태 |
|---|---|---|---|---|---|
| FB-001 | {{DATA: 개선 항목}} | {{DATA: dcy/pln 문서 또는 티켓}} | {{DATA: 담당자}} | {{DATA: YYYY-MM-DD}} | {{DATA: 등록됨/대기}} |

# 6. 파일 처리 결과
- 생성/갱신 경로: {{DATA: docs/sdlc/operations/ops-XXX_YYYY-MM-DD_topic.operations.md}}
- 입력 Release 경로: {{DATA: docs/sdlc/release/rel-XXX_YYYY-MM-DD_topic.release.md}}
- 처리 결과: {{DATA: 생성/갱신/검토}}
- 비고: {{DATA: 특이사항}}

# 7. 사용자 결정 필요 항목 요약
## {{DECIDE}}
- (없으면 이 섹션 제거)

## {{CONFIRM}}
- (없으면 이 섹션 제거)

## {{DATA}}
- (없으면 이 섹션 제거)
