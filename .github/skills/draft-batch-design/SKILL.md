---
name: draft-batch-design
description: "Use when: drafting the design document for an existing batch, running /draft-batch-design with a BAT ID, filling docs/batches/<BAT_ID>/design.md, or recording architecture and interface decisions before implementation."
argument-hint: "예: bat-001 또는 docs/batches/bat-001_20260424_scaffold"
user-invocable: true
---

# Purpose

This skill writes the design document for a batch by summarizing architecture, changed areas, key decisions, and edge cases from the batch plan and included REQs.

# Inputs

- `BAT-ID` 또는 batch 경로
- `docs/batches/<BAT_ID>/planning.md`
- 포함된 REQ 문서들
- `docs/batches/<BAT_ID>/design.md`

# Core Rules

- planning이 없거나 범위가 비어 있으면 설계를 진행하지 않는다.
- 설계는 구현 전에 결정해야 할 구조와 인터페이스를 중심으로 적는다.
- REQ 간 공통 설계 전제가 있다면 batch design에 끌어올린다.

# Execution Procedure

1. batch 경로를 확정한다.
2. planning과 포함 REQ를 읽는다.
3. `design.md`에 architecture summary, changed areas, key decisions, edge cases를 채운다.
4. 설계상 blocker가 있으면 문서에 명시하고 구현으로 넘기지 않는다.

# Validation

- design 문서에 Architecture Summary, Changed Areas, Key Decisions, Edge Cases가 모두 있는지 확인한다.
- planning에서 정의한 핵심 범위가 design에서 누락되지 않았는지 확인한다.