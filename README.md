
# 사용방법

## 최초 등록

```bash
# 리모트 등록
git remote add stage-pilot https://github.com/genichin/stage-pilot.git
# subtree 추가
git fetch stage-pilot main
git subtree add --prefix=.vendor/stage-pilot stage-pilot main --squash
# 설치
bash .vendor/stage-pilot/bootstrap/install.sh .
```

## 업데이트

```bash
# 원격이 등록된 경우(stage-pilot remote 우선 사용)
bash .vendor/stage-pilot/bootstrap/update.sh .

# 충돌 파일을 보존하고 싶을 때(덮어쓰기 비활성화)
bash .vendor/stage-pilot/bootstrap/update.sh --no-overwrite .

# 원격 없이 URL로 직접 업데이트
bash .vendor/stage-pilot/bootstrap/update.sh --repo-url https://github.com/genichin/stage-pilot.git .

# 설치 재적용 없이 subtree만 갱신
bash .vendor/stage-pilot/bootstrap/update.sh --skip-install .
```

## SDLC 프롬프트 사용법

`.github/prompts/`에 단계별 프롬프트가 정의되어 있으며, Copilot Chat에서 `/프롬프트이름 인자` 형태로 실행한다.

### 기본 실행 순서

1. Discovery
2. Planning
3. Design
4. Implementation
5. Verification
6. Release
7. Operations

### 단계별 명령 예시

```text
# Discovery
/discovery-draft 결제 실패 알림 정책을 도입한다
/discovery-review dcy-001
/discovery-confirm dcy-001

# Planning
/planning-draft dcy-001
/planning-review dcy-001
/planning-confirm pln-001

# Design
/design-draft pln-001
/design-review dsn-001
/design-confirm dsn-001

# Implementation
/implementation-draft dsn-001
/implementation imp-001 I-001, I-002
/implementation-confirm imp-001

# Verification
/verification-draft imp-001
/verification-review ver-001
/verification-confirm ver-001

# Release
/release-draft ver-001
/release-review ver-001
/release-confirm ver-001

# Operations
/operation-draft rel-001
/operation-review rel-001
/operation-confirm rel-001
/operation-triage 문제: 로그인 후 세션 만료 시 특정 브라우저에서 무한 리다이렉트가 발생한다. 증상: 만료된 세션으로 접근하면 /login 과 /callback 사이를 반복 이동한다. 기대 동작: 세션 만료 시 로그인 페이지로 1회 이동하고 재로그인 안내를 보여야 한다. 영향도: Safari 사용자 일부가 서비스 재진입 불가. 재현 조건: Safari 17, 기존 세션 쿠키 보유, rel-001 배포 이후. 관련 문서: rel-001 ops-001
```

### 문서 ID 규칙

1. Discovery: `dcy-001`
2. Planning: `pln-001`
3. Design: `dsn-001`
4. Implementation: `imp-001`
5. Verification: `ver-001`
6. Release: `rel-001`

### 참고 파일

1. 시작 가이드: `.github/START-HERE.md`
2. 단계 규칙: `.github/instructions/`
3. 프롬프트 정의: `.github/prompts/`
4. 템플릿: `.github/templates/`
5. Operations 템플릿: `.github/templates/operations-note.template.md`
