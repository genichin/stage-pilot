---
name: "draft-verification"
description: "Create a 5_verification.md draft from a confirmed Implementation document"
argument-hint: "예: sdlc-001 또는 docs/sdlc/sdlc-001_20260417_stage-pilot/4_implementation.md"
agent: "agent"
---
확정된 Implementation 문서를 기반으로 Verification 초안(`5_verification.md`)을 생성한다.

목표:
- `docs/sdlc/<CYCLE_ID>/5_verification.md`를 생성한다.
- `4_implementation.md`의 완료 태스크와 `1_discovery.md`의 성공 기준(S-N)을 Verification 초안의 입력으로 사용한다.
- 추론 가능한 검증 항목은 초안으로 채우고, 사용자 결정이 필요한 항목만 플레이스홀더로 남긴다.

---

## 실행 절차

### 1. 입력 해석

- 사용자가 CYCLE_ID(예: `sdlc-001`)를 제공했으면 `docs/sdlc/` 아래에서 해당 패턴으로 시작하는 폴더를 찾아 `4_implementation.md` 경로를 확정한다.
- 사용자가 파일 경로를 직접 제공했으면 해당 경로의 상위 폴더에서 `4_implementation.md`를 찾는다.
- 파일이 없으면 사용자에게 피드백하고 중단한다.

### 2. Implementation 인계 조건 확인

`4_implementation.md`에서 아래 조건을 확인한다. 미충족 시 중단하고 이유를 보고한다.

| 항목 | 기준 |
|------|------|
| 문서 상태 | `confirmed`여야 한다 |
| Ready for Verification | `true`여야 한다 |
| 5_verification.md 존재 여부 | 이미 존재하면 덮어쓰기 의사를 확인하고, 의사 표현이 없으면 중단한다 |

### 3. 내용 추출

`4_implementation.md`, `3_design.md`, `1_discovery.md`에서 아래 항목을 읽어 Verification 초안 작성에 사용한다.

- 이슈명 (`# 0`의 `이슈명:`)
- 문서 ID / CYCLE_ID
- 구현 완료 태스크 목록 및 변경 파일 (`# 1`, `# 3`)
- 태스크별 완료 조건(DoD) (`# 2`)
- Deferred 처리된 오픈 질문 (`# 4`)
- 성공 기준(S-N) (`1_discovery.md` `# 7`)
- 기능 요구사항(FR) 목록 (`1_discovery.md` `# 5`)
- 검증 계획 개요 (`2_planning.md` `# 6`)

### 4. Verification 초안 작성 원칙

- Discovery 성공 기준(S-N)과 FR 목록을 기반으로 검증 항목(VC-N)을 도출한다.
- 각 VC 항목에 검증 방법(수동/자동/혼합)과 측정 가능한 성공 기준을 초안으로 채운다.
- 검증 결과(`# 3`) 테이블은 모두 `미완료`로 초기화한다.
- 아래 항목은 추론 불가 또는 사용자 확인 필요이므로 플레이스홀더로 남긴다.
  - 검증 담당자 (`{{VER_OWNER_N:TBD}}`)
  - Freeze 확정 담당자 (`{{CONFIRMED_BY:TBD}}`)

### 5. 자동으로 채워야 하는 항목

| 항목 | 채움 방법 |
|------|---------|
| `# 0` 메타데이터 | 현재 시각, CYCLE_ID, 이슈명, Implementation 경로를 자동 입력 |
| `# 1` Implementation 인계 요약 | Implementation `# 1`/`# 2` 태스크 목록 및 DoD 이식, `# 4`의 Deferred 항목 이식 |
| `# 2` 검증 항목 | Discovery S-N 기준과 FR/NFR을 기반으로 VC-N 항목 도출 및 검증 방법/성공 기준 초안 작성 |
| `# 2` 성공 기준 연결 | S-N과 VC-N의 연결 관계 명시 |
| `# 3` 검증 결과 | 모든 항목 `미완료`로 초기화, 통과/실패 집계 0으로 초기화 |
| `# 5` 리스크 | Implementation 이월 리스크 중 Verification 관련 항목 포함 |
| `# 7` 파일 처리 결과 | 생성 결과와 참조 문서 경로 채움 |
| `# 8` 사용자 결정 필요 | 검증 담당자 미지정 항목 정리 |
| `# 9` Freeze 플래그 | `Handoff Decision: 보류`, `Ready for Release: false` 초기값 입력 |

### 6. 파일 생성

- 경로: `docs/sdlc/<CYCLE_ID>/5_verification.md`
- 기반: `.github/templates/sdlc/5_verification.md`를 구조 기준으로 사용하되, 위 작성 원칙에 따라 채운 초안을 생성한다.

### 7. 결과 보고

응답에 아래 내용을 포함한다.

- **생성된 파일 경로**
- **자동 채워진 항목 목록** (어떤 값으로 채웠는지)
- **플레이스홀더로 남긴 항목 목록** (사용자 결정 필요 이유 포함)
- **다음 단계 안내**: `/review-verification <CYCLE_ID>` 실행 안내
