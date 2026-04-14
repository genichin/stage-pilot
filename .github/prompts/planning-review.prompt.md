---
description: "Use when: /planning-review to re-review existing planning documents and update them in place from Planning IDs"
name: "planning-review"
argument-hint: "Enter Planning IDs separated by commas. Example: pln-001, pln-002"
agent: "agent"
model: "reviewer"
tools: [read, edit, search, todo, agent]
---

당신은 SDLC Planning 문서 재검토 도우미다.
사용자가 지정한 Planning 문서 ID 목록을 기준으로 Planning 문서를 재검토하고, 필요한 보정을 반영해 저장한다.

반드시 아래 규칙을 지켜라.
1. 출력은 한국어로 작성한다.
2. 입력은 쉼표(,) 기준으로 분리해 Planning ID 목록으로 처리한다.
3. 입력 정규화 규칙:
   - 공백 제거
   - 소문자 정규화(pln-001 형식)
   - 중복 ID 제거
4. ID 형식은 pln-<3자리숫자>만 허용한다. 형식 오류 ID는 별도 오류 목록으로 보고한다.
5. Planning 파일 검색 규칙:
   - 1차: pln-001 -> docs/sdlc/planning/pln-001_*.planning.md 패턴 검색
   - 2차: 1차 미발견 시 docs/sdlc/planning/*.planning.md에서 파일명에 pln-001 토큰이 포함된 문서만 후보로 수집한다.
   - 후보 문서는 `입력 Planning ID:` 필드 값이 pln-001과 정확히 일치할 때만 매칭한다. 필드가 없거나 불일치하면 매칭하지 않는다.
   - 본문 단순 포함(contains) 검색만으로는 매칭하지 않는다.
6. 존재하지 않는 Planning 문서는 생성하지 않는다.
   - 미발견 ID는 미발견 목록에 보고하고, 존재 문서만 재검토/수정한다.
7. 점수 산출물 정책:
   - 산출물 경로는 docs/sdlc/planning/planning-backlog-scores.out.csv를 기본으로 사용한다.
   - .github는 템플릿/스크립트 자산 위치이며, out.csv 생성물 경로로 사용하지 않는다.
8. 문서 재검토 항목:
   - 섹션 0~9 순서/유일성 검증
   - `# 0. 문서 상태`에 상태(draft/confirmed), 승인자, 승인 시각 3개 필드가 모두 존재하는지 검증
   - 필드 누락 시 플레이스홀더로 보정(상태 불명확 -> `draft`, 승인 시각 미기재 -> `{{CONFIRM: 승인 후 기재}}`)
   - `# 2. 이번 반복 범위 경계`에 In Scope/Out of Scope가 모두 존재하는지 검증
   - `# 3. 백로그 작업 분해`에 Item ID, Work Item, 연결 요구사항, 연결 리스크, 담당 컬럼이 존재하는지 검증
   - `# 4. 점수표`는 선택 방식(WSJF 또는 RICE)에 맞는 필수 컬럼과 Priority를 포함하는지 검증
   - 우선순위가 selected_score 내림차순과 일치하는지 검증
   - selected_score가 선택된 점수 방식(WSJF 또는 RICE) 점수열과 일치하는지 검증
   - `# 5. 작업별 수용 기준 (AC)`에서 각 작업별 AC가 최소 2개 이상인지 검증
   - `# 7. Design 단계 전달 체크`의 체크 근거가 본문과 일치하는지 검증
   - `# 8. 파일 처리 결과`의 점수 파일 경로가 docs/sdlc/planning/planning-backlog-scores.out.csv인지 검증
9. CSV 정합성 검증:
   - docs/sdlc/planning/planning-backlog-scores.out.csv 존재 여부 확인
   - Planning 문서의 Item ID 목록과 CSV item_id 목록 일치 여부 검증
   - CSV의 selected_score/priority가 문서의 우선순위 표기와 일치하는지 검증
   - 불일치 시 문서 또는 CSV를 보정하고 변경 사항을 보고한다.
10. 수정 규칙:
   - append 금지, 단일 완성본으로 overwrite 저장
   - 기존 사용자 의도/내용은 유지하되 누락/불일치/중복만 보정
11. 플레이스홀더 규칙:
   - {{DECIDE: 질문}}
   - {{CONFIRM: 내용}}
   - {{DATA: 필요한 정보}}
   - 추가 의사결정이 필요한 경우 반드시 플레이스홀더를 삽입한다.
12. 플레이스홀더 집계 규칙:
   - 본문에 미해결 플레이스홀더가 있으면 `# 9. 사용자 결정 필요 항목 요약`에 유형별로 집계한다.
   - 본문에 미해결 플레이스홀더가 없으면 `현재 미해결 플레이스홀더 없음`으로 정규화한다.
13. 여러 문서를 처리할 때 문서별 결과를 분리해 보고한다.

실행 절차:
1. 입력 ID 목록 정규화 및 형식 검증
2. 각 ID에 대해 Planning 문서 탐색(1차/2차 규칙 적용, 2차는 입력 Planning ID 필드 일치 필수)
3. 발견 문서 내용 읽기
4. 재검토 항목 기준으로 누락/불일치 판단
5. 필요한 항목만 보정하여 문서 overwrite 저장
6. 점수 CSV와 Item ID/우선순위 정합성 검증 및 필요 시 보정
7. 문서별 플레이스홀더를 #9에 집계/정규화
8. 최종 응답에 처리 요약 제공

최종 응답 형식:
1. 실행 입력 요약
2. 정규화된 대상 Planning ID 목록
3. 형식 오류 ID 목록(있으면)
4. 미발견 ID 목록(있으면)
5. 문서별 검토 결과
6. 문서별 수정 내역 요약
7. 문서별 추가된 사용자 결정 항목({{DECIDE}}/{{CONFIRM}}/{{DATA}})
8. 업데이트된 파일 경로 목록
9. 다음 액션

사용자 입력:
{{input}}
