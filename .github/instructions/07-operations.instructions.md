---
applyTo: "**"
description: "Use when: operations, monitoring, incident handling, postmortem"
---

# Stage 7 - Operations

## Purpose

배포 후 서비스 상태를 관찰하고 문제를 빠르게 복구하며 학습을 축적한다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | Release 결과, 관찰 포인트, 롤백/장애 대응 절차 |
| 산출물 | 운영 상태 리포트, 인시던트 기록, Postmortem, 개선 백로그 |
| 게이트 확인 | 운영 이슈가 추적 가능하게 기록되고 다음 사이클 입력으로 연결되어야 함 |
| 다음 단계 인계 | Discovery/Planning에 운영 학습과 개선 항목을 환류 |

## DoR (Entry)

1. Release 완료
2. 모니터링 포인트가 정의됨

## Required Actions

1. 상태 모니터링: 지표/로그/알림을 확인한다.
2. 이슈 대응: 장애 영향도와 복구 우선순위를 판단한다.
3. 사후분석: 원인, 탐지, 대응, 재발방지 항목을 기록한다.
4. 환류 연결: 개선 항목을 Discovery/Planning 입력으로 등록한다.

## Incident Checklist (Detailed)

1. 영향도 분류: 사용자 영향 범위, 기능 영향, 데이터 영향 분류
2. 타임라인 기록: 탐지 시각, 대응 시작, 완화 시각, 복구 완료 시각
3. 커뮤니케이션 기록: 공지 채널, 공지 시각, 담당자, 업데이트 주기
4. 우회책 실행 여부: 임시 완화 조치와 한계 기록
5. 재발 위험 평가: 동일 패턴 재발 가능성 및 단기 통제 방안 기록

## Postmortem Checklist (Detailed)

1. What Happened: 사건 개요와 사용자 관찰 증상
2. Impact: 서비스/사용자/비즈니스 영향 정량화
3. Root Cause: 기술적 원인과 시스템적 원인 분리
4. Detection: 탐지 경로, 지연 요인, 알림 품질 평가
5. Response: 대응 의사결정과 실행 타임라인 평가
6. Recovery: 복구 절차와 검증 결과
7. Preventive Actions: 재발 방지 액션 아이템(담당자, 마감일 포함)
8. Follow-up Tracking: Discovery/Planning 백로그 연결 상태

## Outputs

1. 운영 상태 리포트
2. 인시던트 기록 및 Postmortem
3. 다음 반복을 위한 개선 백로그
4. 액션 아이템 추적표(Owner, Due Date, Status)

## Automation Assets

1. Operations 본문 템플릿: .github/templates/operations-note.template.md
2. Operations 초안 프롬프트: .github/prompts/operation-draft.prompt.md
3. Operations 재검토 프롬프트: .github/prompts/operation-review.prompt.md
4. Operations 이슈 분류 프롬프트: .github/prompts/operation-triage.prompt.md
5. Operations 승인 프롬프트: .github/prompts/operation-confirm.prompt.md
6. Operations 본문 저장 경로(기본): docs/sdlc/operations/
7. Operations 문서 ID 패턴: ops-<3자리순차>_YYYY-MM-DD_<topic-slug>.operations.md

### Automation Usage

1. Release 부터 Operations 초안 자동 생성: `/operation-draft rel-001`
2. Operations 문서 검토: `/operation-review rel-001` (단순 검토, 수정 없음)
3. 보고된 문제 분류 및 환류 경로 결정: `/operation-triage <issue summary>`
4. Operations 승인 처리: `/operation-confirm rel-001` (confirmed 상태 전환 + 플레이스홀더 정리)

## DoD (Exit)

1. 운영 이슈가 추적 가능한 티켓/백로그로 전환됨
2. 학습 사항이 다음 사이클 입력으로 연결됨
3. Postmortem 체크리스트가 누락 없이 작성됨
