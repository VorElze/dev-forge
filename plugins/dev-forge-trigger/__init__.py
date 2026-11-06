"""Activate the dev-forge workflow from slash command or common build phrases."""
from __future__ import annotations
import logging
import re
from typing import Any, Optional

logger = logging.getLogger(__name__)
PHRASES = (
    "membuat aplikasi", "membuat website", "membuat web app",
    "bikin aplikasi", "bikin website", "buatkan aplikasi", "buatkan website",
    "buat aplikasi", "buat website", "build a website", "build an app",
    "create a website", "create an app", "build me a", "create a web app",
)
WS = re.compile(r"\s+")

def _norm(value: str) -> str:
    return WS.sub(" ", value.lower()).strip()

def match(message: str) -> Optional[str]:
    text = _norm(message or "")
    if not text:
        return None
    # Explicit slash command is anchored to first non-whitespace character.
    if re.match(r"^/dev-forge(?:\s|$)", text):
        return "/dev-forge"
    for phrase in PHRASES:
        if phrase in text:
            return phrase
    return None

def _context(trigger: str) -> str:
    return (
        f'[dev-forge] Trigger: "{trigger}". Treat this as a web/app build request. '
        "Load skill dev-forge, inspect the current project, then follow its gated workflow. "
        "Before coding, run web-forge doctor and require brief/spec/plan gate PASS; SKIP is not PASS. "
        "Use optional tools only when installed; do not claim unrun checks."
    )

def _on_pre_llm_call(**kwargs: Any) -> Optional[dict[str, str]]:
    try:
        trigger = match(str(kwargs.get("user_message") or ""))
        return {"context": _context(trigger)} if trigger else None
    except Exception:  # hook must never break a turn
        logger.debug("dev-forge-trigger failed", exc_info=True)
        return None

def register(ctx: Any) -> None:
    hook = getattr(ctx, "register_hook", None)
    if callable(hook):
        hook("pre_llm_call", _on_pre_llm_call)
        logger.info("dev-forge-trigger active")
