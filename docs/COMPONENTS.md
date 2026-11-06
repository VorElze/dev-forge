# Inventory and license boundaries

This repository is a portable orchestrator package, not a mirror of a private server snapshot. Components whose redistribution basis is clear are either bundled under `skills/web-forge/` (with NOTICE) or fetched at install time from public upstreams by `scripts/fetch_optional_skills.sh`.

## Bundled in-repo (Git)

| Capability | Status | Notes |
|---|---|---|
| dev-forge orchestrator | Included | `skills/dev-forge/` |
| web-forge | Included | `skills/web-forge/`; MIT + NOTICE |
| Awwwards + Jury + Hallmark | Included via web-forge | upstream copies retained under `third-party/` |
| Trigger plugin | Included | `plugins/dev-forge-trigger/` |
| awesome-design-md SKILL stub | Included | `optional/skills/awesome-design-md/SKILL.md` (not the full `design-md/` tree) |

## Fetched on install (network)

Default `bash scripts/install.sh` runs `scripts/fetch_optional_skills.sh` unless `install_fetch_optional=0`. It shallow-clones upstreams into `~/.cache/dev-forge-upstream` and copies selected subtrees into `HERMES_SKILLS_DIR` (default `~/.hermes/skills`).

| Skill | Upstream | License signal | What is copied |
|---|---|---|---|
| design-taste-frontend | https://github.com/Leonxlnx/taste-skill | MIT (API) | `skills/taste-skill` → `design-taste-frontend` |
| awesome-design-md | https://github.com/VoltAgent/awesome-design-md | MIT (LICENSE file) | `design-md/` + bundled `SKILL.md` from `optional/` |
| web-design-guidelines | https://github.com/vercel-labs/agent-skills | No SPDX license file in repo root (see upstream README) | unzips `skills/web-design-guidelines.zip` |
| ui-ux-pro-max | https://github.com/nextlevelbuilder/ui-ux-pro-max-skill | MIT (LICENSE) | `.claude/skills/ui-ux-pro-max` |
| avoid-ai-writing | https://github.com/salexandr0s/avoid-ai-writing | MIT (LICENSE) | full tree without `.git` |
| task-observer | https://github.com/VorElze/hermes-office-skills | Collection NOTICE/LICENSE | `skills/task-observer` subset |

Heavy tooling is **not** installed unless `FETCH_HEAVY_TOOLS=1` (or `install_with_tools=1`): attempts `pip install --user graphifyy` and `npx playwright install --with-deps`.

## Local overlay for unverifiable/custom skills

Set `DEV_FORGE_LOCAL_SKILLS_DIR` to a folder that contains any of:

- `screenshot-to-code/`
- `popular-web-designs/`

Each subdirectory is copied wholesale into `HERMES_SKILLS_DIR` (`.git` stripped). This covers cases where there is **no** verified public 1:1 match for the skill body you use privately.

## Why not "everything, always, automatically"

- **License clarity:** some upstreams lack SPDX-detectable licenses or redistribute large corpora; shipping them blindly risks non-compliance.
- **Size/runtime:** browser binaries and graph indexes are hundreds of MB; they must stay opt-in.
- **Host differences:** Hermes/Claude/Codex discovery paths differ; the installer cannot guarantee every client auto-loads every skill.
- **Secrets and internal-only packs:** production servers may carry keys, cron packs, or forks that are not public.

This table is a point-in-time inventory, not a warranty of current upstream status. Re-check repository terms before installing or redistributing optional components.
