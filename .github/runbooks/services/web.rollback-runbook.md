# Web Service Rollback Runbook

## Metadata

1. Service: web
2. Environment: production
3. Owner: frontend team
4. On-call Contact: frontend-oncall
5. Last Updated (UTC): 2026-04-14

## Trigger Conditions

1. JS Error Threshold: 신규 릴리즈 후 오류율 2배 이상
2. Page Load Threshold: p75 LCP > 4.0s for 10 minutes
3. Availability Threshold: 주요 페이지 성공률 < 99.0%
4. Business Impact Trigger: 로그인/결제 전환율 급락

## Pre-rollback Checks

1. 영향 페이지 및 브라우저 범위 확인
2. CDN 캐시 정책 확인
3. 직전 안정 빌드 해시 확인
4. 공지 채널 준비

## Rollback Procedure

1. CDN 라우팅을 이전 빌드로 전환
2. 신규 정적 자산 캐시 무효화
3. 핵심 사용자 플로우 스모크 테스트 실행
4. 오류/성능 지표 확인

## Data Recovery Plan

1. 복원 대상 데이터 범위: 클라이언트 이벤트 손실 구간
2. 복원 방법: 서버 로그 기반 보정 집계
3. 데이터 무결성 검증 방법: 퍼널 단계별 이벤트 대조
4. 복원 예상 시간: 15~30분

## Validation After Rollback

1. 로그인/탐색/결제 플로우 정상
2. JS 오류율 기준치 복귀
3. LCP 및 API 오류율 정상화
4. 사용자 CS 급증 여부 확인

## Communication Plan

1. 내부: 배포 채널 및 온콜 채널 공지
2. 외부: 장애 공지 페이지 업데이트(필요 시)
3. 상태 업데이트 주기: 15분
4. 종료 공지 조건: 30분 이상 안정화

## Post-rollback Follow-up

1. 원인 분석 티켓: INC-WEB-YYYYMMDD
2. 재배포 조건: 크로스브라우저 회귀 테스트 통과
3. 임시 완화책 제거 계획: 48시간 내
4. Postmortem 일정: 24시간 내