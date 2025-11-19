# toko_kaki_bola

Tugas 7:
1.  Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Widget Tree adalah struktur dari seluruh UI. Widget tidak bisa sembarang di taro di layar, harus disusun. Widget juga di tempatkan di dalam widget lain. Susunan bertingkat inilah yang disebut Widget Tree. 
Hubungan Parent-Child:
- Parent
Adalah widget yang berisi widget lain. Contoh : Column, Row, Padding, Center.
- Child
Adalah widget yang berada di dalam widget parent.

Hubungan ini sangat penting karena Parent mengontrol Child-nya.
Padding (Parent) memberi tahu Text (Child) untuk memberi jarak di sekelilingnya.
Column (Parent) memberi tahu 3 Text (Children) untuk berbaris secara vertikal.
Center (Parent) memberi tahu Icon (Child) untuk berada di tengah.

2.  Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
- MaterialApp: Widget utama yang membungkus seluruh aplikasi. Ini menyediakan fungsionalitas dasar Material Design, seperti tema (ThemeData) dan navigasi.
- MyApp: Widget custom (Stateless) yang bertindak sebagai "root" aplikasi.
- MyHomePage: Widget custom (Stateless) yang mewakili seluruh halaman utama.
- Scaffold: Menyediakan struktur halaman yang standar, seperti appBar (bilah atas) dan body (isi halaman).
- AppBar: judul di bagian atas aplikasi.
- Padding: Memberikan jarak (padding) di sekeliling widget anaknya (Column).
- Column: Menyusun widget-widget anaknya (Row, SizedBox, Center) secara vertikal (dari atas ke bawah).
- Row: Menyusun widget-widget anaknya (InfoCard) secara horizontal (dari kiri ke kanan).
- InfoCard: Widget custom (Stateless) untuk menampilkan kotak info (NPM, Nama, Kelas).
- Card: Widget yang membuat tampilan "kartu" dengan sedikit bayangan dan sudut membulat.
- Container: Di InfoCard, mengatur lebar (width) dan padding internal.
- MediaQuery: Digunakan untuk mendapatkan informasi tentang layar (seperti MediaQuery.of(context).size.width untuk mendapatkan lebar layar).
- SizedBox: Sebuah kotak kosong yang tidak terlihatMmemberi jarak vertikal (height: 16.0) antar widget.
- Center: Mendorong widget anaknya ke tengah area yang tersedia.
- Text: Menampilkan string teks.
- GridView: Menyusun widget-widget anaknya dalam format grid (kisi). GridView.count untuk menentukan jumlah kolom (crossAxisCount: 3).
- ItemCard: Widget custom (Stateless) untuk setiap tombol di dalam GridView.
- Material: Widget dasar yang menyediakan "permukaan" material. Memberi warna (color) dan borderRadius pada ItemCard.
- InkWell: Membuat widget anaknya (Container di dalam ItemCard) menjadi tappable (bisa diklik) dan memberikan efek riak (ripple effect).
- ScaffoldMessenger: Pengelola untuk SnackBar. Memanggil .of(context).showSnackBar(...) untuk menampilkannya.
- SnackBar: Pesan popup sementara yang muncul di bagian bawah layar.
- Icon: Menampilkan sebuah ikon grafis (seperti Icons.shopping_bag).

3. Apa fungsi dari widget MaterialApp? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
MaterialApp adalah widget inti yang membungkus seluruh aplikasi bergaya Material Design. Fungsinya adalah menyediakan banyak fitur level atas yang diperlukan oleh widget-widget lain di bawahnya. Anggap saja MaterialApp sebagai "fondasi" rumah.
Mengapa sering digunakan sebagai root (akar)? Widget ini harus berada di puncak pohon widget karena ia menyediakan "konteks" (lihat poin BuildContext) yang krusial, seperti:
Tema (Theming): MaterialApp mengambil ThemeData dan menyebarkannya ke semua widget di bawahnya. Inilah sebabnya AppBar bisa tahu warna primary dan ItemCard tahu warna secondary tanpa diberi tahu satu per satu.
Navigasi (Routing): MaterialApp menyiapkan Navigator, yang memungkinkan untuk berpindah antar halaman (misalnya, Navigator.push).
Layanan Bawaan: Menyediakan fungsionalitas yang dibutuhkan oleh widget lain seperti Scaffold, Dialog, dan ScaffoldMessenger. Tanpa MaterialApp sebagai leluhur, memanggil ScaffoldMessenger.of(context).showSnackBar(...) akan gagal.

4. Jelaskan perbedaan antara StatelessWidget dan StatefulWidget. Kapan kamu memilih salah satunya?
- StatelessWidget (Widget Statis)
Adalah Widget yang tidak bisa berubah setelah dibuat.
Widget ini immutable. Tampilannya murni ditentukan oleh data (properti) yang diberikan saat membuatnya.
Contoh: Icon, Text, Padding.
Kapan digunakan? Gunakan ini sebanyak mungkin. Selalu buat widget sebagai StatelessWidget terlebih dahulu. Gunakan untuk UI yang tidak perlu mengelola data internal yang berubah.

- StatefulWidget (Widget Dinamis)
Adalah Widget yang bisa berubah selama runtime (saat aplikasi berjalan).
Widget ini mutable dan memiliki objek State internal untuk menyimpan data yang bisa berubah.
Bagaimana cara kerjanya? Ketika data di dalam State berubah (Anda harus memanggil fungsi setState()), Flutter akan secara otomatis membangun ulang (rebuild) widget tersebut dengan data yang baru.
Contoh: TextField (datanya berubah saat Anda mengetik), Checkbox (status dicentang/tidak), atau slider.
Kapan digunakan? Gunakan hanya jika Anda perlu widget tersebut "mengingat" sesuatu yang bisa berubah. Misalnya, jika Anda ingin membuat penghitung jumlah klik tombol, Anda perlu StatefulWidget untuk menyimpan angka hitungan tersebut.

5. Apa itu BuildContext dan mengapa penting di Flutter? Bagaimana penggunaannya di metode build?
BuildContext adalah "alamat" untuk sebuah widget di dalam Widget Tree.
Setiap widget yang dibuat melalui metode build mendapatkan BuildContext-nya sendiri. BuildContext ini memberi tahu widget tersebut secara persis di mana lokasinya di dalam widget tree.
Penggunaannya di metode build: Metode build Anda memiliki tanda Widget build(BuildContext context). context inilah alamatnya.

6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
Hot Reload : Menyuntikkan pembaruan kode ke dalam Dart Virtual Machine (VM) yang sedang berjalan. UI diperbarui sesuai dengan perubahandalam hitungan milidetik. State aplikasi tetap terjaga. 
Hot Restart : Mematikan Dart VM yang ada dan memulai yang baru. Ini akan menjalankan ulang seluruh aplikasi dari awal (mulai dari main()). State aplikasi di-reset. Digunakan ketika perubahan Anda terlalu besar untuk Hot Reload. Contoh paling umum adalah jika Anda mengubah constructor dari StatefulWidget atau mengubah data static.

Tugas 8:
1. Perbedaan Navigator.push() dan Navigator.pushReplacement()

- `Navigator.push()` menambahkan route baru ke dalam stack navigasi, sehingga route sebelumnya tetap ada dan user dapat kembali ke route sebelumnya dengan tombol back. 

- `Navigator.pushReplacement()` mengganti route saat ini dengan route baru, menghapus route sebelumnya dari stack sehingga user tidak dapat kembali ke route sebelumnya.

Penggunaan dalam aplikasi Toko Kaki Bola:
- `Navigator.push()` digunakan ketika menekan tombol "Create Product" dari halaman utama, karena kita ingin pengguna bisa kembali ke halaman utama.
- `Navigator.pushReplacement()` digunakan dalam drawer dan setelah menyimpan produk, karena kita ingin mengganti halaman saat ini sepenuhnya.

2. Pemanfaatan Hierarchy Widget

Struktur hierarchy widget yang konsisten dibangun dengan:
- Scaffold sebagai kerangka dasar setiap halaman
- AppBar dengan warna tema konsisten
- Drawer yang reusable di kedua halaman untuk navigasi
- Body yang menampung konten utama dengan layout yang konsisten

Dengan struktur ini, konsistensi UI/UX terjaga di seluruh aplikasi.

3. Kelebihan Layout Widget


Padding: Memberikan ruang kosong di sekitar widget, meningkatkan readability.
Padding(
  padding: const EdgeInsets.all(16.0),
  child: Form(...)
)
SingleChildScrollView: Memungkinkan konten di-scroll jika melebihi layar.
SingleChildScrollView(
  child: Column(...)
)
ListView: Ideal untuk daftar elemen yang bisa di-scroll secara efisien.
ListView(
  children: []
)

4. Penyesuaian Warna Tema
Warna tema disesuaikan melalui:

theme: ThemeData(
         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green).copyWith(secondary: Colors.greenAccent[400]),
      ),

Tugas 9:
1. Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan Map<String, dynamic> tanpa model (terkait validasi tipe, null-safety, maintainability)?
Tanpa model: Map<String, dynamic> → Typo 'price' jadi 'prices' = crash runtime, price: data['price'] bisa null = errorNull safety, berakibat pada refactoring manual banyak file.
Dengan model: Compile-time error, null-safety terjamin (price: json['price'] ?? 0), refactoring sekali di 1 file (fromJson()).
Konsekuensi: Tanpa model = sulit maintain, debug lambat, rentan bug. Dengan model = scalable, aman, IDE support lengkap.

2. Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest.
package:http:
Low-level, manual semua (cookie, header, CSRF)
Cocok API publik tanpa autentikasi
Contoh: await http.get(Uri.parse(url))
CookieRequest (pbp_django_auth):
Otomatis handle session cookie Django
Simpan cookie saat login, kirim ulang otomatis
Khusus untuk Django session-based auth
Perbedaan Inti: http universal tapi manual, CookieRequest spesialisasi Django tapi otomatis.

3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Alasan Utama:
Cookie persistence: Cookie login disimpan di 1 instance. Instance baru = cookie hilang → unauthorized.
State reactivity: context.watch<CookieRequest>() → widget rebuild otomatis saat login/logout
Performance: Satu koneksi reuse, tidak perlu inisiasi ulang

4. Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
Konfigurasi	:
- Tujuan	
- Konsekuensi Tanpa
ALLOWED_HOSTS = ['10.0.2.2'] :	
- Izinkan request dari emulator Android	
- DisallowedHost error
CORS_ALLOWED_ORIGINS:	
- Izinkan cross-origin (Flutter Web)	
- Browser block request
SESSION_COOKIE_SAMESITE = 'None':	
- Kirim cookie di cross-origin	
- Auth gagal (cookie tidak terkirim)
<uses-permission android:name="android.permission.INTERNET"/>	:
- Izinkan akses internet di Android	
- SocketException

5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
Input → Django:
// 1. User ketik di TextField
// 2. _formKey.currentState!.validate()
// 3. request.postJson(url, jsonEncode({'name': 'Sepatu', 'price': 150000}))
// 4. HTTP POST dengan cookie sessionid otomatis
Django → Database:
// 5. Django: @csrf_exempt → parse JSON → Product() → .save()
Display:
// 6. FutureBuilder → request.get(url) → JSON
// 7. ProductEntry.fromJson() → List<ProductEntry>
// 8. ListView.builder → ProductEntryCard

6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
Register:
Flutter (POST username/password) → Django UserCreationForm → create User → return success
Login:
Flutter (POST credentials) → Django authenticate() + login() → create session → kirim cookie sessionid → CookieRequest simpan cookie
Authenticated Request:
CookieRequest otomatis kirim cookie → Django @login_required cek session → request.user terisi → return user-specific data
Logout:
Django logout() → hapus session & cookie → CookieRequest.clear() → hapus cookie dari memory → Flutter navigasi ke login

7. Jelaskan bagaimana cara kamu mengimplementasikan checklist di atas secara step-by-step! (bukan hanya sekadar mengikuti tutorial).
- Membuat endpoint autentikasi berupa login, register dan logout
- Membuat model baru dengan quicktype dari JSON endpoint dari website django. 
- Menghubungkan flutter dengan link destinasi website django untuk menerapkan fetch data produk-produk dan menerapkan post data untuk create product baru.
- Melakukan perapihan untuk menambah halaman-halaman baru seperti product entry list dan product form. Menyambungnya dengan halaman yang dibuat pada tugas-tugas sebelumnya 
