---
name: "draft-operation"
description: "Create a 7_operation.md draft from a confirmed Release document"
argument-hint: "예: sdlc-001 또는 docs/sdlc/sdlc-001_20260417_stage-pilot/6_release.md"
agent: "agent"
---
확정된 Release 문서를 기반으로 Operations 초안(`7_operation.md`)을 생성한다.

목표:
- `docs/sdlc/<CYCLE_ID>/7_operation.md`를 생성한다.
- `6_release.md`의 배포 결과와 모니터링 정보를 Operations 초안의 입력으로 사용한다.
- 추론 가능한 운영 항목은 초안으로 채우고, 사용자 결정이 필요한 항목만 플레이스홀더로 남긴다.

---

## 실행 절차

### 1. 입력 해석

- 사용자가 CYCLE_ID(예: `sdlc-001`)를 제공했으면 `docs/sdlc/` 아래에서 해당 패턴으로 시작하는 폴더를 찾아 `6_release.md` 경로를 확정한다.
- 사용자가 파일 경로를 직접 제공했으면 해당 경로의 상위 폴더에서 `6_release.md`를 찾는다.
- 파일이 없으면 사용자에게 피드백하고 중단한다.

### 2. Release 인계 조건 확인

`6_release.md`에서 아래 조건을 확인한다. 미충족 시 중단하고 이유를 보고한다.

| 항목 | 기준 |
|------|------|
| 문서 상태 | `confirmed`여야 한다 |
| Ready for Operations | `true`여야 한다 |
| 7_operation.md 존재 여부 | 이미 존재하면 덮어쓰기 의사를 확인하고, 의사 표현이 없으면 중단한다 |

### 3. 내용 추출

`6_release.md`, `5_verification.md`, `1_discovery.md`에서 아래 항목을 읽어 Operations 초안 작성에 사용한다.

- 이슈명 (`# 0`의 `이슈명:`)
- 문서 ID / CYCLE_ID
- 배포 환경 및 배포 방식 (`6_release.md` `# 2`)
- 스모크 테스트 항목 (`6_release.md` `# 4`)
- Release 모니터링 확인 항목 (`6_release.md` `# 4`)
- Deferred 처리된 오픈 질문 (`6_release.md` `# 5`)
- 성공 기준(S-N) (`1_discovery.md` `# 7`)

### 4. Operations 초안 작성 원칙

- Release의 스모크 테스트/모니터링 항목을 확장해 지속적인 운영 모니터링 항목을 도출한다.
- 저장소 구조와 배포 방식을 참고해 장애 대응 절차를 구체적으로 초안으로 작성한다.
- `# 6` 다음 Discovery 환류 항목은 초안 생성 시 빈 상태(`없음`)로 두고, 운영 중 갱신하도록 안내한다.
- 아래 항목은 추론 불가 또는 사용자 확인 필요이므로 플레이스홀더로 남긴다.
  - 모니터링 담당자 (`{{OPS_MONITOR_OWNER:TBD}}`)
  - 에스컬레이션 연락처 (`{{OPS_ESCALATION_1:TBD}}`)
  - Freeze 확정 담당자 (`{{CONFIRMED_BY:TBD}}`)

### 5. 자동으로 채워야 하는 항목

| 항목 | 채움 방법 |
|------|---------|
| `# 0` 메타데이터 | 현재 시각, CYCLE_ID, 이슈명, Release 경로를 자동 입력 |
| `# 1` Release 인계 요약 | Release 배포 결과 요약, Deferred 항목 이식 |
| `# 2` 모니터링 항목 | Release 스모크 테스트/모니터링 항목을 기반으로 지속 모니터링 항목 도출, 임계값 초안 작성 |
| `# 3` 런북 — 정상 운영 절차 | Release 배포 방식 기반으로 주기적 확인 절차 초안 작성 |
| `# 3` 런북 — 장애 대응 절차 | 롤백 계획 및 배포 방식 기반으로 장애 초기 대응 절차 초안 작성 |
| `# 5` 리스크 | Release 이월 리스크 중 Operations 관련 항목 포함 |
| `# 6` 다음 Discovery 환류 | `없음`으로 초기화 (운영 중 갱신 안내) |
| `# 8` 파일 처리 결과 | 생성 결과와 참조 문서 경로 채움 |
| `# 9` 사용자 결정 필요 | 모니터링 담당자, 에스컬레이션 담당자 미지정 항목 정리 |
| `# 10` Freeze 플래그 | `Handoff Decision: 보류`, `SDLC 주기 완료: false` 초기값 입력 |

### 6. 파일 생성

- 경로: `docs/sdlc/<CYCLE_ID>/7_operation.md`
- 기반: `.github/templates/sdlc/7_operation.md`를 구조 기준으로 사용하되, 위 작성 원칙에 따라 채운 초안을 생성한다.

### 7. 결과 보고

응답에 아래 내용을 포함한다.

- **생성된 파일 경로**
- **자동 채워진 항목 목록** (어떤 값으로 채웠는지)
- **플레이스홀더로 남긴 항목 목록** (사용자 결정 필요 이유 포함)
- **다음 단계 안내**: `/review-operation <CYCLE_ID>` 실행 안내
