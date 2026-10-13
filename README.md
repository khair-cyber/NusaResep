# NusaResep 🍳

Aplikasi resep masakan Nusantara berbasis **Flutter**. Dibuat untuk Ujian Tengah Semester (UTS) mata kuliah **Mobile Programming Practicum**.

## Tema dan Tujuan

NusaResep menyajikan kumpulan resep masakan tradisional dari berbagai daerah di Indonesia. Tujuannya membantu pengguna menemukan dan memasak hidangan Nusantara dengan mudah.

Fitur utama:

- Menelusuri resep berdasarkan 5 kategori: Hidangan Utama, Sup & Soto, Bakar & Sate, Jajanan, dan Minuman.
- Mencari resep berdasarkan nama, daerah, atau bahan.
- Membaca detail resep: waktu, porsi, tingkat kesulitan, rating, daftar bahan (dapat dicentang), dan langkah memasak.
- Menyimpan resep ke daftar favorit.
- Tampilan responsif: 1 kolom di ponsel, 2 kolom atau lebih di layar lebar atau tablet.

## Daftar Halaman

| Halaman | Berkas | Fungsi |
|---|---|---|
| Beranda | `lib/screens/home_screen.dart` | Sapaan, kolom pencarian, kategori, resep populer, dan 5 resep terbaru |
| Daftar Resep | `lib/screens/recipe_list_screen.dart` | Daftar semua resep dengan filter kategori dan pencarian langsung |
| Detail Resep | `lib/screens/recipe_detail_screen.dart` | Info waktu, porsi, tingkat, rating, daftar bahan (dapat dicentang), dan langkah memasak |
| Favorit | `lib/screens/favorite_screen.dart` | Kumpulan resep yang ditandai dengan ikon hati |

**Navigasi**

- `BottomNavigationBar` dengan 3 tab (Beranda, Resep, Favorit) pada `lib/screens/main_shell.dart`.
- `Navigator.push` untuk membuka daftar resep dari kategori atau hasil pencarian, serta halaman detail resep.
- `Navigator.pop` untuk kembali dari halaman detail.

## Struktur Proyek

```
NusaResep/
├── assets/
│   └── data/
│       └── recipes.json            # data dummy (5 kategori, 12 resep)
├── lib/
│   ├── main.dart                   # titik masuk aplikasi
│   ├── data/
│   │   ├── recipe_repository.dart  # sumber data tunggal (baca JSON, cari, urutkan)
│   │   └── favorite_store.dart     # status favorit (ChangeNotifier)
│   ├── models/
│   │   └── recipe.dart             # model Recipe dan RecipeCategory
│   ├── screens/
│   │   ├── main_shell.dart
│   │   ├── home_screen.dart
│   │   ├── recipe_list_screen.dart
│   │   ├── recipe_detail_screen.dart
│   │   └── favorite_screen.dart
│   ├── theme/
│   │   └── app_theme.dart          # warna dan tipografi
│   └── widgets/
│       ├── recipe_card.dart
│       ├── popular_card.dart
│       ├── category_tile.dart
│       ├── recipe_image.dart
│       └── favorite_button.dart
├── pubspec.yaml
└── README.md
```

## Data Dummy dan Persiapan API

Data dibaca dari `assets/data/recipes.json` melalui `RecipeRepository`. Berkas ini berisi dua daftar:

- `categories`: 5 kategori (`id`, `name`, `emoji`)
- `recipes`: 12 resep (`id`, `name`, `categoryId`, `region`, `emoji`, `colorHex`, `imageUrl`, `duration`, `servings`, `difficulty`, `rating`, `description`, `ingredients`, `steps`)

Bentuk JSON dibuat menyerupai respons API. Pada tahap berikutnya, cukup ganti isi `RecipeRepository.load()` dengan permintaan HTTP ke server (misalnya memakai paket `http`) tanpa mengubah tampilan.

**Gambar:** kolom `imageUrl` boleh diisi URL gambar. Jika kosong atau gagal dimuat, aplikasi menampilkan emoji berwarna sebagai pengganti.

## Teknologi

- Flutter (Dart) dengan Material 3
- [`google_fonts`](https://pub.dev/packages/google_fonts) `^6.2.1` untuk font **Plus Jakarta Sans**
- State management sederhana dengan `ChangeNotifier` dan `ListenableBuilder` (tanpa paket tambahan)

## Cara Menjalankan

**Prasyarat:** Flutter SDK terpasang (cek dengan `flutter --version`, disarankan 3.22 atau lebih baru), serta emulator Android atau perangkat fisik.

1. Clone repositori:
   ```bash
   git clone <URL-REPOSITORI-GITHUB>
   cd NusaResep
   ```
2. Unduh dependensi:
   ```bash
   flutter pub get
   ```
3. Jalankan aplikasi:
   ```bash
   flutter run
   ```

**Catatan**

- Font Plus Jakarta Sans diunduh otomatis oleh `google_fonts` saat pertama kali dijalankan, sehingga memerlukan koneksi internet. Tanpa internet, aplikasi memakai font bawaan.
- Jika muncul error ketidakcocokan tipe `TextTheme` setelah memperbarui dependensi, pastikan versi `google_fonts` tetap di seri `6.x` (`^6.2.1`).
- Jika build bermasalah, jalankan `flutter clean` lalu `flutter pub get` dan ulangi `flutter run`.

## Identitas

- Nama: Nor Khairina
- NIM: 240605110030
- Kelas: F
- Mata Kuliah: Mobile Programming Practicum 
