# SDLC Rules Changelog

## Update 01 - Initial Baseline (2026-04-14)

### Scope

1. 전역 SDLC 거버넌스 규칙 생성
2. 7단계 instructions 생성
3. 역할별 agents 생성
4. 공통 skills 3종 생성

### Added Files

1. .github/copilot-instructions.md
2. .github/AGENTS.md
3. .github/instructions/01-discovery.instructions.md
4. .github/instructions/02-planning.instructions.md
5. .github/instructions/03-design.instructions.md
6. .github/instructions/04-implementation.instructions.md
7. .github/instructions/05-verification.instructions.md
8. .github/instructions/06-release.instructions.md
9. .github/instructions/07-operations.instructions.md
10. .github/agents/planner.agent.md
11. .github/agents/builder.agent.md
12. .github/agents/reviewer.agent.md
13. .github/agents/releaser.agent.md
14. .github/skills/requirements-refinement/SKILL.md
15. .github/skills/test-design/SKILL.md
16. .github/skills/release-notes/SKILL.md

### Notes

1. 단계 스킵 금지 및 핫픽스 예외 경로를 전역 규칙에 포함
2. 각 단계에 DoR/DoD를 명시해 게이트 기반 전환 지원
3. 스킬 description에 Use when 트리거를 넣어 자동 탐지성 강화

## Update 02 - Stage Rule Hardening (2026-04-14)

### Scope

1. Discovery 단계 질문 템플릿 강화
2. Planning 단계 WSJF/RICE 우선순위 규칙 추가
3. Verification 단계 품질 게이트 엄격화
4. Release/Operations 롤백 및 포스트모템 체크리스트 상세화

### Changed Files

1. .github/instructions/01-discovery.instructions.md
2. .github/instructions/02-planning.instructions.md
3. .github/instructions/05-verification.instructions.md
4. .github/instructions/06-release.instructions.md
5. .github/instructions/07-operations.instructions.md

### Verification

1. 단계별 필수 섹션(템플릿/공식/게이트/체크리스트) 존재 여부 확인
2. DoD 강화 항목 반영 여부 확인

### Follow-up

1. Planning 점수 예시(샘플 backlog) 추가
2. Verification 예외 승인 워크플로우 문서화
3. Release 런북 템플릿 파일 분리

## Update 03 - Templates and Governance Completion (2026-04-14)

### Scope

1. Planning에 WSJF/RICE 샘플 백로그 점수표 템플릿 추가
2. Verification에 예외 승인 워크플로우(승인자/유효기간) 표준 템플릿 추가
3. Release에 롤백 런북을 별도 템플릿 파일로 분리

### Changed Files

1. .github/instructions/02-planning.instructions.md
2. .github/instructions/05-verification.instructions.md
3. .github/instructions/06-release.instructions.md
4. .github/templates/rollback-runbook.template.md

### Verification

1. Planning에 WSJF/RICE 샘플 테이블 섹션 존재 확인
2. Verification에 Exception Approval Workflow 및 Exception Record Template 존재 확인
3. Release가 분리된 롤백 런북 템플릿 경로를 참조하는지 확인

### Follow-up

1. WSJF/RICE 점수표 자동 계산 스크립트 여부 검토
2. 예외 승인 템플릿의 승인자 역할 정책 세분화
3. 롤백 런북 실제 서비스별 인스턴스 문서 작성

## Update 04 - Project Start Readiness (2026-04-14)

### Scope

1. 서비스별 롤백 런북 인스턴스 문서 생성
2. Planning 점수표 자동 계산 스크립트/시트 템플릿 추가
3. Verification 예외 승인 권한 정책(역할별 승인 범위) 고도화
4. 프로젝트 시작 가이드 문서 추가

### Changed Files

1. .github/runbooks/services/api.rollback-runbook.md
2. .github/runbooks/services/worker.rollback-runbook.md
3. .github/runbooks/services/web.rollback-runbook.md
4. .github/templates/planning-backlog-scores.template.csv
5. .github/templates/planning-scoring-sheet.template.csv
6. .github/tools/calc_priority_scores.sh
7. .github/instructions/02-planning.instructions.md
8. .github/instructions/05-verification.instructions.md
9. .github/instructions/06-release.instructions.md
10. .github/START-HERE.md

### Verification

1. 서비스별 런북 인스턴스 파일 생성 확인
2. Planning 스크립트 실행으로 priority 산출 가능 여부 확인
3. Verification 문서에 Approval Authority Matrix/Policy Rules 반영 확인

### Follow-up

1. 서비스별 실제 운영 연락처/임계치 값 최신화
2. 점수 계산 결과를 CI 아티팩트로 저장하는 자동화 검토
3. 운영 단계 Postmortem 템플릿과 티켓 시스템 연동

## Update 05 - Discovery Artifact Convention (2026-04-14)

### Scope

1. Discovery 문서 저장 폴더/파일명 규칙 표준화
2. Discovery 작성 템플릿 파일 추가
3. Discovery Freeze 필수 필드 규정 반영

### Changed Files

1. .github/instructions/01-discovery.instructions.md
2. .github/discovery/README.md
3. .github/templates/discovery-note.template.md
4. .github/START-HERE.md

### Verification

1. Discovery instructions에 Artifact Convention 섹션 존재 확인
2. 템플릿 파일로 즉시 문서 작성 가능한지 확인
3. 시작 가이드에 경로/파일명 규칙 노출 확인

### Follow-up

1. /discovery-draft 출력을 .github/discovery/ 파일로 자동 저장하는 워크플로우 검토
2. Discovery 승인자 역할(Approver) 기본값 정책 확정

## Update 06 - Discovery Output Path Migration (2026-04-14)

### Scope

1. Discovery 산출물 저장 경로를 .github에서 프로젝트 폴더로 전환
2. 신규 표준 경로 docs/sdlc/discovery/ 적용
3. 레거시 .github/discovery 경로는 안내 전용으로 전환

### Changed Files

1. .github/instructions/01-discovery.instructions.md
2. .github/START-HERE.md
3. .github/prompts/discovery-draft.prompt.md
4. docs/sdlc/discovery/README.md
5. .github/discovery/README.md

### Verification

1. Discovery 규칙 문서의 저장 경로가 docs/sdlc/discovery/로 표기되는지 확인
2. 시작 가이드가 동일 경로를 참조하는지 확인
3. 프롬프트가 저장 요청 시 신규 경로/파일명 규칙을 따르는지 확인

### Follow-up

1. 기존 .github/discovery 문서의 점진적 마이그레이션 일정 수립
2. Planning/Verification 산출물 경로도 프로젝트 폴더로 통일할지 검토

## Update 07 - discovery-draft Auto Creation Flow (2026-04-14)

### Scope

1. /discovery-draft 실행 시 현재 계획 상태 확인 절차 추가
2. 기존 요구사항/신규 요구사항 판정 로직 추가
3. 신규 요구사항일 때 docs/sdlc/discovery/에 자동 초안 생성 규칙 추가

### Changed Files

1. .github/prompts/discovery-draft.prompt.md
2. docs/sdlc/discovery/README.md

### Verification

1. 프롬프트에 계획 상태 요약 섹션 포함 확인
2. 프롬프트에 요구사항 판정 결과(기존/신규) 섹션 포함 확인
3. 자동 생성 경로 docs/sdlc/discovery/ 표기 확인

### Follow-up

1. docs/sdlc/discovery를 단일 표준 경로로 유지
2. 판정 기준(키워드 60%)의 팀별 튜닝 기준 문서화

## Update 08 - Path Standardization to docs/sdlc (2026-04-14)

### Scope

1. discovery-draft 자동 생성 경로를 docs/sdlc/discovery로 통일
2. 잘못 표기된 docs/sldc 참조 제거 및 표기 정리

### Changed Files

1. .github/prompts/discovery-draft.prompt.md
2. .github/SDLC-CHANGELOG.md

### Verification

1. 프롬프트에서 docs/sldc 문자열 제거 확인
2. 프롬프트 생성 경로가 docs/sdlc/discovery로 표기되는지 확인

### Follow-up

1. 남아있는 레거시 docs/sldc 폴더 정리

## Update 09 - Auto Discovery Freeze Generation (2026-04-14)

### Scope

1. /discovery-draft 결과에 Discovery Freeze 섹션을 필수 포함
2. 신규 Discovery 파일 자동 생성 시 Freeze 필수 필드 자동 채움 규칙 추가

### Changed Files

1. .github/prompts/discovery-draft.prompt.md
2. .github/SDLC-CHANGELOG.md

### Verification

1. 프롬프트 출력 섹션에 Discovery Freeze 포함 여부 확인
2. 프롬프트 규칙에 Freeze 필드 강제 규칙 포함 여부 확인

### Follow-up

1. 기존 Discovery 문서에 Freeze 누락 여부 배치 점검

## Update 10 - Discovery Freeze Confirmation Gate (2026-04-14)

### Scope

1. Discovery Freeze에 사용자 확인 항목(User Confirmation Checklist) 추가
2. 완료 플래그(Freeze Status Flag) 추가
3. /discovery-draft 자동 생성 시 기본값 미완료([ ], Ready for Planning: false) 강제

### Changed Files

1. .github/instructions/01-discovery.instructions.md
2. .github/templates/discovery-note.template.md
3. .github/prompts/discovery-draft.prompt.md
4. docs/sdlc/discovery/2026-04-14-embedded-module-integration-new-and-existing-projects.discovery.md

### Verification

1. Discovery Freeze Required Fields에 Checklist/Flag 포함 확인
2. 템플릿에 체크박스/플래그 기본값 존재 확인
3. 현재 Discovery 문서에 즉시 체크 가능한 항목 반영 확인

### Follow-up

1. 기존 Discovery 문서 일괄 점검 후 동일 형식으로 정규화

## Update 11 - Discovery Document ID Naming (2026-04-14)

### Scope

1. Discovery 파일명 규칙을 문서번호 시작 형식으로 변경
2. 날짜를 생성일 메타데이터로 유지하는 원칙 명시
3. discovery-draft 자동 생성 규칙을 새 파일명 형식에 맞게 갱신

### Changed Files

1. .github/instructions/01-discovery.instructions.md
2. .github/prompts/discovery-draft.prompt.md
3. .github/discovery/README.md
4. .github/START-HERE.md
5. docs/sdlc/discovery/README.md

### Verification

1. Discovery 규칙 문서에 dcy-<3자리문서번호>_YYYY-MM-DD_<topic-slug>.discovery.md 형식 반영 확인
2. discovery-draft 프롬프트에 문서번호 계산 규칙 반영 확인
3. 사용자 안내 문서의 예시 파일명이 새 규칙으로 갱신되었는지 확인

### Follow-up

1. 기존 Discovery 산출물의 파일명 이관 여부는 필요 시 별도 결정

## Update Template

### Scope

1. 변경 대상 단계
2. 변경 이유
3. 기대 효과

### Changed Files

1. path/to/file

### Verification

1. 검증 방법
2. 결과

### Follow-up

1. 다음 업데이트 항목
