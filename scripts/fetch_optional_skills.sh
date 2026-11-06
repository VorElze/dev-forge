#!/usr/bin/env bash
# Optional: fetch additional MIT/Apache-verified upstream skills and office skills.
# Safe defaults: shallow clone to a cache dir, copy only needed subtrees into Hermes.
# Heavy tools are opt-in: install_with_tools=1 bash scripts/install.sh, or FETCH_HEAVY_TOOLS=1 after core install.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
HERMES_SKILLS="${HERMES_SKILLS_DIR:-$HOME/.hermes/skills}"
CACHE="${DEV_FORGE_FETCH_CACHE:-$HOME/.cache/dev-forge-upstream}"
mkdir -p "$HERMES_SKILLS" "$CACHE"

log(){ printf '[dev-forge fetch] %s\n' "$*"; }

need_cmd(){
  command -v "$1" >/dev/null 2>&1 || { echo "missing: $1" >&2; exit 1; }
}

need_cmd git
need_cmd unzip

clone_shallow(){
  local url="$1" name="$2"
  if [ ! -d "$CACHE/$name/.git" ]; then
    git clone --depth 1 "$url" "$CACHE/$name"
  else
    git -C "$CACHE/$name" fetch --depth 1 origin HEAD || true
    git -C "$CACHE/$name" reset --hard FETCH_HEAD || git -C "$CACHE/$name" pull --ff-only || true
  fi
}

# --- Verified upstream skills (MIT unless noted) ---
log "Leonxlnx/taste-skill -> design-taste-frontend"
clone_shallow https://github.com/Leonxlnx/taste-skill.git taste-skill
rm -rf "$HERMES_SKILLS/design-taste-frontend"
mkdir -p "$HERMES_SKILLS"
cp -a "$CACHE/taste-skill/skills/taste-skill" "$HERMES_SKILLS/design-taste-frontend"

log "VoltAgent/awesome-design-md -> awesome-design-md (repo + bundled SKILL)"
clone_shallow https://github.com/VoltAgent/awesome-design-md.git awesome-design-md
install -d "$HERMES_SKILLS/awesome-design-md"
if [ -f "$ROOT/optional/skills/awesome-design-md/SKILL.md" ]; then
  cp "$ROOT/optional/skills/awesome-design-md/SKILL.md" "$HERMES_SKILLS/awesome-design-md/SKILL.md"
else
  log "WARN: missing $ROOT/optional/skills/awesome-design-md/SKILL.md"
fi
# Curated DESIGN.md library (large). Copy without .git to save space.
rm -rf "$HERMES_SKILLS/awesome-design-md/design-md"
cp -a "$CACHE/awesome-design-md/design-md" "$HERMES_SKILLS/awesome-design-md/design-md"
cp "$CACHE/awesome-design-md/LICENSE" "$HERMES_SKILLS/awesome-design-md/LICENSE.upstream" 2>/dev/null || true

log "vercel-labs/agent-skills -> web-design-guidelines (zip upstream)"
clone_shallow https://github.com/vercel-labs/agent-skills.git agent-skills
rm -rf "$CACHE/agent-skills/_extract-wdg" && mkdir -p "$CACHE/agent-skills/_extract-wdg"
unzip -q -o "$CACHE/agent-skills/skills/web-design-guidelines.zip" -d "$CACHE/agent-skills/_extract-wdg"
rm -rf "$HERMES_SKILLS/web-design-guidelines"
cp -a "$CACHE/agent-skills/_extract-wdg/web-design-guidelines" "$HERMES_SKILLS/web-design-guidelines"
printf '\nUpstream: https://github.com/vercel-labs/agent-skills (see repository README for license terms).\n' >> "$HERMES_SKILLS/web-design-guidelines/INSTALL_PROVENANCE.txt"

log "nextlevelbuilder/ui-ux-pro-max-skill -> ui-ux-pro-max"
clone_shallow https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git ui-ux-pro-max-skill
rm -rf "$HERMES_SKILLS/ui-ux-pro-max"
cp -a "$CACHE/ui-ux-pro-max-skill/.claude/skills/ui-ux-pro-max" "$HERMES_SKILLS/ui-ux-pro-max"
cp "$CACHE/ui-ux-pro-max-skill/LICENSE" "$HERMES_SKILLS/ui-ux-pro-max/LICENSE.upstream" 2>/dev/null || true

log "salexandr0s/avoid-ai-writing -> avoid-ai-writing"
clone_shallow https://github.com/salexandr0s/avoid-ai-writing.git avoid-ai-writing
rm -rf "$HERMES_SKILLS/avoid-ai-writing"
cp -a "$CACHE/avoid-ai-writing" "$HERMES_SKILLS/avoid-ai-writing"
rm -rf "$HERMES_SKILLS/avoid-ai-writing/.git"

log "VorElze/hermes-office-skills -> task-observer (subset)"
clone_shallow https://github.com/VorElze/hermes-office-skills.git hermes-office-skills
rm -rf "$HERMES_SKILLS/task-observer"
cp -a "$CACHE/hermes-office-skills/skills/task-observer" "$HERMES_SKILLS/task-observer"

# Optional local-only skills (no public upstream match): copy from a directory you control.
if [ -n "${DEV_FORGE_LOCAL_SKILLS_DIR:-}" ] && [ -d "$DEV_FORGE_LOCAL_SKILLS_DIR" ]; then
  for name in screenshot-to-code popular-web-designs; do
    if [ -d "$DEV_FORGE_LOCAL_SKILLS_DIR/$name" ]; then
      log "local overlay: $name"
      rm -rf "$HERMES_SKILLS/$name"
      cp -a "$DEV_FORGE_LOCAL_SKILLS_DIR/$name" "$HERMES_SKILLS/$name"
      if [ -d "$HERMES_SKILLS/$name/.git" ]; then rm -rf "$HERMES_SKILLS/$name/.git"; fi
    fi
  done
fi

# --- Optional heavy CLI tooling (opt-in) ---
if [ "${FETCH_HEAVY_TOOLS:-}" != 1 ]; then
  log "FETCH_HEAVY_TOOLS is not 1 -> skipping Graphify pip install and Playwright browsers"
  log "done (skills only)"
  exit 0
fi

if command -v python3 >/dev/null 2>&1; then
  log "pip install graphifyy (Graphify-Labs; PyPI package name graphifyy)"
  python3 -m pip install --user --upgrade graphifyy || log "WARN: graphify pip install failed; install manually (pipx/pip --user)."
  if command -v graphify >/dev/null 2>&1; then
    graphify install hermes || log "WARN: graphify install hermes failed; run: graphify install hermes"
  fi
else
  log "WARN: python3 missing; cannot pip install graphifyy"
fi

if command -v npx >/dev/null 2>&1; then
  log "playwright CLI install (downloads browser binaries; large)"
  npx --yes playwright install --with-deps || log "WARN: playwright install failed; install manually"
else
  log "WARN: npx missing; cannot install Playwright"
fi

log "done"
