---
name: "draft-implementation"
description: "Create a 4_implementation.md draft from a confirmed Design document"
argument-hint: "예: sdlc-001 또는 docs/sdlc/sdlc-001_20260417_stage-pilot/3_design.md"
agent: "agent"
---
확정된 Design 문서를 기반으로 Implementation 초안(`4_implementation.md`)을 생성한다.

목표:
- `docs/sdlc/<CYCLE_ID>/4_implementation.md`를 생성한다.
- `3_design.md`의 확정 내용(태스크, 변경 대상, 인터페이스, 보안)을 Implementation 초안의 입력으로 사용한다.
- 추론 가능한 항목은 초안 문장으로 채우고, 사용자 결정이 필요한 항목만 플레이스홀더로 남긴다.

---

## 실행 절차

### 1. 입력 해석

- 사용자가 CYCLE_ID(예: `sdlc-001`)를 제공했으면 `docs/sdlc/` 아래에서 해당 패턴으로 시작하는 폴더를 찾아 `3_design.md` 경로를 확정한다.
- 사용자가 파일 경로를 직접 제공했으면 해당 경로의 상위 폴더에서 `3_design.md`를 찾는다.
- 파일이 없으면 사용자에게 피드백하고 중단한다.

### 2. Design 인계 조건 확인

`3_design.md`에서 아래 조건을 확인한다. 미충족 시 중단하고 이유를 보고한다.

| 항목 | 기준 |
|------|------|
| 문서 상태 | `confirmed`여야 한다 |
| Ready for Implementation | `true`여야 한다 |
| 4_implementation.md 존재 여부 | 이미 존재하면 덮어쓰기 의사를 확인하고, 의사 표현이 없으면 중단한다 |

### 3. Design 내용 추출

`3_design.md`와 `2_planning.md`에서 아래 항목을 읽어 Implementation 초안 작성에 사용한다.

- 이슈명 (`# 0`의 `이슈명:`)
- 문서 ID / CYCLE_ID
- 태스크 전체 목록 및 담당자 (`# 1`)
- 태스크별 변경 대상 파일/함수 (`# 3`)
- 태스크별 입출력 및 엣지 케이스 (`# 3`)
- 인터페이스 정의 (`# 4`)
- 보안 고려사항 (`# 5`)
- 리스크 및 완화 방안 (`# 6`)
- Deferred 처리된 오픈 질문 (`# 6`)

### 4. Implementation 초안 작성 원칙

- Design에서 확정된 태스크 구조와 변경 대상을 기반으로 각 태스크의 구현 방법, 변경 파일, 완료 조건을 초안으로 채운다.
- 저장소 구조, 파일 경로, 기존 코드 패턴을 실제로 확인해 변경 파일 목록(`IMP_FILE_N`)을 구체적으로 명시한다.
- 아래 항목은 추론 불가 또는 사용자 확인 필요이므로 플레이스홀더로 남긴다.
  - 태스크 담당자 (`{{IMP_TASK_OWNER_N:TBD}}`)
  - Freeze 확정 담당자 (`{{CONFIRMED_BY:TBD}}`)

### 5. 자동으로 채워야 하는 항목

| 항목 | 채움 방법 |
|------|---------|
| `# 0` 메타데이터 | 현재 시각, CYCLE_ID, 이슈명, Design 경로를 자동 입력 |
| `# 1` Design 인계 요약 | Design `# 1` 태스크 목록 및 변경 대상 이식, `# 6`의 Deferred 항목 이식 |
| `# 2` 구현 순서 | 태스크 의존 관계를 기반으로 구현 순서 초안 작성 |
| `# 2` 태스크별 구현 방법 | Design `# 3` 상세 설계 내용을 기반으로 구현 접근 방법 초안 작성 |
| `# 3` 변경 파일 목록 | Design `# 3`의 변경 대상 파일/함수를 기반으로 실제 경로 확인 후 목록 작성 |
| `# 4` 리스크 | Design 이월 리스크 중 Implementation 관련 항목 포함 및 신규 리스크 추가 |
| `# 6` 파일 처리 결과 | 생성 결과와 참조 문서 경로 채움 |
| `# 7` 사용자 결정 필요 | 미확정 태스크 담당자, 외부 시스템 호출 확인 필요 항목 정리 |
| `# 8` Freeze 플래그 | `Handoff Decision: 보류`, `Ready for Verification: false` 초기값 입력 |

### 6. 파일 생성

- 경로: `docs/sdlc/<CYCLE_ID>/4_implementation.md`
- 기반: `.github/templates/sdlc/4_implementation.md`를 구조 기준으로 사용하되, 위 작성 원칙에 따라 채운 초안을 생성한다.

### 7. 결과 보고

응답에 아래 내용을 포함한다.

- **생성된 파일 경로**
- **자동 채워진 항목 목록** (어떤 값으로 채웠는지)
- **플레이스홀더로 남긴 항목 목록** (사용자 결정 필요 이유 포함)
- **다음 단계 안내**: `/review-implementation <CYCLE_ID>` 실행 안내
