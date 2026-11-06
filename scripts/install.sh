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
printf 'Restart/reload Hermes, then verify plugin is enabled and skills are indexed.\n'
printf 'The installer does not install Graphify, Playwright, browser binaries, or optional third-party skills.\n'
