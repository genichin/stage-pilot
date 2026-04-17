---
name: "new-sdlc"
description: "Create next SDLC cycle folder and draft 1_discovery.md from slash-command arguments"
argument-hint: "예: 사용자 로그인 기능 추가 - OAuth2 소셜 로그인, 세션 관리, 로그아웃 처리"
agent: "agent"
---
/new-sdlc 로 들어온 인자를 기반으로 새 SDLC 주기를 생성한다.

목표:
- `docs/sdlc/sdlc-<id>_<YYYYMMDD>_<topic-slug>/` 폴더를 생성한다.
- 위 폴더에 `1_discovery.md` draft 문서를 생성한다.
- 위 폴더에 `index.md`, `summary.md` draft 문서를 함께 생성한다.
- `1_discovery.md`는 템플릿 복사본이 아니라, 입력 문장을 바탕으로 기본 내용을 가능한 한 채운 초안이어야 한다.

입력 해석:
- 사용자가 `/new-sdlc ...` 뒤에 입력한 전체 텍스트를 이슈 원문으로 사용한다.
- 이슈명은 원문을 유지한다.
- `topic-slug`는 이슈 원문을 소문자 kebab-case로 변환해 만든다.
- slug 규칙:
  - 영문/숫자 외 문자는 `-`로 치환
  - 연속 `-`는 하나로 축약
  - 시작/끝 `-` 제거
  - 결과가 비면 `untitled` 사용

Discovery 초안 작성 원칙:
- 입력 문장이 짧더라도 기능 목적, 예상 사용자, 산출물, 성공 조건을 합리적으로 추론해 초안을 작성한다.
- 이미 입력만으로 추론 가능한 내용은 플레이스홀더로 남기지 말고 자연어 문장으로 채운다.
- 사용자 승인, 외부 데이터, 정책 결정, 확정 범위 경계처럼 추론만으로 확정하면 안 되는 항목만 플레이스홀더로 남긴다.
- 사용자 결정이 필요한 항목은 `결정 필요` 같은 일반 문장으로만 쓰지 말고, 반드시 `{{...}}` 플레이스홀더 형태로 남긴다.
- 모르면 공란으로 두지 말고 아래 둘 중 하나로 처리한다.
  - 합리적 기본안 제시 가능: 초안 문장으로 채운다.
  - 사용자 확인이 반드시 필요: `# 10. 사용자 결정 필요 항목 요약`에 넣고 관련 본문에는 최소 플레이스홀더를 남긴다.

자동으로 채워야 하는 Discovery 섹션:
- `# 1. 계획 상태 요약`
  - `해석` 2줄은 입력 요청을 바탕으로 직접 작성한다.
- `# 2. 요구사항 판정 결과`
  - 기본값은 `신규`로 두되, 입력만으로 명백한 중복/유사라고 판단 가능한 경우에만 다르게 쓴다.
  - 근거도 2줄 작성한다.
- `# 3. 문제점의 요약`
  - 현재 상태, 기대 상태, 이해관계자, 주요 사용자 시나리오를 입력 기반으로 채운다.
- `# 4. 이번에 정의할 변경`
  - 핵심 변경 항목 1~3개를 직접 작성한다.
  - `영향 범위`의 코드/문서/운영 영향도 추론해 채운다.
- `# 5. 요구사항 목록`
  - FR 2개 이상, NFR 1개 이상을 직접 작성한다.
  - In Scope/Out of Scope는 초안 수준으로 제안하되, 사용자 승인 없이는 확정할 수 없는 경계는 플레이스홀더로 남긴다.
- `# 6. 리스크/가정 목록`
  - 리스크 2개 이상, 가정 2개 이상을 직접 작성한다.
  - 오픈 질문은 정말 결정이 필요한 경우에만 남긴다.
- `# 7. 초기 성공 기준`
  - 성공 기준 2개 이상과 측정 방식/데이터 출처 초안을 작성한다.
- `# 9. 파일 처리 결과`
  - 생성 결과와 최소 참조 문서를 채운다. 참조 문서가 없으면 `없음`이라고 쓴다.
- `# 10. 사용자 결정 필요 항목 요약`
  - 자동 추론으로 확정할 수 없는 항목만 `DECIDE`, `CONFIRM`, `DATA`에 넣는다.
  - 이 섹션의 항목은 설명문이 아니라 플레이스홀더 형식으로 남긴다.
- `# 11. Discovery Freeze`
  - `Handoff Decision`은 기본 `보류`로 둔다.
  - `Handoff Rationale`에는 "초기 Discovery 초안 생성 완료, Planning 인계 전 사용자 확인 필요"와 같이 현재 상태를 적는다.

플레이스홀더를 유지해도 되는 대표 항목:
- 승인/확정 책임자
- 외부 문서 경로, 아직 없는 후속 산출물 경로
- 사용자 확인이 필요한 범위 경계
- 데이터 출처가 실제로 정해지지 않은 성공 지표 측정값
- 오픈 질문의 최종 답변

플레이스홀더 유지 규칙:
- 사용자 승인 전 확정되면 안 되는 정책/범위/산출물 위치/대상 독자 결정은 본문에도 플레이스홀더를 남긴다.
- `# 10. 사용자 결정 필요 항목 요약`에 들어가는 항목은 반드시 `{{DECIDE_*}}`, `{{CONFIRM_*}}`, `{{DATA_*}}` 형태를 사용한다.
- `TBD` 같은 일반 문자열보다 의미가 드러나는 플레이스홀더를 우선 사용한다.

실행 절차:
1. `docs/sdlc/` 아래의 기존 폴더 중 `sdlc-<3자리>_` 패턴을 스캔해 최대 번호를 찾는다.
2. 다음 번호를 3자리 zero-pad로 계산한다. 예: `001`, `002`, ...
3. 오늘 날짜를 `YYYYMMDD`로 구한다.
4. `CYCLE_ID = sdlc-<id>_<YYYYMMDD>_<topic-slug>`를 만든다.
5. `docs/sdlc/<CYCLE_ID>/` 폴더를 생성한다.
6. `.github/templates/sdlc/1_discovery.md`를 기반으로 `docs/sdlc/<CYCLE_ID>/1_discovery.md`를 생성한다.
7. [`.github/templates/sdlc/index.md`](../../.github/templates/sdlc/index.md)를 기반으로 `docs/sdlc/<CYCLE_ID>/index.md`를 생성한다.

8. `.github/templates/sdlc/summary.md`가 있으면 이를 기반으로 `docs/sdlc/<CYCLE_ID>/summary.md`를 생성한다. 템플릿이 없으면 아래 기본 골격으로 생성한다.

  ```md
  # Summary - {{CYCLE_ID}}

  - 이슈명: {{ISSUE_NAME}}
  - 상태: {{SUMMARY_STATUS:draft|review|confirmed}}
  - 작성 시각(KST): {{CREATED_AT_KST}}
  - 마지막 갱신 시각(KST): {{UPDATED_AT_KST}}

  ## 핵심 요약
  - {{SUMMARY_POINT_1}}
  - {{SUMMARY_POINT_2:필요 없으면 삭제}}

  ## 단계별 문서
  - [Discovery](./1_discovery.md)
  - [Index](./index.md)
  ```

9. 생성 파일들에서 아래 플레이스홀더를 우선 치환한다.
   - `{{DOC_STATUS:draft|review|confirmed}}` -> `draft`
   - `{{CYCLE_ID:sdlc-<3자리>_<YYYYMMDD>_<topic-slug>}}` -> 계산한 `CYCLE_ID`
  - `{{CYCLE_ID}}` -> 계산한 `CYCLE_ID`
   - `{{ISSUE_NAME:짧은 한글 또는 영문 이슈명}}` -> 사용자 입력 원문
  - `{{ISSUE_NAME}}` -> 사용자 입력 원문
   - `{{CREATED_AT_KST:TBD}}` -> 현재 시각(KST)
  - `{{CREATED_AT_KST}}` -> 현재 시각(KST)
   - `{{UPDATED_AT_KST:TBD}}` -> 현재 시각(KST)
  - `{{UPDATED_AT_KST}}` -> 현재 시각(KST)
   - `{{OUTPUT_PATH}}` -> 생성 파일 경로
   - `{{FILE_RESULT:생성|갱신|미생성}}` -> `생성`
  - `{{SUMMARY_STATUS:draft|review|confirmed}}` -> `draft`
10. `1_discovery.md`에서는 위 규칙에 따라 추론 가능한 플레이스홀더를 적극적으로 실제 내용으로 치환한다.
11. 추론 불가능하거나 사용자 확인이 필요한 항목만 플레이스홀더로 남긴다.
12. `docs/sdlc/index.md` 전역 인덱스를 갱신한다.
    - 파일이 없으면 아래 초기 골격으로 신규 생성한다.

      ```md
      # SDLC 전체 주기 인덱스

      <!-- 아래 테이블은 /new-sdlc 실행 시 자동 갱신된다. 수동 편집 금지. -->

      ## 주기 목록

      | ID | 날짜 | 이슈명 | Discovery | 상태 |
      |---|---|---|---|---|

      ## 단계별 횡단 조회

      | 단계 | 문서 목록 |
      |---|---|
      | Discovery | |
      | Planning | |
      | Design | |
      | Implementation | |
      | Verification | |
      | Release | |
      | Operations | |
      ```

    - 파일이 이미 있으면 다음 규칙으로 갱신한다.
      - `## 주기 목록` 테이블에 새 행을 추가한다. 형식:
        `| <CYCLE_ID> | <YYYYMMDD> | <ISSUE_NAME> | [Discovery](./<CYCLE_ID>/1_discovery.md) | draft |`
      - `## 단계별 횡단 조회` 테이블에서 `Discovery` 행의 `문서 목록` 셀에 `[<CYCLE_ID>](./<CYCLE_ID>/1_discovery.md)` 링크를 추가한다.
      - 나머지 단계 행은 해당 단계 파일이 실제로 존재할 때만 링크를 추가한다(지금은 Discovery만 추가).
      - 테이블 구조 자체는 변경하지 않는다. 행/셀 추가만 한다.

응답 형식:
- 생성된 `CYCLE_ID`
- 생성한 폴더 경로
- 생성한 파일 경로 목록 (`1_discovery.md`, `index.md`, `summary.md`)
- `docs/sdlc/index.md` 갱신 결과 (신규 생성 또는 갱신된 행 내용)
- 자동으로 채운 Discovery 핵심 섹션 요약
- 사용자 확인이 필요해 플레이스홀더로 남긴 항목 요약

중요 규칙:
- 질문 없이 바로 생성을 시도한다. (입력이 비어 있어 slug를 만들 수 없는 경우에만 짧게 확인)
- 기존 동일 경로가 있으면 덮어쓰지 말고, 다음 ID를 재계산해 새 주기로 생성한다.
- `docs/sdlc/index.md`에 이미 같은 `CYCLE_ID` 행이 있으면 중복 추가하지 않는다.
- 불필요한 파일은 만들지 않는다.
