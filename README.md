# Dev Forge

Orkestrator pengembangan web/aplikasi berbasis **Hermes Agent**. `dev-forge` menjalankan alur `web-forge` yang bertahap, menguji kesiapan lingkungan, mewajibkan brief/spec/plan sebelum kode, dan memakai tooling desain/browser yang tersedia secara opsional.

## Yang termasuk

- `skills/dev-forge/SKILL.md` — orkestrator dan aturan alur.
- `skills/web-forge/` — materi web-forge dan tool gate. Menyertakan upstream Awwwards, Jury, Hallmark dengan lisensi/notice mereka (lihat `NOTICE-web-forge.md` dan berkas di `skills/web-forge/third-party/`).
- `plugins/dev-forge-trigger/` — pemicu deterministik Hermes untuk `/dev-forge` di awal pesan serta frasa build umum.
- `scripts/install.sh` — pemasang skill dan plugin Hermes (secara bawaan juga menjalankan unduhan skill upstream yang telah diverifikasi; membutuhkan jaringan).
- `scripts/fetch_optional_skills.sh` — unduhan ulang/penyegaran skill opsional ke `HERMES_SKILLS_DIR` tanpa menyalin seluruh riwayat Git; unduhan toolchain berat bersifat **opt-in**.
- `optional/skills/awesome-design-md/SKILL.md` — salinan ringan dari referensi skill lokal (bukan seluruh koleksi `design-md/`).

**Tidak otomatis menyamai seluruh server produksi:** kunci provider, proyek internal, dan skill tanpa upstream publik yang jelas tidak didownload otomatis. Tooling besar (binari browser Playwright, instalasi Graphify via pip) hanya jika Anda mengaktifkan mode berat. Lihat `docs/COMPONENTS.md`.

## Instalasi (Hermes Agent)

```bash
git clone https://github.com/VorElze/dev-forge.git
cd dev-forge
bash scripts/install.sh
```

Variabel lingkungan (opsional):

```bash
# lewati unduhan skill tambahan (hanya dev-forge + web-forge + plugin)
install_fetch_optional=0 bash scripts/install.sh

# sertakan percobaan instalasi Graphify (pip graphifyy) + binari browser Playwright (besar)
install_with_tools=1 bash scripts/install.sh
```

Restart/reload Hermes. Pastikan folder `~/.hermes/plugins/dev-forge-trigger` terdeteksi/diaktifkan oleh versi host Anda dan skill baru terindeks. Auto-discovery plugin berbeda menurut konfigurasi/versi host; jika belum muncul, ikuti dokumentasi plugin host Anda.

## Cara pakai

Mulai pesan dengan:

```text
/dev-forge Saya ingin membuat website katalog kopi...
```

Pemicu frasa juga mencakup `membuat website`, `membuat aplikasi`, `buat website`, `buat aplikasi`, `build a website`, dan beberapa variasinya. Pemicu frasa hanya berjalan setelah plugin dipasang dan dimuat. Ini bukan jaminan aktivasi universal lintas semua klien/model. Gunakan `/dev-forge` untuk aktivasi eksplisit yang paling andal.

Alur: pemeriksaan `doctor` → intake → `docs/BRIEF.md` → `docs/SPEC.md` → `docs/PLAN.md` → `forge gate` PASS → implementasi → pengujian/verifikasi. Jangan mulai coding sebelum gate menyatakan PASS.

## Opsional

Node.js diperlukan untuk skrip web-forge. Secara bawaan installer **tidak** memasang binari browser Playwright atau Graphify; jalankan `FETCH_HEAVY_TOOLS=1 bash scripts/fetch_optional_skills.sh` atau `install_with_tools=1 bash scripts/install.sh` bila Anda ingin mencoba otomatis. `graphify hook install` tetap tidak dijalankan tanpa persetujuan eksplisit di proyek Anda. Plugin trigger hanya menambahkan konteks prompt; ia tidak menginstal tools, mengubah tool call, atau mengesampingkan kebijakan host.

## Pengembangan & tes

```bash
python3 -m unittest discover -s tests -v
node skills/web-forge/scripts/forge.mjs doctor
```

## Lisensi

Kode orisinal paket mengikuti `LICENSE` (MIT). Konten `web-forge` membawa notice upstream. Lisensi pihak ketiga tetap berlaku untuk direktori yang dibundel; cek `NOTICE-web-forge.md`, `NOTICE-juliobsz-skills-LICENSE.txt`, dan `skills/web-forge/third-party/`. Skill yang diunduh oleh skrip instalasi berasal dari repositori upstream masing-masing dan tetap tunduk pada lisensi mereka. `screenshot-to-code` dan `popular-web-designs` tidak memiliki pasangan publik 1:1 yang diverifikasi; sediakan salinan lokal di `DEV_FORGE_LOCAL_SKILLS_DIR` jika Anda ingin menyalinnya.
