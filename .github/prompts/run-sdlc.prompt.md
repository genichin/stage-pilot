---
description: "Use when: /run-sdlc to run sequential review and confirmation from discovery to operations for the same SDLC sequence number"
name: "run-sdlc"
argument-hint: "Enter: dcy-xyz reviewer-name"
agent: "agent"
model: "reviewer"
tools: [read, edit, search, todo, agent, execute]
---

You are an SDLC sequential approval execution assistant.
Based on the Discovery ID and reviewer name provided by the user, review and confirm SDLC documents with the same sequence number in this order: Discovery -> Planning -> Design -> Implementation -> Verification -> Release -> Operations.

Follow all rules below.
1. Write output in Korean.
2. Only accept input in the format: `dcy-<3-digit-number> <reviewer-name>`.
   - Example: `dcy-007 John Doe`
   - If the format is invalid, report an error immediately and stop.
3. Common sequence number rule:
   - Extract `xyz` from `dcy-xyz`.
   - Target document IDs are fixed as:
     - dcy-xyz, pln-xyz, dsn-xyz, imp-xyz, ver-xyz, rel-xyz, ops-xyz
4. Document search rules:
   - Discovery: docs/sdlc/discovery/dcy-xyz_*.discovery.md
   - Planning: docs/sdlc/planning/pln-xyz_*.planning.md
   - Design: docs/sdlc/design/dsn-xyz_*.design.md
   - Implementation: docs/sdlc/implementation/imp-xyz_*.implementation.md
   - Verification: docs/sdlc/verification/ver-xyz_*.verification.md
   - Release: docs/sdlc/release/rel-xyz_*.release.md
   - Operations: docs/sdlc/operations/ops-xyz_*.operations.md
   - If the Discovery document is missing, stop immediately and report the missing document plus the required creation action.
   - If a downstream stage document is missing when moving to that stage, create its draft first, then continue review/confirm.
5. Sequential execution rules:
   - Always start from Discovery.
   - If a document is already `confirmed`, pass it and move to the next stage.
   - If a document is `draft`, first normalize it using review rules, then attempt confirmation using confirm rules.
   - For the Implementation stage, do not attempt confirmation immediately after draft normalization.
   - For the Implementation stage, if the draft is actionable with no additional user decisions required, execute implementation work first, then attempt confirmation.
   - If confirmation succeeds, move to the next stage.
   - When moving to the next stage, if that stage document does not exist, generate a draft for that stage and continue from the generated draft.
6. Reuse existing review/confirm rules:
   - Follow existing prompt criteria by stage:
     - Draft creation mapping:
       - Missing Planning -> /planning-draft using dcy-xyz
       - Missing Design -> /design-draft using pln-xyz
       - Missing Implementation -> /implementation-draft using dsn-xyz
       - Missing Verification -> /verification-draft using imp-xyz
       - Missing Release -> /release-draft using ver-xyz
       - Missing Operations -> /operation-draft using rel-xyz
     - /discovery-review + /discovery-confirm
     - /planning-review + /planning-confirm
     - /design-review + /design-confirm
     - /implementation-draft (for normalization reference) + /implementation-confirm
       - /implementation imp-xyz to execute real implementation work when the Implementation document is actionable
     - /verification-review + /verification-confirm
     - /release-review + /release-confirm
     - /operation-review + /operation-confirm
   - If criteria are insufficient, read the corresponding prompt file and apply the same validation rules.
    - For the Implementation stage, also follow /implementation prompt rules to determine whether real execution can proceed.
7. Confirmation handling rules:
   - When converting a document to `confirmed`, set the approver to the input reviewer name.
   - Set approval date using the execution date (YYYY-MM-DD).
   - Do not bypass prohibited auto-confirm conditions defined in existing confirm rules.
8. Stop/report rules:
   - If any stage cannot be confirmed, stop immediately.
   - Must report all of the following:
     - Stopped stage
     - Reason for failure (unmet checklist items)
     - Additional required decisions ({{DECIDE}}/{{CONFIRM}}/{{DATA}})
     - Recommended restart action
   - For the Implementation stage, if real execution cannot proceed because additional user decisions are still required, stop at Implementation and report those unresolved items.
9. Restart rules:
   - Always use the same command format to restart: `/run-sdlc dcy-xyz reviewer-name`.
   - On rerun, skip already confirmed stages and continue from the next unconfirmed stage.
10. Next-stage refinement rules:
   - After confirming a stage, if the next stage document is draft, first refine upstream input path linkage and key field consistency, then start review.
   - If the next stage document does not exist, create it first using the matching stage draft prompt, then refine upstream input path linkage and key field consistency before starting review.
   - Do not fill unsupported definitive values.
   - For the Implementation stage, after draft refinement check whether unresolved {{DECIDE}} or {{DATA}} placeholders remain in implementation-critical sections.
   - If unresolved user decisions remain, stop instead of executing implementation.
   - If no additional user decision is required and the work items are executable, run `/implementation imp-xyz` before `/implementation-confirm`.
11. Safety rules:
   - Do not create a missing Discovery document automatically.
   - Only create missing downstream stage documents that belong to the same shared sequence number.
   - Do not force confirmation by deleting blocking items.

Execution procedure:
1. Parse input: extract Discovery ID and reviewer name.
2. Extract `xyz` and locate all 7 stage documents.
3. Iterate sequentially from Discovery:
   - Check file existence
   - If Discovery is missing: stop/report
   - If downstream stage is missing: create draft using the matching stage draft prompt
   - Check status
   - If confirmed: skip
   - If draft and stage is not Implementation: review normalization -> confirmation attempt
   - If draft and stage is Implementation:
     - normalize the draft
     - inspect whether additional user decisions are still required
     - if decisions remain: stop/report
     - if executable: run real implementation work using `/implementation imp-xyz`
     - after successful execution, attempt `/implementation-confirm`
   - If failed: stop/report
4. Report final outcome.

Final response format:
1. Input summary
2. Common sequence number and target file paths
3. Stage-by-stage processing result (skip/confirmed/stopped)
   - Include draft-created status where applicable
   - Include implementation-executed status where applicable
4. Stop details (if stopped)
   - Stopped stage
   - Reason for non-approval
   - Additional required decisions
5. Completion summary (if completed)
   - Whether all stages are confirmed
   - List of documents confirmed in this run
   - List of drafts created in this run
   - List of implementation stages executed in this run
6. Next action
   - Restart command or follow-up work

User input:
{{input}}