
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

### 빠른 시작

처음부터 전체 SDLC 초안 세트를 만들고 싶다면 아래 명령으로 같은 번호의 draft 문서 세트를 한 번에 생성할 수 있다.

```text
/new-sdlc 결제 실패 알림 정책을 도입한다
```

이 명령은 `dcy/pln/dsn/imp/ver/rel/ops` 문서를 같은 번호로 모두 `draft` 상태로 만든다. 다만 승인 작업은 Discovery부터 순차적으로 진행해야 한다.

초안 생성 후 순차 검토/승인을 자동 실행하려면 아래 명령을 사용한다.

```text
/run-sdlc dcy-001 홍길동
```

이 명령은 Discovery부터 Operations까지 순서대로 검토/승인을 시도한다. 이미 승인된 단계는 건너뛰며, 중간 단계에서 승인 불가면 해당 단계에서 멈추고 미충족 항목과 추가 결정사항을 알려준다.

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
/new-sdlc 결제 실패 알림 정책을 도입한다
/review-discovery sdlc-001
/confirm-discovery sdlc-001

# Planning
/draft-planning sdlc-001
/review-planning sdlc-001
/confirm-planning sdlc-001

# Design
/draft-design sdlc-001
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

### 언제 새 Discovery를 만드는가

운영 중 문제를 발견했을 때는 먼저 `/operation-triage`로 분류한 뒤 아래 기준으로 판단한다.

| operation-triage 판정 결과 | 상황 | 새 Discovery 필요 여부 | 권장 처리 |
|---|---|---:|---|
| 구현 문제 | 기존 요구사항/설계/검증 기준은 있었는데 구현이 어긋남, 그리고 관련 문서가 `confirmed` 이후 상태임 | 필요 | corrective change용 Discovery를 새로 만들고 Planning부터 다시 진행 |
| 구현 문제 | 관련 문서가 모두 `draft`이고 기존 범위 안에서 수정 가능 | 불필요 | 기존 Discovery/Design/Implementation/Verification 문서에 흡수 |
| 설계·요구사항 누락 | 기능은 있었지만 예외 시나리오, 비기능 요구, 운영 리스크가 빠짐 | 필요 | 누락 요구를 위한 새 Discovery 생성 |
| 신규 범위 | 기존 SDLC 문서에 실질적으로 없는 기능/정책/요구 | 필요 | 새 Discovery 생성 |
| 운영 보완만 필요 | 코드/요구 변경 없이 모니터링, 런북, 공지, 절차만 보완 | 불필요 | Operations 문서 보강 |
| 판단 보류 | 관련 문서 부족, 근거 상충, 재현 불충분 | 보류 | 정보 보강 후 `/operation-triage` 재실행 |
| Hotfix 필요 | 서비스 중단, 데이터 손실, 보안 영향 등 긴급 대응 우선 | 필요 | Hotfix로 즉시 대응 후 후속 Discovery 생성 및 Postmortem 환류 |

짧은 판단 기준:

1. 완료된 SDLC 결과물을 바꾸는 수정이면 새 Discovery를 만든다.
2. 아직 draft 단계 문서 보정이면 기존 문서에 흡수한다.
3. 운영 문서 보완만 하면 되면 새 Discovery는 만들지 않는다.

### 참고 파일

1. 시작 가이드: `.github/START-HERE.md`
2. 단계 규칙: `.github/instructions/`
3. 프롬프트 정의: `.github/prompts/`
4. 템플릿: `.github/templates/`
5. Operations 템플릿: `.github/templates/operations-note.template.md`
6. 플레이스홀더 가이드: `.github/instructions/placeholder-guide.md`
