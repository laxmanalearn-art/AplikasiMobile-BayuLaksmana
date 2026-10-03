void main() {
  // 1. CONST
  // Nilai yang sifatnya tetap

  const String namaAplikasi = 'MOVIE BOX';
  const String versiAplikasi = '1.0.0';
  const String negara = 'Indonesia';

  // 2. FINAL
  // Nilai hanya diberikan satu kali
  final String namaPengguna = 'Bayu';
  final DateTime waktuAkses = DateTime.now();
  // 3. DATA FILM
  String judulFilm = 'Interstellar';
  int tahunRilis = 2014;
  double ratingFilm = 8.7;
  String genreFilm = 'Sci-Fi';
  // 4. BOOL
  // Status film
  bool filmTersedia = true;
  bool sudahDitonton = false;
  // 5. LATE
  // Data yang akan diberikan kemudian
  late String statusFilm;

  if (sudahDitonton) {
    statusFilm = 'Sudah Ditonton';
  } else {
    statusFilm = 'Belum Ditonton';
  }
  // 6. LIST
  // Daftar judul film

  List<String> daftarFilm = [
    'Interstellar',
    'Inception',
    'The Dark Knight',
    'The Prestige',
  ];
  // 7. SET
  // Daftar genre
  Set<String> daftarGenre = {
    'Sci-Fi',
    'Action',
    'Drama',
    'Thriller',
    'Sci-Fi',
  };
  // 8. MAP
  // Menyimpan informasi sebuah film
  Map<String, dynamic> film = {
    'judul': judulFilm,
    'tahun': tahunRilis,
    'rating': ratingFilm,
    'genre': genreFilm,
    'tersedia': filmTersedia,
  };
  // 9. PERHITUNGAN
  int jumlahFilm = daftarFilm.length;
  int jumlahGenre = daftarGenre.length;
  // 10. OUTPUT

  print('==========================================');
  print('              $namaAplikasi');
  print('           Versi $versiAplikasi');
  print('==========================================');

  print('Pengguna       : $namaPengguna');
  print('Waktu Akses    : $waktuAkses');
  print('Negara         : $negara');

  print('------------------------------------------');

  print('FILM PILIHAN');
  print('Judul          : ${film['judul']}');
  print('Tahun Rilis    : ${film['tahun']}');
  print('Rating         : ${film['rating']}');
  print('Genre          : ${film['genre']}');

  print('------------------------------------------');


  // =========================================================
  // 11. IF / ELSE
  // Mengecek ketersediaan film
  // =========================================================

  if (filmTersedia) {
    print('Status Film    : TERSEDIA');
  } else {
    print('Status Film    : TIDAK TERSEDIA');
  }


  // =========================================================
  // 12. STATUS TONTON
  // =========================================================

  print('Status Tonton  : $statusFilm');


  // =========================================================
  // 13. INFORMASI KATALOG
  // =========================================================

  print('------------------------------------------');

  print('Jumlah Film    : $jumlahFilm');
  print('Jumlah Genre   : $jumlahGenre');

  print('Daftar Film    : $daftarFilm');
  print('Daftar Genre   : $daftarGenre');

  print('==========================================');
  print('       Selamat menonton, $namaPengguna!');
  print('==========================================');
}
