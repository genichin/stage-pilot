# Sample Host Project Runtime Flows

- Status: confirmed
- Owner: Platform Team
- Last Updated (KST): 2026-04-30 16:30
- Source Discovery / Batch: bootstrap-baseline

## Purpose
- This document captures the initial command and runtime flow baseline after StagePilot bootstrap.
- It gives later Discovery and Batch work a stable reference before product-specific flows exist.

## Scope
- Covers bootstrap, discovery start, and validation entry points.
- Does not define detailed feature behavior.

## Covered Entry Points

- Copilot Chat `/bootstrap-baseline`
- Copilot Chat `/new-discovery`
- `python3 .github/scripts/stagepilot-doctor.py .`

## Shared Components

- `.github/skills/`
- `docs/project-structure.md`
- `docs/*/index.md`

## Flow: `bootstrap baseline initialization`

1. StagePilot assets are installed into the host repository.
2. `/bootstrap-baseline` creates baseline docs and active index skeletons.
3. The repository becomes ready for the first real Discovery.

## Flow: `first real Discovery start`

1. Maintainer confirms baseline docs are present.
2. Maintainer runs `/new-discovery <real change topic>`.
3. Discovery, REQ, Batch, and Release work begins from that change topic.

## Flow Constraints

- Fresh host repositories should complete baseline initialization before the first real Discovery.
- Structure or orchestration changes must update this document or `docs/project-structure.md`.

## Current Gaps / Planned Changes

- Product-specific runtime orchestration is not defined yet.
- Delivery and release flows will be added by later Discovery and Batch work.

## Update Triggers

- Update this document when command entry points change.
- Update this document when runtime orchestration changes.
- Update this document when a batch changes the approved flow baseline.

## Change Log

- 2026-04-30: bootstrap-baseline created the initial runtime flow baseline.