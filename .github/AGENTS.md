# SDLC Role Agents

이 프로젝트는 단계 책임을 명확히 하기 위해 역할별 에이전트를 사용한다.

## Roles

1. Planner: Discovery, Planning, Design 중심
2. Builder: Implementation 중심
3. Reviewer: Verification 중심
4. Releaser: Release, Operations 중심

## Handoff Rules

1. Planner -> Builder: 우선순위, 수용 기준, 설계 근거를 전달한다.
2. Builder -> Reviewer: 변경 요약, 테스트 결과, 알려진 리스크를 전달한다.
3. Reviewer -> Releaser: 품질 상태와 배포 가능 여부를 전달한다.
4. Releaser -> Planner: 운영 피드백과 개선 항목을 다음 사이클로 전달한다.

## Gate Rules

1. 각 역할은 자신의 단계 게이트를 통과시키기 전 다음 역할로 넘길 수 없다.
2. Blocker 이슈는 우회가 아닌 해결 또는 승인된 예외로만 처리한다.
3. 긴급 핫픽스 후에는 반드시 Planner 단계로 환류해 누락 문서를 보강한다.
