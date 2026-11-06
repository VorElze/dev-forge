# Cuplikan untuk AGENTS.md proyek (Cursor)

Salin ke `AGENTS.md` root proyek. Ganti `<web-forge>` dengan path ke skill
(`./web-forge`, `.cursor/skills/web-forge`, atau `%USERPROFILE%\.cursor\skills\web-forge`).

## Pemicu build

- saya ingin membuat website / saya ingin membuat aplikasi
- I want to build a website / I want to build an app / build me an app / create a web app

## Urutan

1. `node <web-forge>/scripts/forge.mjs doctor`
2. `node <web-forge>/scripts/forge.mjs new "<nama>" --stack laravel|next|html|api` (skip jika `.forge/ledger.json` ada)
3. `docs/BRIEF.md`, `docs/SPEC.md`, `docs/PLAN.md`
4. `node <web-forge>/scripts/forge.mjs gate` — tunjukkan output mentah

Tanpa PASS brief/spec/plan → jangan kode fitur.

Pasang juga `.cursor/rules/web-forge-gated-build.mdc` dari folder adaptor ini.
