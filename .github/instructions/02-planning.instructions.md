---
applyTo: "**"
description: "Use when: planning, prioritization, sprint slicing, estimation"
---

# Stage 2 - Planning

## Purpose

요구사항을 실행 가능한 작업 단위로 분해하고 우선순위를 결정한다.

## Stage Contract

| 항목 | 내용 |
|---|---|
| 입력 | confirmed 또는 전달 가능 상태의 Discovery 산출물, 성공 기준, 리스크 목록 |
| 산출물 | Planning 문서, 우선순위 점수표, 작업별 AC, 범위 경계 |
| 게이트 확인 | 우선순위, AC, In Scope/Out of Scope, 점수 근거가 Design 입력으로 충분해야 함 |
| 다음 단계 인계 | Design에 우선순위 상위 작업, AC, 제약사항, 리스크 대응 우선순위를 전달 |

## DoR (Entry)

1. Discovery 산출물 존재
2. 성공 기준 또는 우선순위 기준 존재

## Required Actions

1. 작업 분해: 기능을 작업 단위로 분할한다.
2. 우선순위화: WSJF 또는 RICE로 점수화해 정렬한다.
3. 범위 설정: 이번 반복에서 포함/제외 항목을 명시한다.
4. 완료 기준 확정: 각 작업의 수용 기준(AC)을 정의한다.

## Prioritization Rules (WSJF/RICE)

1. 기본값은 WSJF를 사용한다.
2. 시장 도달 범위와 정량 사용자 영향이 핵심인 경우 RICE를 사용한다.
3. 두 방식 모두 계산 근거를 기록하지 않으면 우선순위 확정 불가로 처리한다.

### WSJF Formula

WSJF = (Business Value + Time Criticality + Risk Reduction or Opportunity Enablement) / Job Size

1. 각 항목은 동일 스케일(예: 1~10)로 점수화한다.
2. Job Size 추정 근거(복잡도, 의존성, 불확실성)를 함께 기록한다.

### RICE Formula

RICE = (Reach x Impact x Confidence) / Effort

1. Reach 기간 단위(예: 월간 사용자 수)를 명시한다.
2. Confidence가 50% 미만이면 별도 리스크 플래그를 추가한다.
3. Effort는 팀 기준 단위(인일/스토리포인트)를 고정해 사용한다.

## Tie-breaker and Override Rules

1. 점수 동률 시: 리스크 감소 효과가 큰 작업을 우선한다.
2. 규제/보안/장애 복구 관련 항목은 점수와 무관하게 상향 조정 가능하다.
3. 상향/하향 조정 시 사유와 승인자를 기록한다.

## Sample Backlog Scoring Template

### WSJF Sample Table

| Item ID | Work Item | Business Value (1-10) | Time Criticality (1-10) | RR/OE (1-10) | Job Size (1-10) | WSJF Score | Priority |
|---|---|---:|---:|---:|---:|---:|---:|
| P-001 |  |  |  |  |  |  |  |
| P-002 |  |  |  |  |  |  |  |
| P-003 |  |  |  |  |  |  |  |

계산식: WSJF Score = (Business Value + Time Criticality + RR/OE) / Job Size

### RICE Sample Table

| Item ID | Work Item | Reach (period) | Impact | Confidence (%) | Effort | RICE Score | Priority |
|---|---|---:|---:|---:|---:|---:|---:|
| P-001 |  |  |  |  |  |  |  |
| P-002 |  |  |  |  |  |  |  |
| P-003 |  |  |  |  |  |  |  |

계산식: RICE Score = (Reach x Impact x Confidence) / Effort

### Scoring Notes Template

1. Scoring Scale: (예: 1~10, Impact는 0.25/0.5/1/2/3)
2. Reach Period: (예: monthly active users)
3. Confidence Source: (사용 데이터, 인터뷰, 실험)
4. Override Reason and Approver: (예외 조정 사유/승인자)

## Optional Automation Assets

1. CSV 템플릿: .github/templates/planning-backlog-scores.template.csv
2. 시트 템플릿: .github/templates/planning-scoring-sheet.template.csv
3. 계산 스크립트: .github/tools/calc_priority_scores.sh
4. 점수 산출물 저장 경로(기본): docs/sdlc/planning/planning-backlog-scores.out.csv
5. Planning 본문 템플릿: .github/templates/planning-note.template.md

### Automation Usage

1. 백로그 항목을 CSV 템플릿에 입력한다.
2. 스크립트를 실행해 wsjf_score/rice_score/selected_score/priority를 산출하고, 결과를 docs/sdlc/planning/planning-backlog-scores.out.csv에 저장한다.
3. 산출 결과를 반복 계획 문서의 점수표 근거로 첨부한다.

## Outputs

1. 반복 계획(백로그 우선순위)
2. 작업별 수용 기준
3. 범위 경계(Out of Scope 포함)
4. 우선순위 점수표(WSJF 또는 RICE 계산 근거 포함)

## DoD (Exit)

1. Design 단계에 전달 가능한 우선순위 백로그가 존재함
2. 작업 단위별 완료 기준이 검증 가능 형태임
3. 우선순위 상위 항목의 계산 근거와 조정 사유가 추적 가능함
