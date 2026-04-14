# Worker Service Rollback Runbook

## Metadata

1. Service: worker
2. Environment: production
3. Owner: platform team
4. On-call Contact: platform-oncall
5. Last Updated (UTC): 2026-04-14

## Trigger Conditions

1. Queue Backlog Threshold: 대기 작업 10,000건 초과 10분 지속
2. Failure Threshold: 작업 실패율 > 3% for 10 minutes
3. Processing Delay Threshold: 평균 처리 지연 > 2x baseline
4. Data Integrity Alarm: 중복 처리 또는 누락 처리 감지
5. Business Impact Trigger: 정산/알림 지연 사용자 영향 확대

## Pre-rollback Checks

1. 실패 작업 샘플링 및 영향 범위 확인
2. 재처리 가능 여부 확인
3. 직전 안정 버전 아티팩트 확인
4. 공지 채널 준비

## Rollback Procedure

1. 신규 작업 소비 일시 중단
2. 안정 버전으로 워커 교체
3. 단계적 소비 재개(10% -> 50% -> 100%)
4. 실패/처리율 지표 확인

## Data Recovery Plan

1. 복원 대상 데이터 범위: 누락/중복 처리된 이벤트
2. 복원 방법: dead-letter queue 재처리 + idempotency 검증
3. 데이터 무결성 검증 방법: 이벤트 카운트/체크섬 대조
4. 복원 예상 시간: 30~60분

## Validation After Rollback

1. backlog 감소 추세 확인
2. 실패율 1% 이하 복귀
3. 중복 처리 경보 해제
4. 핵심 배치 완료 시간 정상화

## Communication Plan

1. 내부: 대응 진행 상황 15분 주기 공유
2. 외부: SLA 영향 시 사전 공지
3. 종료 공지 조건: backlog 정상화 및 실패율 안정화

## Post-rollback Follow-up

1. 원인 분석 티켓: INC-WORKER-YYYYMMDD
2. 재배포 조건: 부하 테스트 재통과
3. 임시 완화책 제거 계획: 72시간 내
4. Postmortem 일정: 24시간 내