---
applyTo: "**"
description: "Use when: verification, test review, regression checks, quality gate"
---

# Stage 5 - Verification

## Purpose

변경이 요구사항을 만족하고 기존 동작을 해치지 않았는지 확인한다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | Implementation 변경 결과, 테스트 시나리오, 수용 기준, 리스크 정보 |
| 산출물 | 검증 결과 요약, 결함 목록, 품질 게이트 판정, 배포 가능 여부 |
| 게이트 확인 | Blocker 0건, Major 0건 또는 승인된 예외, 테스트 근거 첨부 상태여야 함 |
| 다음 단계 인계 | Release에 배포 가능 여부, 예외 승인 정보, 잔여 리스크를 전달 |

## DoR (Entry)

1. Implementation 산출물 존재
2. 수용 기준과 테스트 시나리오 존재

## Required Actions

1. 수용 기준 검증: AC 충족 여부를 확인한다.
2. 회귀 리스크 점검: 영향 영역을 기반으로 회귀 테스트를 수행한다.
3. 결함 분류: Blocker/Major/Minor로 구분한다.
4. 배포 준비성 판단: 잔여 리스크와 우회책을 기록한다.

## Strict Quality Gates

1. Blocker 결함 1건 이상이면 자동 배포 불가 상태로 분류한다.
2. Major 결함은 승인된 예외 없이 0건이어야 한다.
3. 변경 코드 경로의 테스트 실행 증거(로그/리포트)가 없으면 검증 실패로 처리한다.
4. 신규 기능은 최소 1개의 정상 경로 테스트와 1개의 예외 경로 테스트를 포함해야 한다.
5. 회귀 테스트에서 실패가 발생하면 원인 분석 또는 롤백 계획 없이 통과 처리할 수 없다.
6. 보안 또는 데이터 무결성 관련 변경은 전용 체크 항목 결과를 첨부해야 한다.

## Defect Severity Policy

1. Blocker: 서비스 중단, 데이터 손실/오염, 보안 취약점 악용 가능 상태
2. Major: 핵심 기능 오동작, 우회 가능하지만 사용자 영향이 큰 결함
3. Minor: 비핵심 기능 이슈, 문구/표시 오류, 영향이 제한적인 결함

## Required Evidence

1. AC별 검증 결과(통과/실패/보류)
2. 테스트 실행 결과 요약(실행 범위, 실패 항목, 재현 여부)
3. 잔여 리스크와 완화책
4. 승인된 예외 목록(사유, 승인자, 유효 기간)

## Exception Approval Workflow (Template)

1. Trigger: Major 결함 또는 검증 미충족 항목이 릴리즈 일정상 즉시 수정 불가
2. Draft Exception: 요청자(보통 Builder/Reviewer)가 아래 템플릿 작성
3. Review: Reviewer가 영향도와 완화책 타당성 검토
4. Approve: 지정 승인자(예: Tech Lead, QA Lead, Product Owner) 중 최소 1명 승인
5. Expiry Control: 유효 기간 만료 전 재검증 또는 예외 연장 재승인
6. Closure: 예외 해소 후 결과와 증빙을 검증 리포트에 반영

## Approval Authority Matrix

1. Minor + Low/Medium Risk: Reviewer 또는 QA Lead 단독 승인 가능, 최대 유효기간 14일
2. Major + Medium Risk: Reviewer 검토 후 Tech Lead + QA Lead 2인 승인, 최대 유효기간 7일
3. Major + High Risk: Reviewer 검토 후 Tech Lead + Product Owner 2인 승인, 최대 유효기간 3일
4. Security/Data Integrity 관련 예외: Security Owner + Tech Lead + Product Owner 3인 승인, 최대 유효기간 72시간
5. 동일 예외 2회 이상 연장은 최초 승인자 외 추가 승인자 1인 이상이 필요

## Approval Policy Rules

1. 승인자는 요청자(작성자)와 동일 인물일 수 없다.
2. Valid Until은 UTC 기준으로 명시하며 만료 시 자동 재검증 상태로 전환한다.
3. 만료 전 재검증 실패 시 예외는 즉시 종료되고 배포 가능 상태를 재평가한다.
4. 예외 승인 건은 Release 전달 시 승인 이력(승인자, 시각, 유효기간)을 포함해야 한다.

### Exception Record Template

| Field | Value |
|---|---|
| Exception ID | EX-YYYYMMDD-001 |
| Related Change |  |
| Defect Severity | Major / Minor |
| Reason |  |
| User Impact |  |
| Risk Level | High / Medium / Low |
| Mitigation |  |
| Approver(s) |  |
| Approval Scope | Minor-Low/Medium, Major-Medium, Major-High, Security/Data Integrity |
| Approved At (UTC) |  |
| Valid Until (UTC) |  |
| Re-validation Owner |  |
| Re-validation Date |  |
| Final Closure Evidence |  |

## Outputs

1. 검증 결과 요약
2. 발견 결함 목록 및 우선순위
3. 배포 가능 여부 판단
4. 품질 게이트 체크 결과(통과/실패 + 근거)

## Automation Assets

1. Verification 본문 템플릿: .github/templates/verification-note.template.md
2. Verification 초안 프롬프트: .github/prompts/verification-draft.prompt.md
3. Verification 재검토 프롬프트: .github/prompts/verification-review.prompt.md
4. Verification 승인 프롬프트: .github/prompts/verification-confirm.prompt.md

## DoD (Exit)

1. Blocker 결함 0건
2. Major 결함 0건 또는 승인된 예외 문서 존재
3. 테스트 및 회귀 검증 근거가 첨부됨
4. Release 단계 전달 가능한 품질 상태 보고가 있음
