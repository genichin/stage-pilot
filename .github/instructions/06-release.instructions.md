---
applyTo: "**"
description: "Use when: release planning, deployment readiness, rollback planning"
---

# Stage 6 - Release

## Purpose

배포 전후 위험을 통제하고 안정적으로 변경을 반영한다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | Verification 결과, 배포 대상 범위, 승인된 예외, 롤백 필요 정보 |
| 산출물 | 배포 체크리스트 결과, 롤백 계획, 릴리즈 노트, 관찰 계획 |
| 게이트 확인 | 롤백 가능한 배포 계획과 운영 관찰 항목이 준비되어야 함 |
| 다음 단계 인계 | Operations에 관찰 포인트, 장애 트리거, 후속 대응 절차를 전달 |

## DoR (Entry)

1. Verification 결과 존재
2. 배포 대상 범위가 확정됨

## Required Actions

1. 배포 체크리스트 점검: 설정, 마이그레이션, 호환성 확인
2. 롤백 계획 준비: 실패 조건과 복구 절차 명시
3. 커뮤니케이션 준비: 변경사항/영향/대응 안내 작성
4. 배포 후 관찰 계획: 모니터링 포인트 정의
5. 롤백 런북 작성: 분리된 템플릿 파일을 기반으로 Trigger/Procedure/Validation을 채운다.
6. 서비스별 런북 인스턴스 최신화: 배포 대상 서비스별 문서를 최신 상태로 유지한다.

## Release Checklist (Detailed)

1. 설정 검증: 환경 변수, 시크릿, 외부 연동 키 유효성 확인
2. 데이터 검증: 마이그레이션 순서, 백업 상태, 복구 가능성 확인
3. 호환성 검증: 이전 버전 클라이언트/API 호환 여부 확인
4. 의존성 검증: 신규/변경 라이브러리 버전 충돌 여부 확인
5. 트래픽 전략: 점진 배포/일괄 배포 방식과 중단 기준 확인
6. 커뮤니케이션: 사용자 공지, 내부 공지, 온콜 담당자 공유 완료

## Rollback Checklist (Detailed)

1. 롤백 트리거 정의: 에러율/지연/장애 지표 임계치 명시
2. 롤백 절차 문서화: 실행 명령, 순서, 책임자, 예상 소요 시간
3. 데이터 롤백 전략: 스키마/데이터 복원 여부와 절차 명시
4. 검증 절차: 롤백 후 핵심 시나리오 정상 동작 확인 항목 정의
5. 커뮤니케이션 절차: 롤백 선언, 영향 공지, 상태 업데이트 채널 명시
6. 사후 조치: 원인 분석 티켓과 재배포 조건 등록

## Outputs

1. 배포 체크리스트 결과
2. 롤백 계획
3. 릴리즈 노트 초안
4. 롤백 실행 런북(.github/templates/rollback-runbook.template.md 기반)
5. 서비스별 롤백 런북 인스턴스(.github/runbooks/services/*.rollback-runbook.md)

## Automation Assets

1. Release 본문 템플릿: .github/templates/release-note.template.md
2. Release 초안 프롬프트: .github/prompts/release-draft.prompt.md
3. Release 재검토 프롬프트: .github/prompts/release-review.prompt.md
4. Release 승인 프롬프트: .github/prompts/release-confirm.prompt.md

## DoD (Exit)

1. 롤백 가능한 배포 계획이 승인됨
2. 운영 관찰 항목이 정의됨
3. 릴리즈/롤백 체크리스트가 근거와 함께 완료됨
