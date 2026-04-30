#!/usr/bin/env python3

from __future__ import annotations

import argparse
from dataclasses import dataclass
from datetime import datetime, timedelta, timezone
from pathlib import Path
import re
import sys

try:
    from zoneinfo import ZoneInfo
except ImportError:  # pragma: no cover
    ZoneInfo = None


RUNTIME_CHOICES = (
    "cli",
    "api-service",
    "web-app",
    "worker",
    "library",
    "mixed",
    "other",
)


@dataclass(frozen=True)
class Entrypoint:
    name: str
    purpose: str


@dataclass(frozen=True)
class TopLevelArea:
    path: str
    responsibility: str


@dataclass(frozen=True)
class SeedAnswers:
    repository_name: str
    display_name: str
    summary: str
    primary_domain: str
    tech_stack: list[str]
    primary_runtime: str
    primary_entrypoints: list[Entrypoint]
    planned_top_level_areas: list[TopLevelArea]
    known_unknowns: list[str]
    capture_mode: str


def fail(message: str) -> int:
    print(f"[bootstrap-seed] ERROR: {message}", file=sys.stderr)
    return 1


def log(message: str) -> None:
    print(f"[bootstrap-seed] {message}")


def default_display_name(repository_name: str) -> str:
    words = re.sub(r"[-_]+", " ", repository_name.strip()).split()
    if not words:
      return "Project"
    return " ".join(word.capitalize() for word in words)


def kst_timestamp() -> str:
    if ZoneInfo is not None:
        current = datetime.now(ZoneInfo("Asia/Seoul"))
    else:  # pragma: no cover
        current = datetime.now(timezone(timedelta(hours=9)))
    return current.strftime("%Y-%m-%d %H:%M")


def yaml_scalar(value: str) -> str:
    escaped = value.replace("'", "''")
    return f"'{escaped}'"


def parse_csv_list(raw_value: str) -> list[str]:
    return [item.strip() for item in raw_value.split(",") if item.strip()]


def parse_pair(raw_value: str, label: str) -> tuple[str, str]:
    if "::" not in raw_value:
        raise ValueError(f"{label} entries must use 'name :: purpose' format: {raw_value}")

    left, right = raw_value.split("::", 1)
    left = left.strip()
    right = right.strip()
    if not left or not right:
        raise ValueError(f"{label} entries must include values on both sides of '::': {raw_value}")
    return left, right


def prompt_value(question: str, *, default: str | None = None, choices: tuple[str, ...] | None = None) -> str:
    while True:
        choice_hint = f" ({', '.join(choices)})" if choices else ""
        default_hint = f" [{default}]" if default else ""
        raw_value = input(f"{question}{choice_hint}{default_hint}: ").strip()

        if not raw_value and default is not None:
            return default
        if not raw_value:
            print("Value is required.")
            continue
        if choices and raw_value not in choices:
            print(f"Choose one of: {', '.join(choices)}")
            continue
        return raw_value


def prompt_lines(question: str, *, example: str, required: bool = False, max_items: int | None = None) -> list[str]:
    print(question)
    print(f"Format: {example}")
    print("Press Enter on an empty line to finish.")

    values: list[str] = []
    while True:
        raw_value = input("> ").strip()
        if not raw_value:
            if required and not values:
                print("At least one line is required.")
                continue
            break

        values.append(raw_value)
        if max_items is not None and len(values) >= max_items:
            break

    return values


def collect_required_args(args: argparse.Namespace) -> tuple[str, str, list[str], str, list[str]]:
    missing: list[str] = []
    if not args.project_summary:
        missing.append("--project-summary")
    if not args.primary_domain:
        missing.append("--primary-domain")
    if not args.tech_stack:
        missing.append("--tech-stack")
    if not args.primary_runtime:
        missing.append("--primary-runtime")
    if not args.primary_entrypoint:
        missing.append("--primary-entrypoint")
    if missing:
        raise ValueError("Missing required arguments for --non-interactive: " + ", ".join(missing))

    tech_stack = parse_csv_list(args.tech_stack)
    if not tech_stack:
        raise ValueError("--tech-stack must include at least one comma-separated item")

    return (
        args.project_summary,
        args.primary_domain,
        tech_stack,
        args.primary_runtime,
        args.primary_entrypoint,
    )


def collect_answers(args: argparse.Namespace, host_root: Path) -> SeedAnswers:
    repository_name = args.repository_name or host_root.resolve().name or "project"
    display_name = args.display_name or default_display_name(repository_name)

    if args.non_interactive:
        summary, primary_domain, tech_stack, primary_runtime, primary_entrypoints = collect_required_args(args)
        top_level_area_values = args.top_level_area
        known_unknowns = args.known_unknown
    else:
        print("[bootstrap-seed] Answer the minimum bootstrap questions for baseline.yaml.")
        print(f"[bootstrap-seed] Host root: {host_root}")
        display_name = prompt_value("Display name", default=display_name)
        summary = args.project_summary or prompt_value("project-summary | 이 프로젝트를 한 문장으로 설명하면 무엇인가?")
        primary_domain = args.primary_domain or prompt_value("primary-domain | 이 프로젝트의 주요 도메인은 무엇인가?")
        tech_stack = parse_csv_list(args.tech_stack) if args.tech_stack else parse_csv_list(
            prompt_value("tech-stack | 계획 중인 주 언어, 프레임워크, 핵심 인프라는 무엇인가? (comma-separated)")
        )
        primary_runtime = args.primary_runtime or prompt_value(
            "primary-runtime | 계획 중인 주 실행 형태는 무엇인가?",
            choices=RUNTIME_CHOICES,
        )
        primary_entrypoints = args.primary_entrypoint or prompt_lines(
            "primary-entrypoints | 대표 진입점 1~3개를 적어 달라.",
            example="name :: purpose",
            required=True,
            max_items=3,
        )
        top_level_area_values = args.top_level_area or prompt_lines(
            "planned-top-level-areas | 이미 알고 있는 top-level 경로가 있으면 적어 달라.",
            example="path :: responsibility",
        )
        known_unknowns = args.known_unknown or prompt_lines(
            "known-unknowns | 아직 미정인 핵심 항목이 있으면 적어 달라.",
            example="one unresolved item per line",
        )

    if primary_runtime not in RUNTIME_CHOICES:
        raise ValueError(f"primary runtime must be one of: {', '.join(RUNTIME_CHOICES)}")
    if not tech_stack:
        raise ValueError("tech-stack must include at least one item")
    if not primary_entrypoints:
        raise ValueError("at least one primary-entrypoint is required")
    if len(primary_entrypoints) > 3:
        raise ValueError("primary-entrypoint supports at most 3 values")

    entrypoints = [Entrypoint(*parse_pair(value, "primary-entrypoint")) for value in primary_entrypoints]
    top_level_areas = [TopLevelArea(*parse_pair(value, "top-level-area")) for value in top_level_area_values]

    return SeedAnswers(
        repository_name=repository_name,
        display_name=display_name,
        summary=summary,
        primary_domain=primary_domain,
        tech_stack=tech_stack,
        primary_runtime=primary_runtime,
        primary_entrypoints=entrypoints,
        planned_top_level_areas=top_level_areas,
        known_unknowns=known_unknowns,
        capture_mode=args.capture_mode or "declared",
    )


def render_seed(answers: SeedAnswers) -> str:
    updated_from = {
        "declared": "user-answer",
        "observed": "repo-observation",
        "mixed": "mixed",
    }[answers.capture_mode]

    lines = [
        "schema_version: 1",
        f"capture_mode: {answers.capture_mode}",
        "",
        "project:",
        f"  repository_name: {yaml_scalar(answers.repository_name)}",
        f"  display_name: {yaml_scalar(answers.display_name)}",
        f"  summary: {yaml_scalar(answers.summary)}",
        f"  primary_domain: {yaml_scalar(answers.primary_domain)}",
        "",
        "stack:",
        "  tech_stack:",
    ]

    for item in answers.tech_stack:
        lines.append(f"    - {yaml_scalar(item)}")

    lines.extend(
        [
            "",
            "runtime:",
            f"  primary_runtime: {answers.primary_runtime}",
            "  primary_entrypoints:",
        ]
    )
    for entrypoint in answers.primary_entrypoints:
        lines.append(f"    - name: {yaml_scalar(entrypoint.name)}")
        lines.append(f"      purpose: {yaml_scalar(entrypoint.purpose)}")

    lines.extend(["", "structure:"])
    if answers.planned_top_level_areas:
        lines.append("  planned_top_level_areas:")
        for area in answers.planned_top_level_areas:
            lines.append(f"    - path: {yaml_scalar(area.path)}")
            lines.append(f"      responsibility: {yaml_scalar(area.responsibility)}")
    else:
        lines.append("  planned_top_level_areas: []")

    lines.extend(["", "notes:"])
    if answers.known_unknowns:
        lines.append("  known_unknowns:")
        for item in answers.known_unknowns:
            lines.append(f"    - {yaml_scalar(item)}")
    else:
        lines.append("  known_unknowns: []")

    lines.extend(
        [
            "",
            "metadata:",
            f"  captured_at_kst: {yaml_scalar(kst_timestamp())}",
            "  source: stagepilot-bootstrap-seed.py",
            f"  updated_from: {updated_from}",
            "",
        ]
    )
    return "\n".join(lines)


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Create .stagepilot/bootstrap/baseline.yaml from StagePilot bootstrap answers.",
    )
    parser.add_argument("host_root", nargs="?", default=".", help="Host repository root. Defaults to the current directory.")
    parser.add_argument("--output", help="Explicit output path. Defaults to HOST_ROOT/.stagepilot/bootstrap/baseline.yaml.")
    parser.add_argument("--force", action="store_true", help="Overwrite an existing seed file.")
    parser.add_argument("--dry-run", action="store_true", help="Print the generated seed to stdout without writing a file.")
    parser.add_argument("--non-interactive", action="store_true", help="Require explicit CLI answers instead of interactive prompts.")
    parser.add_argument("--capture-mode", choices=("declared", "observed", "mixed"), help="Seed capture mode.")
    parser.add_argument("--repository-name", help="Repository name stored in the seed. Defaults to the host root folder name.")
    parser.add_argument("--display-name", help="Display name stored in the seed. Defaults to a title-cased repository name.")
    parser.add_argument("--project-summary", help="One-sentence project summary.")
    parser.add_argument("--primary-domain", help="Primary domain noun phrase.")
    parser.add_argument("--tech-stack", help="Comma-separated technology list.")
    parser.add_argument("--primary-runtime", choices=RUNTIME_CHOICES, help="Primary runtime type.")
    parser.add_argument(
        "--primary-entrypoint",
        action="append",
        default=[],
        help="Primary entrypoint line in 'name :: purpose' format. Repeat up to 3 times.",
    )
    parser.add_argument(
        "--top-level-area",
        action="append",
        default=[],
        help="Optional top-level area in 'path :: responsibility' format.",
    )
    parser.add_argument(
        "--known-unknown",
        action="append",
        default=[],
        help="Optional unresolved bootstrap note. Repeat for multiple items.",
    )
    return parser


def main() -> int:
    parser = build_parser()
    args = parser.parse_args()

    host_root = Path(args.host_root).resolve()
    if not host_root.exists() or not host_root.is_dir():
        return fail(f"host root not found: {host_root}")

    output_path = Path(args.output).resolve() if args.output else host_root / ".stagepilot/bootstrap/baseline.yaml"

    try:
        answers = collect_answers(args, host_root)
        content = render_seed(answers)
    except ValueError as error:
        return fail(str(error))
    except EOFError:
        return fail("input ended before the questionnaire was completed")

    if args.dry_run:
        print(content, end="")
        return 0

    if output_path.exists() and not args.force:
        return fail(f"seed file already exists: {output_path}. Use --force to overwrite.")

    output_path.parent.mkdir(parents=True, exist_ok=True)
    output_path.write_text(content, encoding="utf-8")

    log(f"wrote {output_path}")
    log("Next: run /bootstrap-baseline in Copilot Chat to render baseline docs from the seed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())