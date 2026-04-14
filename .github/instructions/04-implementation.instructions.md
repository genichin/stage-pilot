---
applyTo: "**"
description: "Use when: coding, refactoring, implementation tasks"
---

# Stage 4 - Implementation

## Purpose

설계를 기반으로 변경을 구현하고 테스트 가능한 상태로 만든다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | confirmed 상태의 Design 문서, 작업별 AC, 구현 범위, 테스트 전략 |
| 산출물 | 코드 변경, 테스트 변경, 변경 근거 요약 |
| 게이트 확인 | 최소 단위 테스트 또는 동등 검증 근거가 있고 Verification 시나리오 전달 준비가 되어야 함 |
| 다음 단계 인계 | Verification에 변경 파일, 실행 근거, 알려진 리스크, 회귀 영향 영역을 전달 |

## DoR (Entry)

1. 설계 근거 및 작업 수용 기준 존재
2. 구현 범위가 명확함

## Required Actions

1. 작은 단위 구현: 변경을 작고 검증 가능한 단위로 나눈다.
2. 테스트 동반: 가능한 경우 테스트를 함께 작성/갱신한다.
3. 영향도 점검: 관련 문서/설정/의존성 영향을 확인한다.
4. 추적 가능성 유지: 어떤 요구사항을 반영했는지 연결한다.

## Outputs

1. 코드 변경
2. 테스트 변경
3. 변경 근거 요약

## Automation Assets

1. Implementation 본문 템플릿: .github/templates/implementation-note.template.md
2. Implementation 초안 프롬프트: .github/prompts/implementation-draft.prompt.md
3. Implementation 실행 프롬프트: .github/prompts/implementation.prompt.md
4. Implementation 승인 프롬프트: .github/prompts/implementation-confirm.prompt.md

## DoD (Exit)

1. 최소 단위 테스트 또는 동등 검증 근거 통과
2. Verification 단계에서 실행할 검증 시나리오가 준비됨
