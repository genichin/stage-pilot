---
name: "run-sdlc"
description: "Run the full SDLC pipeline for a given cycle, automatically resuming from the first incomplete stage"
argument-hint: "예: sdlc-001 Justin"
agent: "agent"
---
지정된 SDLC 주기의 전체 파이프라인을 순서대로 실행한다.

인자:
- `sdlc-xyz`: SDLC 주기 ID (예: `sdlc-001`)
- `my-name`: 각 단계 승인자 이름 (예: `Justin`)

목표:
- 지정된 SDLC 주기의 현재 진행 상태를 파악하고, 미완료 단계부터 순서대로 실행한다.
- 각 단계가 완료(`confirmed`)되면 다음 단계로 자동 진행한다.
- 사용자 판단이 필요한 경우 즉시 중단하고, 어떤 판단이 필요한지 명확하게 안내한다.

---

## 실행 절차

### 1. 입력 해석

- 첫 번째 인자를 `CYCLE_ID`로 사용한다 (예: `sdlc-001`).
- 두 번째 인자를 `APPROVER_NAME`으로 사용한다 (예: `Justin`).
- `docs/sdlc/` 아래에서 `CYCLE_ID`로 시작하는 폴더를 찾는다.
  - 폴더가 없으면 오류를 보고하고 중단한다.
  - 폴더가 여러 개이면 가장 최근(날짜 순)을 사용하고 선택한 폴더 경로를 보고한다.
- 이후 단계에서 `SDLC_DIR = docs/sdlc/<일치하는 폴더>`로 참조한다.

### 2. 현재 상태 파악

`SDLC_DIR/index.md`의 단계별 상태 테이블을 읽어 각 단계의 현재 상태를 확인한다.
파일이 없으면 각 문서 파일을 직접 읽어 `# 0. 문서 상태`의 `- 상태:` 줄에서 상태를 확인한다.

확인 대상 단계와 해당 문서 파일:

| 단계 | 문서 파일 | confirmed 조건 |
|------|-----------|----------------|
| Discovery | `1_discovery.md` | 상태 = `confirmed` 또는 `Ready for Planning: true` |
| Planning | `2_planning.md` | 상태 = `confirmed` 또는 `Ready for Design: true` |
| Design | `3_design.md` | 상태 = `confirmed` 또는 `Ready for Implementation: true` |
| Implementation | `4_implementation.md` | 상태 = `confirmed` 또는 `Ready for Verification: true` |
| Verification | `5_verification.md` | 상태 = `confirmed` 또는 `Ready for Release: true` |
| Release | `6_release.md` | 상태 = `confirmed` 또는 `Ready for Operations: true` |
| Operations | `7_operation.md` | 상태 = `confirmed` 또는 `SDLC 주기 완료: true` |

### 3. 실행 시작 지점 결정

단계를 아래 순서로 순회하며 `confirmed`가 아닌 첫 번째 단계를 찾는다.

1. Discovery
2. Planning
3. Design
4. Implementation
5. Verification
6. Release
7. Operations

모든 단계가 `confirmed`이면 SDLC 주기가 완료되었음을 보고하고 종료한다.

### 4. 단계별 실행

시작 지점부터 각 단계의 서브스텝을 아래 순서로 실행한다.
각 서브스텝 실행 후 결과를 확인하고, 블로킹 조건이 발생하면 즉시 중단한다.

#### 4-1. Discovery 단계 (`1_discovery.md`)

`1_discovery.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | 오류 보고 후 중단 — Discovery 문서는 `/new-sdlc`로 먼저 생성해야 한다 |
| `draft` 또는 `review` | ① `review-discovery` → ② `confirm-discovery` |
| `confirmed` | 스킵 |

- `review-discovery` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-discovery` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

#### 4-2. Planning 단계 (`2_planning.md`)

`2_planning.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | ① `draft-planning` → ② `review-planning` → ③ `confirm-planning` |
| `draft` | ① `review-planning` → ② `confirm-planning` |
| `review` | ① `confirm-planning` |
| `confirmed` | 스킵 |

- `draft-planning` 실행 시: Discovery가 `confirmed` 상태인지 확인한다. 아니면 중단.
- `review-planning` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-planning` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

#### 4-3. Design 단계 (`3_design.md`)

`3_design.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | ① `draft-design` → ② `review-design` → ③ `confirm-design` |
| `draft` | ① `review-design` → ② `confirm-design` |
| `review` | ① `confirm-design` |
| `confirmed` | 스킵 |

- `draft-design` 실행 시: Planning이 `confirmed` 상태인지 확인한다. 아니면 중단.
- `review-design` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-design` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

#### 4-4. Implementation 단계 (`4_implementation.md`)

`4_implementation.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | ① `draft-implementation` → ② `run-implementation` → ③ `review-implementation` → ④ `confirm-implementation` |
| `draft` | ① `run-implementation` → ② `review-implementation` → ③ `confirm-implementation` |
| `review` | ① `review-implementation` → ② `confirm-implementation` |
| `confirmed` | 스킵 |

- `draft-implementation` 실행 시: Design이 `confirmed` 상태인지 확인한다. 아니면 중단.
- `run-implementation` 실행 시: 블로킹 태스크가 발생하면 → [블로킹 처리](#블로킹-처리)
- `review-implementation` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-implementation` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

#### 4-5. Verification 단계 (`5_verification.md`)

`5_verification.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | ① `draft-verification` → ② `review-verification` → ③ `confirm-verification` |
| `draft` | ① `review-verification` → ② `confirm-verification` |
| `review` | ① `confirm-verification` |
| `confirmed` | 스킵 |

- `draft-verification` 실행 시: Implementation이 `confirmed` 상태인지 확인한다. 아니면 중단.
- `review-verification` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-verification` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

#### 4-6. Release 단계 (`6_release.md`)

`6_release.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | ① `draft-release` → ② `review-release` → ③ `confirm-release` |
| `draft` | ① `review-release` → ② `confirm-release` |
| `review` | ① `confirm-release` |
| `confirmed` | 스킵 |

- `draft-release` 실행 시: Verification이 `confirmed` 상태인지 확인한다. 아니면 중단.
- `review-release` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-release` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

#### 4-7. Operations 단계 (`7_operation.md`)

`7_operation.md`의 상태에 따라 아래 서브스텝을 실행한다.

| 현재 상태 | 실행할 서브스텝 |
|-----------|----------------|
| 파일 없음 | ① `draft-operation` → ② `review-operation` → ③ `confirm-operation` |
| `draft` | ① `review-operation` → ② `confirm-operation` |
| `review` | ① `confirm-operation` |
| `confirmed` | 스킵 |

- `draft-operation` 실행 시: Release가 `confirmed` 상태인지 확인한다. 아니면 중단.
- `review-operation` 실행 시: 검토 결과가 **보류(Hold)**이면 → [블로킹 처리](#블로킹-처리)
- `confirm-operation` 실행 시: `APPROVER_NAME`을 `Confirmed By` 값으로 사용한다.
  승인 불가 보고를 받으면 → [블로킹 처리](#블로킹-처리)

---

### 블로킹 처리

아래 상황 중 하나가 발생하면 즉시 실행을 중단하고 사용자에게 아래 정보를 제공한다.

1. **review-* 결과가 보류(Hold)인 경우**
   - 어느 단계의 review에서 보류가 발생했는지
   - 보류 이유 (review 결과에서 제시된 미충족 항목)
   - 해결을 위해 필요한 사용자 조치

2. **confirm-* 결과가 승인 불가인 경우**
   - 어느 단계의 confirm이 실패했는지
   - C 유형 미해소 플레이스홀더 목록 (해당 시)
   - 미해소 오픈 질문 목록 (해당 시)
   - 해결 방법 안내 (예: 문서에서 해당 항목을 직접 채운 후 `/run-sdlc <CYCLE_ID> <NAME>` 재실행)

3. **run-implementation 실행 중 블로킹 태스크가 발생한 경우**
   - 블로킹된 태스크 번호(T-N)와 원인
   - 사용자가 결정해야 할 사항
   - 해결 후 `/run-sdlc <CYCLE_ID> <NAME>` 재실행 안내

4. **Verification 단계가 미완료인 경우**
   - Verification 문서의 현재 상태
   - 필요한 조치 안내

---

### 5. 완료 보고

전체 파이프라인이 완료되면(모든 단계 `confirmed`) 아래 내용을 포함한 완료 보고를 출력한다.

- **완료된 주기**: `CYCLE_ID`
- **각 단계별 최종 상태** (표 형식)
- **이번 실행에서 처리된 단계 목록**
- **다음 Discovery 환류 항목**: Operations `# 6` 섹션의 내용 요약 (있는 경우)
- **다음 SDLC 주기 시작 안내**: `/new-sdlc <다음 이슈 내용>` 명령 안내

---

## 서브스텝 실행 방식

각 서브스텝은 해당 프롬프트 파일의 전체 절차를 그대로 실행한다.

| 서브스텝 | 참조 프롬프트 |
|----------|--------------|
| `review-discovery` | `.github/prompts/review-discovery.prompt.md` |
| `confirm-discovery` | `.github/prompts/confirm-discovery.prompt.md` |
| `draft-planning` | `.github/prompts/draft-planning.prompt.md` |
| `review-planning` | `.github/prompts/review-planning.prompt.md` |
| `confirm-planning` | `.github/prompts/confirm-planning.prompt.md` |
| `draft-design` | `.github/prompts/draft-design.prompt.md` |
| `review-design` | `.github/prompts/review-design.prompt.md` |
| `confirm-design` | `.github/prompts/confirm-design.prompt.md` |
| `draft-implementation` | `.github/prompts/draft-implementation.prompt.md` |
| `run-implementation` | `.github/prompts/run-implementation.prompt.md` |
| `review-implementation` | `.github/prompts/review-implementation.prompt.md` |
| `confirm-implementation` | `.github/prompts/confirm-implementation.prompt.md` |
| `draft-verification` | `.github/prompts/draft-verification.prompt.md` |
| `review-verification` | `.github/prompts/review-verification.prompt.md` |
| `confirm-verification` | `.github/prompts/confirm-verification.prompt.md` |
| `draft-release` | `.github/prompts/draft-release.prompt.md` |
| `review-release` | `.github/prompts/review-release.prompt.md` |
| `confirm-release` | `.github/prompts/confirm-release.prompt.md` |
| `draft-operation` | `.github/prompts/draft-operation.prompt.md` |
| `review-operation` | `.github/prompts/review-operation.prompt.md` |
| `confirm-operation` | `.github/prompts/confirm-operation.prompt.md` |

`confirm-*` 서브스텝 실행 시 `APPROVER_NAME`을 해당 문서의 Freeze 섹션 `Confirmed By:` 값으로 주입한다.
해당 줄이 문서에 없거나 플레이스홀더로 되어 있으면, 실행 전 `APPROVER_NAME`으로 교체한다.

---

## 중요 규칙

- 각 단계는 정해진 순서대로만 실행하며, 이전 단계가 `confirmed`가 아닌 상태에서 다음 단계를 시작하지 않는다.
- `run-implementation`은 실제 코드를 변경하는 단계이므로, 블로킹 조건이 없어도 실행 전 `4_implementation.md`의 구현 계획(`# 2 구현 계획`)과 변경 파일 목록(`# 3 변경 파일 목록`)을 요약해 사용자에게 안내한 뒤 진행한다.
- 사용자 판단 없이 임의로 결정할 수 없는 항목(담당자 지정, 외부 환경 정보, 정책 결정 등)은 반드시 중단하고 사용자에게 문의한다.
- 블로킹 처리 후 사용자가 문서를 직접 수정하면 `/run-sdlc <CYCLE_ID> <APPROVER_NAME>`을 재실행해 이어서 진행할 수 있다.
- 현재 시각은 시스템 또는 컨텍스트에서 제공된 날짜/시간을 사용한다.
