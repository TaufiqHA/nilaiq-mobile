<div align="center">

# 📱 NilaiQ Mobile

**Aplikasi absensi & penilaian siswa untuk guru — cepat, rapi, dan tetap jalan tanpa internet.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%5E3.13.5-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS-brightgreen)](https://flutter.dev)
[![Offline First](https://img.shields.io/badge/Offline--First-Yes-4B32C3)](#-bagaimana-sinkronisasi-bekerja)

</div>

---

## 📖 Tentang

**NilaiQ Mobile** adalah aplikasi mobile untuk guru yang terhubung dengan backend
[NilaiQ](https://nilaiq.online). Guru dapat memantau dashboard, mengelola pertemuan,
mengisi absensi per siswa, dan melihat rekap — semuanya dirancang **offline-first**.

Semua perubahan yang dibuat saat offline disimpan di perangkat lalu **otomatis
disinkronkan** ke server begitu koneksi kembali. Tidak ada data yang hilang karena
sinyal buruk.

## ✨ Fitur Utama

| Fitur | Deskripsi |
| --- | --- |
| 🔐 **Autentikasi** | Login aman berbasis token (Laravel Sanctum), token disimpan di penyimpanan terenkripsi. |
| 📊 **Dashboard** | Statistik siswa, kelas, tahun ajaran, rata-rata kehadiran, ringkasan agenda penilaian, siswa & agenda terbaru. |
| 🗓️ **Manajemen Pertemuan** | Buat, ubah, dan hapus pertemuan absensi per kelas. |
| ✅ **Isi Absensi** | Tandai status **HADIR / IZIN / SAKIT / ALFA**, tambahkan catatan, cari siswa, dan simpan sekaligus. |
| 📝 **Ulangan Harian** | Kelola pertemuan ulangan dan isi nilai siswa per kelas. |
| 📚 **Tugas** | Kelola pertemuan tugas, isi nilai siswa, dan pindai foto daftar nilai dengan AI. |
| 📋 **PTS & PAS** | Kelola ujian tengah/akhir semester, filter kelas & tanggal, isi nilai siswa, dan pindai foto daftar nilai dengan AI. |
| 📈 **Rekap Absensi** | Rekapitulasi kehadiran per kelas dalam satu tampilan. |
| 🔄 **Sinkronisasi Otomatis** | Data offline dikirim otomatis saat online; ada banner status & notifikasi hasil sinkron. |
| 🌙 **Tema Gelap / Terang** | Mengikuti preferensi pengguna. |

## 🧱 Tech Stack

| Kategori | Teknologi |
| --- | --- |
| Framework | [Flutter](https://flutter.dev) · Dart `^3.13.5` |
| State Management | [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) |
| Networking | [Dio](https://pub.dev/packages/dio) |
| Database Lokal | [Drift](https://drift.simonbinder.eu) (SQLite) |
| Keamanan | [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage) |
| Konektivitas | [connectivity_plus](https://pub.dev/packages/connectivity_plus) |
| Preferensi | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| UI & Format | [google_fonts](https://pub.dev/packages/google_fonts) · [intl](https://pub.dev/packages/intl) |
| Kamera | [image_picker](https://pub.dev/packages/image_picker) |
| Util | [uuid](https://pub.dev/packages/uuid) · [path_provider](https://pub.dev/packages/path_provider) |

## 🏗️ Arsitektur

Aplikasi memakai pola berlapis yang memisahkan UI, logika, dan sumber data:

```
        ┌────────────────────────────────────────────┐
        │              UI  (Screens / Widgets)        │
        └───────────────────────┬────────────────────┘
                                │ watch / read
        ┌───────────────────────▼────────────────────┐
        │            Riverpod Providers               │
        └───────┬───────────────────────┬────────────┘
                │                       │
     ┌──────────▼─────────┐   ┌─────────▼──────────┐
     │    Repositories    │   │   Sync Service      │
     └────┬──────────┬────┘   └─────────┬──────────┘
          │          │                  │
   ┌──────▼───┐  ┌───▼────────┐  ┌──────▼──────────┐
   │ Remote   │  │ Local DB   │  │  Outbox Queue    │
   │ API(Dio) │  │ (Drift)    │  │ (pending ops)    │
   └──────────┘  └────────────┘  └──────────────────┘
```

- **Remote** (`lib/data/remote`) — endpoint Dio ke API Laravel.
- **Local** (`lib/data/local`) — cache Drift + tabel `pending_operations` sebagai *outbox*.
- **Repositories** — menjembatani API & database, menyajikan data lokal lebih dulu.
- **Sync Service** — mengirim antrean operasi ke server secara berurutan, lalu menyegarkan cache.

## 📂 Struktur Proyek

```
lib/
├── core/              # Konfigurasi, tema, API client, formatter
│   ├── env.dart       #   → API base URL & konstanta aplikasi
│   ├── api_client.dart
│   └── theme/
├── data/
│   ├── local/         # Database Drift (cache + outbox)
│   ├── remote/        # Endpoint API (auth, dashboard, absensi)
│   ├── repositories/  # Logika data lokal <-> remote
│   └── sync/          # Mesin sinkronisasi
├── models/            # Model data (user, dashboard)
├── providers/         # Riverpod providers
├── screens/           # Halaman (login, dashboard, absensi, profil)
├── widgets/           # Komponen UI yang dipakai ulang
└── main.dart          # Titik masuk aplikasi
```

## 🚀 Memulai

### Prasyarat

- Flutter SDK (channel stable) — cek dengan `flutter --version`
- Dart SDK `^3.13.5`
- Emulator/perangkat Android atau iOS

### Instalasi

```bash
git clone https://github.com/TaufiqHA/nilaiq-mobile.git
cd nilaiq-mobile
flutter pub get
```

### Menjalankan

```bash
flutter run
```

Secara default aplikasi menunjuk ke `https://nilaiq.online/api`. Untuk mengarahkan
ke server lain (mis. backend lokal saat development):

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.1.10:8000/api
```

> 💡 Atur URL dengan IP LAN (bukan `localhost`) bila dijalankan di perangkat fisik.

## 🛠️ Perintah Pengembangan

| Perintah | Kegunaan |
| --- | --- |
| `flutter pub get` | Memasang dependensi. |
| `dart run build_runner build --delete-conflicting-outputs` | Menghasilkan ulang kode Drift setelah mengubah skema database. |
| `flutter analyze` | Menjalankan analisis statis & lint. |
| `flutter test` | Menjalankan pengujian. |
| `flutter build apk` / `flutter build ios` | Membuat build rilis. |

> ⚠️ Setiap kali mengubah tabel di `lib/data/local/database.dart`, jalankan
> `build_runner` agar `database.g.dart` ikut diperbarui.

## 🔄 Bagaimana Sinkronisasi Bekerja

1. **Catat perubahan lokal** — saat offline, semua operasi (buat/ubah/hapus pertemuan
   & absensi) langsung ditulis ke database lokal dan dimasukkan ke antrean *outbox*.
2. **Deteksi koneksi** — `connectivity_plus` memantau status jaringan.
3. **Kirim antrean** — ketika online (atau saat login), `SyncService` mengirim operasi
   satu per satu ke server, memakai `client_uuid` untuk mencegah data ganda.
4. **Segarkan cache** — setelah antrean selesai, daftar kelas & pertemuan ditarik ulang
   dari server tanpa menimpa data offline yang belum tersinkron.
5. **Beri umpan balik** — jumlah data tersinkron atau pesan kegagalan ditampilkan lewat
   snackbar, dan banner mengingatkan bila data offline terlalu lama tertahan.

## 🤝 Kontribusi

Kontribusi terbuka untuk perbaikan bug, fitur, maupun dokumentasi:

1. Fork repository ini.
2. Buat cabang fitur: `git checkout -b fitur/nama-fitur`.
3. Commit perubahan Anda.
4. Buka Pull Request dengan deskripsi yang jelas.

## 📄 Lisensi

Lisensi proyek ini belum ditentukan.

---

<div align="center">

Dibuat dengan ❤️ untuk mempermudah kerja guru.

</div>
