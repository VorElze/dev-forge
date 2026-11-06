#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HERMES_SKILLS="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills}"
HERMES_PLUGINS="${HERMES_PLUGINS_DIR:-$HOME/.hermes/plugins}"
mkdir -p "$HERMES_SKILLS" "$HERMES_PLUGINS"
install -d "$HERMES_SKILLS/dev-forge" "$HERMES_SKILLS/web-forge"
cp "$ROOT/skills/dev-forge/SKILL.md" "$HERMES_SKILLS/dev-forge/SKILL.md"
cp -a "$ROOT/skills/web-forge/." "$HERMES_SKILLS/web-forge/"
install -d "$HERMES_PLUGINS/dev-forge-trigger"
cp "$ROOT/plugins/dev-forge-trigger/plugin.yaml" "$ROOT/plugins/dev-forge-trigger/__init__.py" "$HERMES_PLUGINS/dev-forge-trigger/"
printf 'Installed dev-forge skill, web-forge, and trigger plugin.\n'

# Optional: pull verified upstream skills into Hermes (network required).
# - install_fetch_optional=0 -> skip
# - install_with_tools=1 -> also attempt Graphify (pip graphifyy) + Playwright browsers
if [ "${install_fetch_optional:-1}" != 0 ]; then
  if [ "${install_with_tools:-0}" = 1 ]; then
    export FETCH_HEAVY_TOOLS=1
  else
    export FETCH_HEAVY_TOOLS="${FETCH_HEAVY_TOOLS:-0}"
  fi
  bash "$ROOT/scripts/fetch_optional_skills.sh"
else
  printf 'Skipped optional upstream fetch (install_fetch_optional=0).\n'
fi

printf 'Restart/reload Hermes, then verify plugin is enabled and skills are indexed.\n'
printf 'Manual optional fetch: bash scripts/fetch_optional_skills.sh\n'
printf 'Manual heavy tooling: FETCH_HEAVY_TOOLS=1 bash scripts/fetch_optional_skills.sh\n'
