# GoalHub - Football Shop

A Flutter-based football merchandise shopping app.

## Tugas 7: Elemen Dasar Flutter

### Pertanyaan & Jawaban

#### 1. Widget Tree pada Flutter
Widget tree adalah struktur hierarkis yang menggambarkan hubungan parent-child antar widget dalam aplikasi Flutter. Setiap widget dapat memiliki child widget, membentuk pohon yang menentukan layout dan behavior aplikasi.

#### 2. Widget yang Digunakan
- **MaterialApp**: Widget root yang menyediakan material design
- **Scaffold**: Struktur dasar halaman dengan appbar dan body
- **AppBar**: Header/toolbar aplikasi
- **Column**: Menyusun widget secara vertikal
- **Row**: Menyusun widget secara horizontal
- **GridView**: Menampilkan widget dalam grid
- **Card**: Container dengan elevation/shadow
- **Text**: Menampilkan teks
- **Icon**: Menampilkan ikon material
- **InkWell**: Area yang responsive terhadap tap
- **SnackBar**: Notifikasi sementara di bagian bawah

#### 3. Fungsi MaterialApp
MaterialApp adalah widget root yang menyediakan material design, theme, navigation, dan localization. Digunakan sebagai root karena memberikan struktur dasar yang diperlukan aplikasi Flutter.

#### 4. Perbedaan StatelessWidget vs StatefulWidget
- **StatelessWidget**: Immutable, tidak berubah setelah dibuat
- **StatefulWidget**: Mutable, dapat berubah state-nya
Pilih StatelessWidget ketika UI statis, StatefulWidget ketika UI perlu update dinamis.

#### 5. BuildContext
BuildContext adalah handle ke lokasi widget dalam tree. Penting untuk mengakses theme, navigation, dan parent widgets. Digunakan dalam build method untuk mendapatkan context saat ini.

#### 6. Hot Reload vs Hot Restart
- **Hot Reload**: Mempertahankan state, cepat untuk perubahan UI
- **Hot Restart**: Reset state, diperlukan untuk perubahan logic penting


## Tugas 8: Flutter Navigation, Layouts, Forms, and Input Elements

### Pertanyaan & Jawaban

#### 1. Perbedaan Navigator.push() dan Navigator.pushReplacement()
- **Navigator.push()**: Menambahkan halaman baru ke stack navigation, pengguna bisa kembali ke halaman sebelumnya dengan tombol back.
- **Navigator.pushReplacement()**: Mengganti halaman saat ini dengan halaman baru, menghapus halaman sebelumnya dari stack.

**Penggunaan di GoalHub**:
- `push()` digunakan dari tombol "Create Product" karena user mungkin ingin kembali ke menu
- `pushReplacement()` digunakan di drawer untuk navigasi utama

#### 2. Pemanfaatan Hierarchy Widget
- **Scaffold**: Struktur dasar halaman dengan AppBar, Drawer, dan Body
- **AppBar**: Header konsisten dengan judul dan warna brand
- **Drawer**: Navigasi yang mudah diakses dari semua halaman

#### 3. Kelebihan Layout Widget
- **Padding**: Memberikan jarak yang konsisten antar elemen form
- **SingleChildScrollView**: Membuat form dapat di-scroll pada layar kecil
- **ListView**: Menampilkan item dalam list yang terorganisir

#### 4. Penyesuaian Warna Tema
Menggunakan warna biru (`Colors.green`) secara konsisten di:
- AppBar semua halaman
- Drawer header
- Tombol utama
- Theme primary color

Hal ini menciptakan identitas visual yang kuat untuk brand GoalHub.