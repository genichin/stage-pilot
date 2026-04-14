# SDLC Project Start Guide

## 1. Kickoff Order

1. Discovery 문서 작성
2. Planning 점수표 산정(WSJF/RICE)
3. Design 근거 기록
4. Implementation + 테스트
5. Verification 게이트 통과
6. Release 체크리스트 + 런북 준비
7. Operations 모니터링 및 환류

### Discovery 저장 규칙

1. 저장 폴더: docs/sdlc/discovery/
2. 파일명 형식: dcy-<3자리문서번호>_YYYY-MM-DD_<topic-slug>.discovery.md
3. 날짜는 생성일 기준으로 유지
4. 작성 템플릿: .github/templates/discovery-note.template.md
5. 문서 하단 Discovery Freeze 필수

## 2. Planning Scoring Quick Start

1. 템플릿 복사: .github/templates/planning-backlog-scores.template.csv
2. 항목 입력 후 자동 계산 실행:

```bash
bash .github/tools/calc_priority_scores.sh .github/templates/planning-backlog-scores.template.csv docs/sdlc/planning/planning-backlog-scores.out.csv
```

3. 산출물 확인: selected_score 내림차순으로 priority 부여됨

## 3. Rollback Runbook Quick Start

1. 기본 템플릿: .github/templates/rollback-runbook.template.md
2. 서비스별 인스턴스:
   - .github/runbooks/services/api.rollback-runbook.md
   - .github/runbooks/services/worker.rollback-runbook.md
   - .github/runbooks/services/web.rollback-runbook.md
3. 배포 전 각 서비스 인스턴스의 Trigger/Procedure/Validation 최신화

## 4. Verification Exception Quick Start

1. Major 결함 예외는 승인자 정책을 따름
2. Valid Until 설정은 만료 전 재검증 필수
3. 만료/해소 상태를 검증 리포트에 반영

## 5. Minimum Go-live Checklist

1. 우선순위 점수표 완료
2. 테스트 실행 근거 첨부
3. 예외 승인 문서(해당 시) 첨부
4. 서비스별 롤백 런북 최신화
5. 릴리즈/운영 체크리스트 승인
