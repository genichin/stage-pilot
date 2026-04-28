---
name: confirm-discovery
description: "Use when: running /confirm-discovery with dcy-xyz or a Discovery path, re-checking the current repository state against docs/discovery/*.md, filling AI-resolvable placeholders or inconsistencies, and promoting the Discovery to confirmed when it is ready for REQ drafting in the Requirements phase."
argument-hint: "예: dcy-001 또는 docs/discovery/dcy-001_20260424_krx-stock-picker-python-scaffold.md"
user-invocable: true
---

# Purpose

This Skill revalidates an existing Discovery document against the current repository state, fills anything the AI can resolve from local evidence, and promotes the document to `confirmed` only when REQ drafting handoff has no remaining blockers.

이 Skill의 결과는 아래 두 경우로 나뉜다.

- 확인 결과 승인 가능이면 대상 Discovery 문서를 `confirmed`로 전환하고 `docs/discovery/index.md`의 해당 행 상태를 함께 갱신한다.
- 승인까지는 불가하더라도 AI가 근거 있게 채울 수 있는 항목이 있으면 문서를 먼저 보강한다. 단, 이 경우 `confirmed` 전환과 REQ drafting 준비 플래그 변경은 하지 않는다.

# When to use

다음 상황에서 사용한다.

- `/confirm-discovery dcy-xyz` 형태로 기존 Discovery를 최종 확인해야 할 때
- `docs/discovery/` 아래 Discovery 초안 문서를 REQ 초안 작성 가능 상태로 승격해야 할 때
- 현재 저장소 구현 상태를 다시 확인해 Discovery 본문의 사실 관계를 정정하거나 보강해야 할 때
- 문서 안의 플레이스홀더 중 AI가 근거 있게 채울 수 있는 항목을 먼저 정리한 뒤 승인 가능 여부를 판정해야 할 때
- `docs/discovery/index.md`의 상태가 실제 Discovery 상태와 일치하는지 함께 맞춰야 할 때

# Inputs

이 Skill은 아래 입력을 사용한다.

- Discovery 식별자
    - `dcy-001` 같은 축약 ID
    - `dcy-001_20260424_topic-slug` 같은 전체 Discovery ID
    - `docs/discovery/<DISCOVERY_ID>.md` 같은 직접 경로
- Discovery 문서 본문
- `docs/discovery/index.md`
- 현재 저장소 구현 상태
    - 관련 소스 파일
    - 설정 파일
    - 관련 문서
- 현재 시각 (KST)

# Core Rules

## 1. 입력 해석 규칙

- 입력이 `dcy-001`처럼 prefix만 주어지면 `docs/discovery/` 아래에서 해당 prefix로 시작하는 문서를 찾는다.
- 입력이 전체 Discovery ID면 `docs/discovery/<DISCOVERY_ID>.md`를 직접 찾는다.
- 입력이 파일 경로면 해당 경로를 그대로 사용한다.
- 매칭 결과가 0개면 자동 진행하지 않고 사용자에게 입력을 재확인하도록 알린다.
- 같은 prefix에 대해 여러 문서가 매칭되면 임의 선택하지 않고 후보 목록을 보여 준 뒤 사용자 확인을 요청한다.
- `.vendor/` 경로는 탐색 대상에서 제외한다.

## 2. 현재 구현 상태 재확인 규칙

- 현재 구현 상태 확인은 요구사항이 이미 모두 구현되었는지 검사하는 절차가 아니다.
- 이 확인의 목적은 Discovery의 `현재 상태`, `영향 범위`, `성공 기준`, `체크 항목`, `사용자 결정 필요 항목`이 저장소 현실과 맞는지 검증하는 것이다.
- 구현 부재 자체는 차단 사유가 아니다. Discovery가 애초에 신규 작업을 정의하는 문서라면 코드가 없는 상태도 정상일 수 있다.
- 차단이 되는 경우는 아래와 같다.
    - 문서가 이미 존재한다고 적은 구현이 실제 저장소에는 없어서 본문 사실 관계가 틀린 경우
    - 저장소 현실이 문서의 핵심 범위, 사용자 시나리오, 성공 기준을 다시 써야 할 정도로 바뀐 경우
    - 문서의 남은 결정 항목이 여전히 사람 판단을 필요로 하는데 승인 상태로 올리려는 경우

## 3. 승인 전 보강 규칙

승인 판정 전에 먼저 아래 보강 절차를 수행한다.

### 3-1. 일관성 검토

- 용어 혼용, 범위 충돌, 중복 서술, 번호 누락을 확인한다.
- `# 5. 요구사항 목록`, `# 6. 리스크/가정 목록`, `# 7. 초기 성공 기준`, `# 8. REQ로 넘기기 전 확인 체크`, `# 10. 사용자 결정 필요 항목 요약`, `# 11. Discovery Freeze`의 연결 관계를 확인한다.
- 문장만 다르고 같은 의미를 반복하는 부분은 간결하게 정리한다.
- 문법, 오타, 링크 형식, 체크리스트 표현을 함께 정리한다.

### 3-2. 증거 기반 보강

- Discovery 본문에서 이슈명, 핵심 변경 항목, FR/NFR, 범위 경계를 읽고 키워드를 추출한다.
- 키워드를 바탕으로 저장소에서 관련 파일, 설정, 문서를 탐색한다.
- 탐색 결과는 최소한 아래 판단으로 정리한다.
    - 이미 존재함
    - 일부 존재함
    - 아직 없음
    - 문서와 모순됨
- AI가 아래 근거로 확정 가능한 항목은 실제 문장으로 치환한다.
    - 같은 Discovery 문서 안 다른 섹션에 이미 답이 있는 항목
    - 현재 저장소 파일 구조, 설정, 문서에서 직접 확인 가능한 항목
    - 승인 행위 시각처럼 현재 실행 시점에 자동 확정 가능한 항목
- 아래 항목은 추론만으로 확정하지 않는다.
    - 정책 선택
    - 우선순위 승인
    - 외부 시스템 또는 외부 데이터 확인 결과
    - 승인자 지명처럼 사람 책임을 수반하는 결정

### 3-3. 플레이스홀더 분류 기준

- A. 승인 시점 자동 채움
    - 예: `{{DATA_CONFIRMED_AT_KST:...}}`, `{{CONFIRMED_AT_KST:...}}`
    - 승인 성공 시 현재 시각으로 채운다.
- B. 증거 기반 해소 가능
    - 문서 다른 섹션, 저장소 구조, 이미 확정된 값으로 해소 가능한 플레이스홀더다.
    - 승인 성공 여부와 무관하게 먼저 채운다.
- C. 사람 결정 또는 외부 확인 필요
    - `{{DECIDE_*}}`, `{{CONFIRM_*}}`, `{{DATA_*}}` 중 아직 문서와 저장소 근거만으로 해소되지 않는 항목이다.
    - 승인 차단 대상이다.

- 승인 판정 직전에는 A와 B만 남아 있어야 한다.
- B로 분류한 항목을 채운 뒤에도 `# 1`부터 `# 10` 사이에 C 유형 플레이스홀더가 남아 있으면 승인하지 않는다.

## 4. 최종 승인 게이트

아래 조건을 모두 만족해야 `confirmed`로 전환한다.

- 문서 상태가 아직 `confirmed`가 아니어야 한다.
- B 유형 보강 이후 C 유형 플레이스홀더가 0개여야 한다.
- `# 6. 리스크/가정 목록`의 오픈 질문에 `상태: Open` 항목이 없어야 한다.
- `# 8. REQ로 넘기기 전 확인 체크`에 남아 있는 미완료 항목이 있다면, 그 항목이 REQ 초안 작성을 막지 않는다고 문서에 명시되어 있어야 한다. 그렇지 않으면 차단한다.
- `# 10. 사용자 결정 필요 항목 요약`에 남은 항목이 모두 `없음`이거나, 문서 안에서 이미 답이 반영되어 제거 가능해야 한다.
- `# 11. Discovery Freeze`에 `Confirmed By`가 비어 있지 않아야 한다.
- 현재 저장소 상태가 Discovery의 핵심 범위나 요구사항을 다시 정의해야 할 정도로 모순되지 않아야 한다.

다음 경우는 `confirmed` 전환 대신 보류한다.

- Discovery 초안이 아니라 사실상 새 Discovery 생성 또는 대규모 범위 재정의가 필요한 경우
- 확인 과정에서 FR/NFR, In Scope/Out of Scope, 성공 기준을 실질적으로 다시 써야 하는 경우
- 승인자 또는 필수 결정 사항이 여전히 문서 밖 사람 판단에 의존하는 경우

## 5. 허용되는 수정 범위

이 Skill은 아래 수정만 수행한다.

- AI가 근거 있게 채울 수 있는 플레이스홀더 치환
- 현재 저장소 상태에 맞춘 사실 관계 보정
- 표현, 번호, 체크리스트, 링크의 일관성 정리
- 실제 문서 변경이 있었다면 `마지막 갱신 시각(KST)` 갱신
- 승인 가능 시 아래 상태 전환 수행
    - `# 0. 문서 상태`의 `상태`를 `confirmed`로 변경
    - `# 11. Discovery Freeze`의 `Handoff Decision`을 `승인`으로 변경
    - `# 11. Discovery Freeze`의 `Ready for REQ Drafting`을 `true`로 변경
    - `Confirmed At (KST)`를 현재 시각으로 채움
    - `docs/discovery/index.md`의 해당 Discovery 행 상태를 `confirmed`로 갱신

아래 상황이면 상태 전환 없이 보강만 하고 종료한다.

- C 유형 플레이스홀더가 남아 있는 경우
- 오픈 질문 또는 사용자 결정 항목이 남아 있는 경우
- 승인 자체보다 먼저 Discovery 내용 재정비가 필요한 경우

# Repository Exploration

현재 구현 상태를 다시 확인할 때는 아래 순서로 저장소를 탐색한다.

1. Discovery 문서에서 이슈명, 핵심 변경 항목, FR/NFR, 범위 경계 키워드를 뽑는다.
2. 키워드 기준으로 관련 소스, 설정, 문서를 찾는다.
3. 아래 항목은 기본적으로 제외한다.
   - 테스트 파일
   - 의존성 잠금 파일
   - `.vendor/` 하위 파일
4. 탐색 결과를 아래 형태로 정리한다.
   - 관련 파일 경로 목록
   - 이미 구현된 내용
   - 일부만 구현된 내용
   - 아직 없는 내용
   - 문서와 모순되는 내용
5. 탐색 결과는 Discovery 보강과 승인 게이트 판단에만 사용한다.

# Execution Procedure

다음 순서대로 작업한다.

1. 입력에서 Discovery 문서 경로를 확정한다.
2. 대상 Discovery 문서와 `docs/discovery/index.md`를 읽는다.
3. Discovery의 핵심 범위, FR/NFR, 오픈 질문, 체크리스트, 사용자 결정 필요 항목을 추출한다.
4. 위 `Repository Exploration` 규칙에 따라 현재 저장소 상태를 확인한다.
5. 문서 전체를 검토해 일관성 오류와 플레이스홀더를 나열한다.
6. B 유형 플레이스홀더와 명백한 사실 관계 오류를 먼저 수정한다.
7. 문서 내용이 바뀌었다면 `마지막 갱신 시각(KST)`를 현재 시각으로 갱신한다.
8. 다시 한 번 `최종 승인 게이트`를 평가한다.
9. 게이트를 통과하면 A 유형 플레이스홀더를 채우고 문서를 `confirmed`로 전환한다.
10. 게이트를 통과하면 `docs/discovery/index.md`의 해당 행 상태도 `confirmed`로 갱신한다.
11. `docs/discovery/index.md`에 해당 Discovery 행이 없으면 현재 문서 메타데이터를 기준으로 같은 테이블 형식의 행을 추가한다.
12. 게이트를 통과하지 못하면 상태는 유지하고, 보강된 내용과 남은 차단 항목만 보고한다.

# Output Expectations

작업이 끝나면 아래 내용을 보고할 수 있어야 한다.

- 대상 `DISCOVERY_ID`와 문서 경로
- 현재 저장소 상태 재확인 결과 요약
- AI가 자동으로 채운 항목 목록
- 남겨 둔 항목 목록과 남긴 이유
- 최종 판정
    - `confirmed 전환 완료`
    - `보강만 수행, 승인 보류`
    - `문서 변경 없이 승인 보류`
- `docs/discovery/index.md` 갱신 결과
- REQ 초안 작성으로 넘기기 전에 남은 작업 요약

# Validation

완료 전에 아래를 확인한다.

- 대상 경로가 `docs/discovery/<DISCOVERY_ID>.md` 형식을 만족하는지
- 대상 Discovery 문서가 실제로 존재하는지
- 보강 후에도 C 유형 플레이스홀더와 `상태: Open` 오픈 질문이 정확히 식별되었는지
- 승인 완료인 경우 문서 상태와 `docs/discovery/index.md` 상태가 모두 `confirmed`인지
- 승인 보류인 경우 `confirmed`, `승인`, `true` 같은 승인 전환 값이 잘못 들어가지 않았는지
- 문서 본문 보강이 새로운 요구사항 생성이나 범위 재정의로 번지지 않았는지
- 결과 보고에 자동 처리 항목과 차단 항목이 모두 포함되는지