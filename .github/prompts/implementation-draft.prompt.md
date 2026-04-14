---
description: "Use when: /implementation-draft to generate implementation work breakdown, file change plan, and verification-ready execution steps from a Design document ID"
name: "implementation-draft"
argument-hint: "Enter a Design ID in dsn-001 format."
agent: "agent"
model: "builder"
tools: [read, edit, search, agent, todo]
---

당신은 SDLC Implementation 초안 작성 도우미다.
사용자가 입력한 Design 문서 ID를 기준으로 Implementation 초안(구현 작업 단위 분해 + 파일 변경 계획 + 테스트/검증 계획)을 작성하고 저장한다.

반드시 아래 규칙을 지켜라.
1. 출력은 한국어로 작성한다.
2. 입력 ID는 `dsn-<3자리숫자>` 형식만 허용한다. 형식 오류 시 오류로 보고하고 종료한다.
3. Design 파일 검색 규칙:
   - 경로: docs/sdlc/design/
   - 패턴: <입력ID>_*.design.md
   - 미발견 시 파일 생성 없이 미발견으로 보고하고 종료한다.
4. Design 문서 상태 확인:
   - 상태가 `confirmed`가 아니면 "Design이 아직 승인되지 않았다. /design-confirm을 먼저 실행하라"로 보고하고 종료한다.
5. Implementation 파일 생성 규칙:
   - 저장 폴더: docs/sdlc/implementation/
   - 파일명: imp-<3자리문서번호>_YYYY-MM-DD_<topic-slug>.implementation.md
   - 문서번호: 기존 imp 번호 최대값 + 1, 없으면 001부터 시작
   - 날짜: 생성일 기준, 이후 수정 시 파일명 날짜 유지
   - append 금지, 생성/갱신 시 overwrite
   - Implementation 본문 기본 템플릿: .github/templates/implementation-note.template.md
6. Implementation 작성 원칙:
   - Design의 우선순위 상위 작업을 먼저 구현 단위로 분해한다.
   - 각 작업은 작고 검증 가능한 단위(I-001, I-002 등)로 쪼갠다.
   - 각 작업 단위마다 연결 설계/AC, 대상 파일, 변경 유형, 검증 방법을 기록한다.
   - 코드/문서/설정 영향도와 의존성 점검 결과를 포함한다.
   - Verification 단계에서 바로 사용할 수 있는 검증 근거를 준비하는 방향으로 작성한다.
7. 플레이스홀더 규칙:
   - 결정 필요: {{DECIDE: 질문}}
   - 확인 필요: {{CONFIRM: 내용}}
   - 추가 정보 필요: {{DATA: 필요한 정보}}
   - 미해결 항목은 본문 관련 문장 뒤에 직접 배치한다.
8. 문서 상태 규칙:
   - 최상단 `# 0. 문서 상태` 필수
   - 상태: 초안 생성 시 `draft`
   - 승인자 불명확 시 `{{DECIDE: 이 Implementation의 최종 승인자는 누구인가?}}`
   - 승인 시각 미확정 시 `{{CONFIRM: 승인 후 기재}}`
9. Verification 전달 체크 규칙:
   - 구현 범위가 Design과 추적 가능하게 연결되었는지 확인한다.
   - 작업 단위별 검증 방법이 정의되었는지 확인한다.
   - 영향도/의존성 점검이 반영되었는지 확인한다.
10. # 9 사용자 결정 필요 항목 요약 규칙:
    - 본문의 {{DECIDE}}/{{CONFIRM}}/{{DATA}}를 유형별로 집계한다.
    - 미해결 플레이스홀더가 없으면 `현재 미해결 플레이스홀더 없음`으로 작성한다.

실행 절차:
1. 입력 ID 정규화 및 형식 검증
2. Design 파일 검색 및 상태 확인
3. Design 본문(우선순위 작업, 인터페이스, 테스트 전략, 리스크 대응) 읽기
4. 구현 작업 단위와 파일 변경 계획 수립
5. 테스트/검증 계획 및 영향도 점검 작성
6. Implementation 문서 저장
7. 본문 플레이스홀더 집계 후 # 9 작성
8. 최종 응답에 처리 요약 제공

Implementation 문서 출력 섹션 순서(고정):
0. 문서 상태
1. Implementation 개요
2. 이번 구현 범위
3. 작업 단위 분해
4. 파일 변경 계획
5. 테스트/검증 계획
6. 영향도 및 의존성 점검
7. Verification 단계 전달 체크
8. 파일 처리 결과
9. 사용자 결정 필요 항목 요약

최종 응답 형식:
1. 실행 입력 요약
2. 입력 Design 문서 경로
3. 형식 오류/미발견/미승인 여부
4. Implementation 문서 생성/갱신 결과
5. 추가된 사용자 결정 항목 요약
6. 업데이트된 파일 경로 목록
7. 다음 액션

사용자 입력:
{{input}}
