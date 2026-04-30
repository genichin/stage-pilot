# Sample Host Project Structure

- Status: confirmed
- Owner: Platform Team
- Last Updated (KST): 2026-04-30 16:30
- Source Discovery / Batch: bootstrap-baseline

## Purpose
- This document captures the initial repository structure baseline after StagePilot bootstrap.
- It becomes a shared reference before the first real Discovery starts.

## Scope
- Covers top-level repository layout and broad module boundaries.
- Does not define feature-specific acceptance criteria or delivery units.

## Top-Level Structure

```text
.
├── .github/
├── docs/
├── src/
├── tests/
└── README.md
```

## Package / Module Responsibilities

- `.github/`
	- StagePilot skills, templates, and host instructions installed into the repository.
- `docs/`
	- Active SDLC docs, index files, and cross-cutting baseline references.
- `src/`
	- Product and service implementation code.
- `tests/`
	- Automated checks and regression coverage.

## Dependency Rules

- Delivery documents under `docs/` must not be treated as implementation modules.
- `src/` can evolve independently, but structure changes should update this baseline.
- Tooling automation under `.github/` must not overwrite host source code.

## Shared Boundaries

- `.github/` provides SDLC workflow assets.
- `docs/` is the source of truth for active SDLC state.
- `src/` and `tests/` remain host-project owned implementation surfaces.

## Current Gaps / Planned Changes

- The first real Discovery has not been created yet.
- Actual domain module boundaries will be refined once the first delivery topic is defined.

## Update Triggers

- Update this document when top-level directories change.
- Update this document when module ownership boundaries change.
- Update this document when a batch changes the approved structure baseline.

## Change Log

- 2026-04-30: bootstrap-baseline created the initial repository structure baseline.