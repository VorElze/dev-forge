# Cursor adapter (web-forge / VorElze)

Pasang skill ke proyek Cursor:

1. Junction atau salin repo skill ke **`web-forge/`** di root proyek (sumber kanonik:
   `%USERPROFILE%\.claude\skills\web-forge`).
2. Junction yang sama ke **`.cursor/skills/web-forge`** agen Cursor menemukan `SKILL.md`.
3. Salin **`web-forge-gated-build.mdc`** ke **`.cursor/rules/`** ( `alwaysApply: true` ).
4. Salin cuplikan **`AGENTS.snippet.md`** ke **`AGENTS.md`** root proyek; sesuaikan path CLI.

Opsional global: junction ke `%USERPROFILE%\.cursor\skills\web-forge`.

## Pemicu utama

- **saya ingin membuat website**
- **saya ingin membuat aplikasi**

Daftar lengkap: `manifest.json` → `triggers`.

## Verifikasi pasang

```powershell
cd "path\ke\proyek"
node web-forge/scripts/forge.mjs doctor
node web-forge/scripts/selftest.mjs
```

Kedua perintah harus exit 0.
