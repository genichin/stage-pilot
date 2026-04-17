---
name: "draft-release"
description: "Create a 6_release.md draft from a confirmed Verification document"
argument-hint: "예: sdlc-001 또는 docs/sdlc/sdlc-001_20260417_stage-pilot/5_verification.md"
agent: "agent"
---
확정된 Verification 문서를 기반으로 Release 초안(`6_release.md`)을 생성한다.

목표:
- `docs/sdlc/<CYCLE_ID>/6_release.md`를 생성한다.
- `5_verification.md`의 검증 결과와 `4_implementation.md`의 변경 파일 목록을 Release 초안의 입력으로 사용한다.
- 추론 가능한 배포 계획 항목은 초안으로 채우고, 사용자 결정이 필요한 항목만 플레이스홀더로 남긴다.

---

## 실행 절차

### 1. 입력 해석

- 사용자가 CYCLE_ID(예: `sdlc-001`)를 제공했으면 `docs/sdlc/` 아래에서 해당 패턴으로 시작하는 폴더를 찾아 `5_verification.md` 경로를 확정한다.
- 사용자가 파일 경로를 직접 제공했으면 해당 경로의 상위 폴더에서 `5_verification.md`를 찾는다.
- 파일이 없으면 사용자에게 피드백하고 중단한다.

### 2. Verification 인계 조건 확인

`5_verification.md`에서 아래 조건을 확인한다. 미충족 시 중단하고 이유를 보고한다.

| 항목 | 기준 |
|------|------|
| 문서 상태 | `confirmed`여야 한다 |
| Ready for Release | `true`여야 한다 |
| 6_release.md 존재 여부 | 이미 존재하면 덮어쓰기 의사를 확인하고, 의사 표현이 없으면 중단한다 |

### 3. 내용 추출

`5_verification.md`, `4_implementation.md`, `1_discovery.md`에서 아래 항목을 읽어 Release 초안 작성에 사용한다.

- 이슈명 (`# 0`의 `이슈명:`)
- 문서 ID / CYCLE_ID
- 검증 결과 요약 (`5_verification.md` `# 3`)
- Deferred 처리된 오픈 질문 (`5_verification.md` `# 5`)
- 변경 파일 목록 (`4_implementation.md` `# 3`)
- 저장소 구조 및 배포 관련 설정 파일

### 4. Release 초안 작성 원칙

- 저장소 구조와 배포 관련 파일(`.github/workflows`, `Makefile`, `bootstrap/` 등)을 실제로 확인해 배포 방식과 도구를 구체적으로 초안으로 채운다.
- 롤백 계획은 변경 파일 목록을 기반으로 현실적인 롤백 절차를 초안으로 작성한다.
- 스모크 테스트 항목은 핵심 기능 FR을 기반으로 도출한다.
- 아래 항목은 추론 불가 또는 사용자 확인 필요이므로 플레이스홀더로 남긴다.
  - 롤백 담당자 (`{{REL_ROLLBACK_OWNER:TBD}}`)
  - Freeze 확정 담당자 (`{{CONFIRMED_BY:TBD}}`)

### 5. 자동으로 채워야 하는 항목

| 항목 | 채움 방법 |
|------|---------|
| `# 0` 메타데이터 | 현재 시각, CYCLE_ID, 이슈명, Verification 경로를 자동 입력 |
| `# 1` Verification 인계 요약 | Verification 검증 결과 요약, Deferred 항목 이식 |
| `# 2` 배포 환경/방식/도구 | 저장소 구조 기반으로 배포 방식 초안 작성 |
| `# 2` 배포 순서 | 변경 파일 목록 기반으로 의존 관계를 고려한 배포 순서 초안 작성 |
| `# 3` 롤백 계획 | 변경 내용에 대한 현실적인 롤백 조건 및 절차 초안 작성 |
| `# 4` 스모크 테스트 | FR 기반으로 핵심 시나리오 도출 및 확인 방법 초안 작성 |
| `# 5` 리스크 | Verification 이월 리스크 중 Release 관련 항목 포함 |
| `# 7` 파일 처리 결과 | 생성 결과와 참조 문서 경로 채움 |
| `# 8` 사용자 결정 필요 | 배포 담당자, 롤백 담당자 미지정 항목 정리 |
| `# 9` Freeze 플래그 | `Handoff Decision: 보류`, `Ready for Operations: false` 초기값 입력 |

### 6. 파일 생성

- 경로: `docs/sdlc/<CYCLE_ID>/6_release.md`
- 기반: `.github/templates/sdlc/6_release.md`를 구조 기준으로 사용하되, 위 작성 원칙에 따라 채운 초안을 생성한다.

### 7. 결과 보고

응답에 아래 내용을 포함한다.

- **생성된 파일 경로**
- **자동 채워진 항목 목록** (어떤 값으로 채웠는지)
- **플레이스홀더로 남긴 항목 목록** (사용자 결정 필요 이유 포함)
- **다음 단계 안내**: `/review-release <CYCLE_ID>` 실행 안내
