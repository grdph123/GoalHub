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

## Tugas 9: Integrasi Layanan Web Django dengan Aplikasi Flutter

## Pertanyaan & Jawaban

## 1. Mengapa perlu membuat model Dart untuk JSON?
Alasan pembuatan model Dart:
- Type Safety: Memastikan konsistensi tipe data dan menghindari runtime errors
- Null Safety: Mendefinisikan field yang boleh null atau required secara eksplisit
- Maintainability: Perubahan struktur data hanya di satu tempat
- IntelliSupport: Autocomplete dan error detection di IDE
- Validation: Dapat menambahkan validasi custom dalam model

Konsekuensi tanpa model:
- Runtime errors sulit dideteksi
- Kode sulit dipahami dan dimaintain
- Tidak ada autocomplete untuk field JSON
- Risk terhadap null pointer exceptions

## 2. Fungsi package http vs CookieRequest
Package http:
- Membuat HTTP requests dasar (GET, POST, PUT, DELETE)
- Tidak menangani session cookies secara otomatis
- Cocok untuk API calls yang stateless

CookieRequest:
- Extends functionality http package dengan session management
- Otomatis menyimpan dan mengirim cookies Django
- Essential untuk maintain login state across requests
- Menangani autentikasi secara transparent

Perbedaan utama: http untuk stateless requests, CookieRequest untuk stateful sessions dengan autentikasi.

## 3. Mengapa CookieRequest perlu dibagikan ke semua komponen?
Alasan menggunakan Provider:
- State Persistence: Maintain login state di seluruh aplikasi
- Consistent Session: Semua komponen menggunakan session yang sama
- Avoid Prop Drilling: Akses mudah tanpa passing melalui multiple widgets
- Efficiency: Single instance mencegah session conflicts

## 4. Konfigurasi konektivitas Flutter-Django
Konfigurasi yang diperlukan:
- ALLOWED_HOSTS = ['10.0.2.2']
- 10.0.2.2 adalah alias localhost dari Android Emulator
- Django hanya menerima request dari host yang terdaftar
- Aktifkan CORS
- Diperlukan karena Flutter dan Django berjalan di origin berbeda
- Mengizinkan cross-origin requests
- Pengaturan Cookie SameSite
- SESSION_COOKIE_SAMESITE = 'None'
- CSRF_COOKIE_SAMESITE = 'None'
- Essential untuk cookies work di cross-site context
- Izin Internet di AndroidManifest.xml

Konsekuensi konfigurasi salah:
- Connection refused errors
- CORS policy violations
- Session tidak tersimpan
- CSRF verification failed

## 5. Mekanisme pengiriman data dari input hingga tampil
Flow lengkap pengiriman data:
- User Input → Form input di Flutter
- Client Validation → Validasi di sisi Flutter
- HTTP Request → CookieRequest.postJson() ke Django
- Server Processing → Django validasi dan simpan ke database
- JSON Response → Django return success/error response
- State Update → Flutter update UI state
- Navigation → Arahkan user ke halaman berikutnya

## 6. Mekanisme autentikasi dari login hingga logout
Flow autentikasi lengkap:
REGISTER
- Flutter POST data user ke endpoint register Django
- Django create user dan auto login
- Return session cookie yang disimpan CookieRequest

LOGIN
- Flutter kirim credentials via CookieRequest.login()
- Django verify credentials dan create session
- Session cookie otomatis disimpan untuk request selanjutnya

AUTHENTICATED REQUESTS
- Setiap request include session cookie secara otomatis
- Django identify user dari session
- Return data sesuai permissions user

LOGOUT
- CookieRequest.logout() clear session
- Django destroy session di server
- User redirected ke login page

## 7. Implementasi checklist step-by-step
Step 1: Setup Dependencies & Environment
- Tambahkan http, pbp_django_auth, provider di pubspec.yaml
- Configure AndroidManifest.xml untuk internet permission

Step 2: Authentication System
- Buat LoginPage dengan CookieRequest.login()
- Implement RegisterPage untuk user registration
- Setup proper error handling dan loading states

Step 3: Data Models
- Buat Product model dengan fromJson constructor
- Implement type-safe data parsing dari JSON

Step 4: Product Management
- ProductListPage: Fetch dan display semua products
- ProductDetailPage: Tampilkan semua atribut product
- ProductFormPage: Form untuk create new products

Step 5: User-specific Features
- MyProductsPage: Filter products berdasarkan user login
- Implement proper data filtering logic

Step 6: Navigation & UX
- Setup LeftDrawer dengan semua navigation links
- Implement proper routing antara halaman
- Add loading indicators dan feedback messages

Step 7: Error Handling & Validation
- Form validation di client side
- Network error handling
- User-friendly error messages

Step 8: Testing & Debugging
- Test semua user flows
- Verify data persistence
- Ensure proper session management

Dengan implementasi ini, semua requirement tugas terpenuhi dengan architecture yang maintainable dan user experience yang baik.

