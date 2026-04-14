# Rollback Runbook Template

## Metadata

1. Change ID:
2. Release Version:
3. Environment:
4. Owner:
5. On-call Contact:
6. Last Updated (UTC):

## Trigger Conditions

1. Error Rate Threshold:
2. Latency Threshold:
3. Availability Threshold:
4. Data Integrity Alarm:
5. Business Impact Trigger:

## Pre-rollback Checks

1. 장애 범위 확인(기능/사용자/데이터)
2. 최근 배포 변경점 확인
3. 백업/스냅샷 가용성 확인
4. 커뮤니케이션 채널 준비

## Rollback Procedure

1. 트래픽 차단 또는 점진 축소
2. 이전 안정 버전으로 아티팩트 전환
3. 마이그레이션 롤백 또는 안전 모드 전환
4. 캐시/큐/비동기 작업 상태 정리
5. 서비스 재기동 및 헬스체크 확인

## Data Recovery Plan

1. 복원 대상 데이터 범위:
2. 복원 방법(백업/스냅샷/리플레이):
3. 데이터 무결성 검증 방법:
4. 복원 예상 시간:

## Validation After Rollback

1. 핵심 사용자 시나리오 통과 여부
2. API 오류율 정상화 여부
3. 지연 시간 정상화 여부
4. 데이터 정합성 점검 결과
5. 모니터링 알림 해소 여부

## Communication Plan

1. 롤백 선언 메시지(내부)
2. 영향 공지 메시지(외부)
3. 상태 업데이트 주기
4. 종료 공지 조건

## Post-rollback Follow-up

1. 원인 분석 티켓:
2. 재배포 조건:
3. 임시 완화책 제거 계획:
4. Postmortem 일정:
