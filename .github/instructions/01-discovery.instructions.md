---
applyTo: "**"
description: "Use when: discovery, problem framing, requirement intake, scope definition"
---

# Stage 1 - Discovery

## Purpose

문제와 목표를 명확히 정의하고, 요구사항 후보를 수집한다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | 문제 배경, 사용자/이해관계자 정보, 제약사항 |
| 산출물 | Discovery 문서, 요구사항 목록, 리스크/가정, 성공 기준 |
| 게이트 확인 | 문제 정의, 요구사항, 리스크, 성공 기준이 문서화되어 Planning 입력으로 전달 가능해야 함 |
| 다음 단계 인계 | Planning에 우선순위 후보, 범위 경계, 미해결 질문을 전달 |

## DoR (Entry)

1. 요청 배경 또는 문제 상황이 제공됨
2. 이해관계자 또는 사용자 관점이 최소 1개 이상 식별됨

## Required Actions

1. 문제 정의: 현재 상태, 기대 상태, 제약사항을 정리한다.
2. 요구사항 정제: 기능/비기능 요구사항을 분리한다.
3. 가정/리스크 명시: 불확실한 항목과 영향도를 기록한다.
4. 성공 기준 정의: 완료 판단 기준(측정 가능)을 제안한다.

## Discovery Question Template

### A. Problem and Goal

1. 현재 가장 큰 문제는 무엇인가?
2. 이 변경으로 달성하고 싶은 기대 상태는 무엇인가?
3. 성공을 어떤 지표로 측정할 것인가?

### B. Users and Stakeholders

1. 주요 사용자와 이해관계자는 누구인가?
2. 사용자별로 가장 중요한 시나리오는 무엇인가?
3. 승인/의사결정자는 누구인가?

### C. Scope and Constraints

1. 이번 반복에서 반드시 포함할 범위는 무엇인가?
2. 명시적으로 제외할 범위는 무엇인가?
3. 일정, 비용, 기술, 정책 제약은 무엇인가?

### D. Quality and Risk

1. 성능, 보안, 가용성, 규정 준수 요구사항은 무엇인가?
2. 실패 시 가장 큰 영향은 무엇이며 우회책은 있는가?
3. 현재 정보에서 불확실한 항목은 무엇인가?

### E. Dependency and Data

1. 연동해야 하는 외부 시스템/팀은 무엇인가?
2. 입력/출력 데이터의 출처와 품질 기준은 무엇인가?
3. 마이그레이션 또는 호환성 이슈가 있는가?

## Questioning Rules

1. 질문은 최소 1개 사용자 관점과 1개 운영 관점을 포함한다.
2. 답변이 없는 항목은 가정으로 대체하지 말고 Open Questions로 승격한다.
3. 고위험 항목(보안, 데이터 손실, 장애 확산)은 우선 질문으로 분류한다.
4. Discovery 종료 전 질문-답변 매핑표를 만든다.

## Artifact Convention

1. 저장 폴더: docs/sdlc/discovery/
2. 파일명 형식: dcy-<3자리문서번호>_YYYY-MM-DD_<topic-slug>.discovery.md
3. 문서번호는 Discovery 문서 생성 순번 기준으로 001부터 증가한다. 예: dcy-001, dcy-002
4. topic-slug 규칙: 소문자 영문/숫자/하이픈만 사용한다.
5. 날짜는 문서 생성일 기준으로 유지한다. 문서 수정 시 파일명 날짜는 바꾸지 않는다.
6. Discovery 최종본 하단에는 Discovery Freeze 섹션을 반드시 포함한다.

### Discovery Freeze (Required Fields)

1. Feature Statement
2. In Scope
3. Out of Scope
4. Success Metrics
5. High Open Questions
6. Handoff Decision (Planning 진행 가능/보류)
7. Approver
8. Updated At (UTC)
9. User Confirmation Checklist (필수 확인 항목 + 상태)
10. Freeze Status Flag (Ready for Planning: true/false, Confirmed By, Confirmed At UTC)

## Outputs

1. 문제정의 요약
2. 요구사항 목록(기능/비기능)
3. 리스크/가정 목록
4. 초기 성공 기준
5. 질문-답변 매핑표
6. Discovery 문서 파일(docs/sdlc/discovery/ 경로, 규칙 파일명)
7. Discovery Freeze 섹션

## DoD (Exit)

1. 다음 단계(Planning)에 필요한 우선순위 후보가 존재함
2. 미해결 질문이 명시되어 있음
3. 핵심 질문(A~E)의 미답변 항목이 Open Questions로 정리됨
