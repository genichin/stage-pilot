---
applyTo: "**"
description: "Use when: design, architecture, interface contracts, data flow"
---

# Stage 3 - Design

## Purpose

구현 전 구조와 인터페이스를 명확히 하여 재작업 위험을 줄인다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | confirmed 상태의 Planning 문서, 우선순위 작업, AC, 리스크 정보 |
| 산출물 | Design 문서, 설계 대안 비교, 인터페이스/데이터 흐름, 테스트 전략 |
| 게이트 확인 | 구현 가능한 설계 근거, 인터페이스, 테스트 포인트, 리스크 대응이 모두 존재해야 함 |
| 다음 단계 인계 | Implementation에 파일 변경 방향, 작업 분해 기준, 검증 포인트를 전달 |

## DoR (Entry)

1. Planning 백로그와 수용 기준 존재
2. 핵심 제약사항이 식별됨

## Required Actions

1. 설계 선택지 비교: 최소 2개 대안을 비교해 근거를 남긴다.
2. 인터페이스 정의: 입력/출력/오류 경로를 명시한다.
3. 데이터/흐름 설계: 주요 데이터 경로와 상태 변화를 정리한다.
4. 테스트 전략 연계: 설계와 검증 포인트를 매핑한다.

## Outputs

1. 설계 결정 기록(ADR 또는 동등 문서)
2. 인터페이스/데이터 흐름 정의
3. 테스트 가능성 관점의 설계 메모

## Automation Assets

1. Design 본문 템플릿: .github/templates/design-note.template.md
2. Design 초안 프롬프트: .github/prompts/design-draft.prompt.md
3. Design 재검토 프롬프트: .github/prompts/design-review.prompt.md
4. Design 승인 프롬프트: .github/prompts/design-confirm.prompt.md

## DoD (Exit)

1. Implementation에서 바로 실행 가능한 설계 근거가 존재함
2. 주요 리스크에 대한 대응 전략이 설계에 반영됨
