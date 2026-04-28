# {{PROJECT_NAME}} Project Structure

- Status: draft | confirmed
- Owner: {{OWNER_OR_TEAM}}
- Last Updated (KST): {{UPDATED_AT_KST}}
- Source Discovery / Batch: {{SOURCE_REF}}

## Purpose
- This document is the current approved repository and package structure baseline.
- It is a cross-cutting reference document for Discovery, REQ, Batch Design, Batch Verification, and implementation updates.

## Scope
- Covers the top-level repository layout and package/module boundaries.
- Does not duplicate detailed business rules, acceptance criteria, or implementation-only function signatures.

## Top-Level Structure

```text
.
├── <top-level directories>
└── <top-level files>
```

## Package / Module Responsibilities

- `<path-or-package-1>`
	- <responsibility summary>
- `<path-or-package-2>`
	- <responsibility summary>
- `<path-or-package-3>`
	- <responsibility summary>

## Dependency Rules

- `<dependency rule 1>`
- `<dependency rule 2>`
- `<dependency rule 3>`

## Shared Boundaries

- `<shared boundary 1>`
- `<shared boundary 2>`

## Current Gaps / Planned Changes

- `<gap or planned structural change 1>`
- `<gap or planned structural change 2>`

## Update Triggers

- Update this document when package boundaries change.
- Update this document when new top-level runtime or domain modules are added.
- Update this document when a batch changes the approved structure baseline.

## Change Log

- {{CHANGE_LOG_1}}
