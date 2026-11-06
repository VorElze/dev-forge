---
name: dev-forge
description: Gated web and application development orchestrator for Hermes Agent. Use when the user starts a message with /dev-forge or asks to build, create, design, or implement a website, web app, or software application; route through web-forge intake and verification before coding, and use optional installed design, browser, and code-analysis skills when available.
---

# Dev Forge

Build web sites and applications through a measured, user-approved pipeline. This package is an orchestrator, not a claim that every optional tool or upstream skill is bundled or installed.

## Activation

- `/dev-forge` at the beginning of a message: explicit activation.
- Requests to build a website/application: automatic activation where the host plugin is installed. Phrase matching is deterministic for the listed trigger strings; semantic paraphrases depend on the host/model.

## Required workflow

1. Inspect the current project and read the user's requirements; do not overwrite or scaffold blindly.
2. Load `web-forge` from this package. In Hermes use `skill_view(name="web-forge")` if installed; otherwise read `skills/web-forge/SKILL.md`.
3. Run `node <web-forge-dir>/scripts/forge.mjs doctor` and report missing optional tools honestly.
4. For a new project, initialize with `forge new` using the requested stack. Ask one concise intake round only for unanswered decisions, then complete `docs/BRIEF.md`, `docs/SPEC.md`, and `docs/PLAN.md`.
5. Run the `forge gate`. Do not write application code until the required brief/spec/plan checks PASS. SKIP is not PASS.
6. Implement the agreed scope. Respect the repository's existing conventions and user design preferences. Use optional skills only if present and licensed/authorized in the user's environment; e.g. `design-taste-frontend`, `hallmark`, `awwwards`, `jury`, `screenshot-to-code`, `ui-ux-pro-max`, `web-design-guidelines`.
7. Run relevant tests, accessibility/security checks and real-browser visual verification when the tools are installed. State any unavailable checks.
8. Summarize changes, verification results, and remaining risks; never claim tests passed without running them.

## Optional capabilities

- **Design:** `design-taste-frontend`, `hallmark`, `awwwards`, `jury`, `awesome-design-md` (MIT upstream for `design-md/` library; `SKILL.md` is vendored here under `optional/` and copied by `scripts/fetch_optional_skills.sh`).
- **Image-to-code:** `screenshot-to-code`.
- **UI research:** `ui-ux-pro-max`, `web-design-guidelines`.
- **Writing quality:** `avoid-ai-writing` (English-calibrated; do not treat detector signals as proof).
- **Code map:** `graphify` CLI, optional; use `graphify update .` only with the user's project and permission. The plugin does not silently install Git hooks.
- **Task instrumentation:** `task-observer` is not a web-build dependency.

Do not claim these are installed merely because they are listed. `scripts/install.sh` can fetch verified upstream copies into `HERMES_SKILLS_DIR` when run with network access; heavy tooling (Graphify via `pip install graphifyy`, Playwright browser binaries) is opt-in.
