# Dev Forge

Orkestrator pengembangan web/aplikasi berbasis **Hermes Agent**. `dev-forge` menjalankan alur `web-forge` yang bertahap, menguji kesiapan lingkungan, mewajibkan brief/spec/plan sebelum kode, dan memakai tooling desain/browser yang tersedia secara opsional.

## Yang termasuk

- `skills/dev-forge/SKILL.md` — orkestrator dan aturan alur.
- `skills/web-forge/` — materi web-forge dan tool gate. Menyertakan upstream Awwwards, Jury, Hallmark dengan lisensi/notice mereka (lihat `NOTICE-web-forge.md` dan berkas di `skills/web-forge/third-party/`).
- `plugins/dev-forge-trigger/` — pemicu deterministik Hermes untuk `/dev-forge` di awal pesan serta frasa build umum.
- `scripts/install.sh` — pemasang skill dan plugin Hermes.

**Tidak termasuk:** semua skill/tool server, Graphify, Playwright/browser, provider key, atau skill pihak ketiga lain yang hanya disebut sebagai integrasi opsional. Installer tidak menginstal semuanya secara diam-diam. Lihat `docs/COMPONENTS.md`.

## Instalasi (Hermes Agent)

```bash
git clone https://github.com/VorElze/dev-forge.git
cd dev-forge
bash scripts/install.sh
```

Restart/reload Hermes. Pastikan folder `~/.hermes/plugins/dev-forge-trigger` terdeteksi/enabled oleh versi Hermes Anda dan `dev-forge` serta `web-forge` terindeks. Auto-discovery plugin berbeda menurut konfigurasi/versi host; jika belum muncul, ikuti dokumentasi plugin Hermes Anda dan aktifkan plugin secara eksplisit.

## Cara pakai

Mulai pesan dengan:

```text
/dev-forge Saya ingin membuat website katalog kopi...
```

Pemicu frasa juga mencakup `membuat website`, `membuat aplikasi`, `buat website`, `buat aplikasi`, `build a website`, dan beberapa variasinya. Pemicu frasa hanya berjalan setelah plugin dipasang dan dimuat. Ini bukan jaminan aktivasi universal lintas semua klien/model. Gunakan `/dev-forge` untuk aktivasi eksplisit yang paling andal.

Alur: pemeriksaan `doctor` → intake → `docs/BRIEF.md` → `docs/SPEC.md` → `docs/PLAN.md` → `forge gate` PASS → implementasi → pengujian/verifikasi. Jangan mulai coding sebelum gate menyatakan PASS.

## Opsional

Node.js diperlukan untuk skrip web-forge. Graphify, Playwright CLI dan browser bersifat opsional; pasang terpisah dari sumber resminya. Perintah `graphify hook install` tidak dijalankan oleh installer. Plugin trigger hanya menambahkan konteks prompt; ia tidak menginstal tools, mengubah tool call, atau mengesampingkan kebijakan host.

## Pengembangan & tes

```bash
python3 -m unittest discover -s tests -v
node skills/web-forge/scripts/forge.mjs doctor
```

## Lisensi

Kode orisinal paket mengikuti `LICENSE` (MIT). Konten `web-forge` membawa notice upstream. Lisensi pihak ketiga tetap berlaku untuk direktori yang dibundel; cek `NOTICE-web-forge.md`, `NOTICE-juliobsz-skills-LICENSE.txt`, dan `skills/web-forge/third-party/`. `awesome-design-md`, screenshot-to-code, ui-ux-pro-max, avoid-ai-writing, task-observer, serta tool eksternal tidak disalin ke repo ini; instal/redistribusikan hanya setelah memeriksa lisensi upstream masing-masing.
