# API Service Rollback Runbook

## Metadata

1. Service: api
2. Runtime: uvicorn direct run
3. Environment: production
4. Owner: backend team
5. On-call Contact: backend-oncall
6. Last Updated (UTC): 2026-04-14

## Trigger Conditions

1. Error Rate Threshold: 5xx > 2% for 5 minutes
2. Latency Threshold: p95 > 1200ms for 10 minutes
3. Availability Threshold: successful request rate < 99.5%
4. Data Integrity Alarm: write/read mismatch alerts > 0
5. Business Impact Trigger: 결제/주문 API 실패 다수 발생

## Pre-rollback Checks

1. 장애 범위 확인(엔드포인트/사용자/데이터)
2. 최근 릴리즈 커밋과 변경 DB 스크립트 확인
3. 직전 안정 배포 아티팩트 식별
4. 공지 채널(내부/외부) 준비

## Rollback Procedure

1. 신규 배포 트래픽 중단
2. 안정 버전 코드로 교체
3. uvicorn 프로세스 재기동
4. 헬스체크와 핵심 API 호출 검증

## Data Recovery Plan

1. 복원 대상 데이터 범위: 최근 배포 이후 변경분
2. 복원 방법: 백업 스냅샷 + 트랜잭션 로그 검증
3. 데이터 무결성 검증 방법: 주문/결제 집계 대조
4. 복원 예상 시간: 20~40분

## Validation After Rollback

1. /health, /ready 정상
2. 로그인/주문/결제 정상 시나리오 통과
3. 5xx 비율 0.5% 이하 복귀
4. p95 지연 700ms 이하 복귀

## Communication Plan

1. 내부: 롤백 시작/완료 시점 공유
2. 외부: 사용자 영향 공지(필요 시)
3. 상태 업데이트 주기: 15분
4. 종료 공지 조건: 핵심 지표 30분 안정화

## Post-rollback Follow-up

1. 원인 분석 티켓: INC-API-YYYYMMDD
2. 재배포 조건: 회귀 테스트 + 성능 검증 통과
3. 임시 완화책 제거 계획: 48시간 내 정리
4. Postmortem 일정: 24시간 내