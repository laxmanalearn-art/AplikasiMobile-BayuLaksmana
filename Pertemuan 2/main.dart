// =============================================
// HW 2 - Perpustakaan
// Nama : Bayu Laksmana
// NIM  : [1124160070]
// Kelas: TISE24SH
// =============================================

// ---------- ABSTRACTION ----------

enum StatusBuku { tersedia, dipinjam }

class Buku {
  // Atribut yang penting untuk masalah perpustakaan
  String id;
  String judul;
  StatusBuku status;

  Buku({required this.id, required this.judul, required this.status});
}

class Anggota {
  // Atribut yang penting untuk masalah perpustakaan
  String id;
  String nama;
  List<String> idBukuDipinjam;

  Anggota({required this.id, required this.nama, required this.idBukuDipinjam});
}

// ---------- DATA ----------

// Daftar buku perpustakaan
List<Buku> daftarBuku = [
  Buku(id: 'B001', judul: 'Pengantar Filsafat', status: StatusBuku.tersedia),
  Buku(id: 'B002', judul: 'Filsafat Yunani Kuno', status: StatusBuku.tersedia),
  Buku(id: 'B003', judul: 'Etika dan Moral', status: StatusBuku.tersedia),
  Buku(
    id: 'B004',
    judul: 'Filsafat Eksistensialisme',
    status: StatusBuku.tersedia,
  ),
  Buku(id: 'B005', judul: 'Filsafat Stoikisme', status: StatusBuku.tersedia),
];

// Daftar anggota perpustakaan
List<Anggota> daftarAnggota = [
  Anggota(id: 'A001', nama: 'Bayu', idBukuDipinjam: []),
  Anggota(id: 'A002', nama: 'Andi', idBukuDipinjam: []),
];

// ---------- DECOMPOSITION ----------

// Mencari buku berdasarkan ID
Buku? cariBuku(String idBuku) {
  for (Buku buku in daftarBuku) {
    if (buku.id == idBuku) {
      return buku;
    }
  }

  return null;
}

// Mencari anggota berdasarkan ID
Anggota? cariAnggota(String idAnggota) {
  for (Anggota anggota in daftarAnggota) {
    if (anggota.id == idAnggota) {
      return anggota;
    }
  }

  return null;
}

// BR-01 dan BR-02
// Memeriksa kelayakan peminjaman
bool cekKelayakanPinjam(Anggota anggota, Buku buku) {
  // BR-01:
  // Anggota maksimal meminjam 3 buku
  if (anggota.idBukuDipinjam.length >= 3) {
    return false;
  }

  // BR-02:
  // Buku yang sedang dipinjam tidak dapat dipinjam lagi
  if (buku.status == StatusBuku.dipinjam) {
    return false;
  }

  return true;
}

// Memproses peminjaman buku
bool pinjamBuku(Anggota anggota, String idBuku) {
  // Mencari buku berdasarkan ID
  Buku? buku = cariBuku(idBuku);

  // Jika buku tidak ditemukan
  if (buku == null) {
    return false;
  }

  // Memeriksa kelayakan peminjaman
  if (!cekKelayakanPinjam(anggota, buku)) {
    return false;
  }

  // Mengubah status buku menjadi dipinjam
  buku.status = StatusBuku.dipinjam;

  // Menambahkan buku ke daftar pinjaman anggota
  anggota.idBukuDipinjam.add(buku.id);

  return true;
}

// BR-04
// Memproses pengembalian buku
bool kembalikanBuku(Anggota anggota, String idBuku) {
  // Mencari buku berdasarkan ID
  Buku? buku = cariBuku(idBuku);

  // Jika buku tidak ditemukan
  if (buku == null) {
    return false;
  }

  // BR-04:
  // Buku hanya dapat dikembalikan
  // jika statusnya sedang dipinjam
  if (buku.status != StatusBuku.dipinjam) {
    return false;
  }

  // Memastikan buku memang dipinjam oleh anggota tersebut
  if (!anggota.idBukuDipinjam.contains(buku.id)) {
    return false;
  }

  // Mengubah status buku menjadi tersedia
  buku.status = StatusBuku.tersedia;

  // Menghapus buku dari daftar pinjaman anggota
  anggota.idBukuDipinjam.remove(buku.id);

  return true;
}

// BR-03
// Menghitung denda keterlambatan
int hitungDenda(int hariTerlambat) {
  // BR-03:
  // Denda adalah Rp1.000 per hari
  return hariTerlambat * 1000;
}

// Menampilkan hasil transaksi
void tampilkanHasil(
  String jenisTransaksi,
  Anggota anggota,
  Buku? buku,
  bool berhasil,
) {
  print('------------------------------------------');
  print('HASIL TRANSAKSI');
  print('------------------------------------------');

  print('Anggota       : ${anggota.nama}');
  print('ID Anggota    : ${anggota.id}');

  if (buku != null) {
    print('ID Buku       : ${buku.id}');
    print('Judul Buku    : ${buku.judul}');
    print('Status Buku   : ${buku.status.name}');
  }

  print('Transaksi     : $jenisTransaksi');

  if (berhasil) {
    print('Hasil         : BERHASIL');
  } else {
    print('Hasil         : GAGAL');
  }

  print(
    'Buku Dipinjam : '
    '${anggota.idBukuDipinjam.length}/3',
  );

  print('------------------------------------------');
}

// ---------- ALGORITHM ----------

// Proses utama mengikuti urutan pseudocode:
// 1. Mengambil data anggota.
// 2. Mencari buku berdasarkan ID.
// 3. Memeriksa business rule.
// 4. Memproses peminjaman atau pengembalian.
// 5. Menghitung denda jika terdapat keterlambatan.
// 6. Menampilkan hasil transaksi.

// ---------- TEST SCENARIO ----------

void main() {
  // Mengambil anggota dari daftar anggota
  Anggota anggotaBayu = daftarAnggota[0];
  Anggota anggotaAndi = daftarAnggota[1];

  print('==========================================');
  print('       SISTEM PERPUSTAKAAN');
  print('==========================================');

  // ========================================
  // SKENARIO 1 - PEMINJAMAN BERHASIL
  // ========================================

  print('\n[SKENARIO 1]');
  print('Bayu meminjam buku yang tersedia');

  Buku? buku1 = cariBuku('B001');

  bool hasil1 = pinjamBuku(anggotaBayu, 'B001');

  tampilkanHasil('Peminjaman', anggotaBayu, buku1, hasil1);

  // Expected:
  // Anggota       : Bayu
  // ID Buku       : B001
  // Judul Buku    : Pengantar Filsafat
  // Hasil         : BERHASIL
  // Buku Dipinjam : 1/3

  // ========================================
  // SKENARIO 2 - GAGAL BR-02
  // ========================================

  print('\n[SKENARIO 2]');
  print('Andi mencoba meminjam B001 yang sedang dipinjam Bayu');

  Buku? buku2 = cariBuku('B001');

  bool hasil2 = pinjamBuku(anggotaAndi, 'B001');

  tampilkanHasil('Peminjaman', anggotaAndi, buku2, hasil2);

  // Expected:
  // Anggota       : Andi
  // ID Buku       : B001
  // Judul Buku    : Pengantar Filsafat
  // Hasil         : GAGAL
  // Penyebab      : Buku sedang dipinjam
  // Business Rule : BR-02

  // ========================================
  // SKENARIO 3 - PEMINJAMAN BERHASIL
  // ========================================

  print('\n[SKENARIO 3]');
  print('Bayu meminjam buku kedua');

  Buku? buku3 = cariBuku('B002');

  bool hasil3 = pinjamBuku(anggotaBayu, 'B002');

  tampilkanHasil('Peminjaman', anggotaBayu, buku3, hasil3);

  // Expected:
  // Judul Buku    : Filsafat Yunani Kuno
  // Hasil         : BERHASIL
  // Buku Dipinjam : 2/3

  // ========================================
  // SKENARIO 4 - PEMINJAMAN BERHASIL
  // ========================================

  print('\n[SKENARIO 4]');
  print('Bayu meminjam buku ketiga');

  Buku? buku4 = cariBuku('B003');

  bool hasil4 = pinjamBuku(anggotaBayu, 'B003');

  tampilkanHasil('Peminjaman', anggotaBayu, buku4, hasil4);

  // Expected:
  // Judul Buku    : Etika dan Moral
  // Hasil         : BERHASIL
  // Buku Dipinjam : 3/3

  // ========================================
  // SKENARIO 5 - GAGAL BR-01
  // ========================================

  print('\n[SKENARIO 5]');
  print('Bayu mencoba meminjam buku keempat');

  Buku? buku5 = cariBuku('B004');

  bool hasil5 = pinjamBuku(anggotaBayu, 'B004');

  tampilkanHasil('Peminjaman', anggotaBayu, buku5, hasil5);

  // Expected:
  // Judul Buku    : Filsafat Eksistensialisme
  // Hasil         : GAGAL
  // Penyebab      : Maksimal 3 buku
  // Business Rule : BR-01
  // Buku Dipinjam : 3/3

  // ========================================
  // SKENARIO 6 - PENGEMBALIAN + BR-03
  // ========================================

  print('\n[SKENARIO 6]');
  print('Bayu mengembalikan B001 dengan keterlambatan 2 hari');

  Buku? buku6 = cariBuku('B001');

  bool hasil6 = kembalikanBuku(anggotaBayu, 'B001');

  tampilkanHasil('Pengembalian', anggotaBayu, buku6, hasil6);

  if (hasil6) {
    int hariTerlambat = 2;
    int denda = hitungDenda(hariTerlambat);

    print('Hari Terlambat: $hariTerlambat hari');
    print('Denda         : Rp$denda');
  }

  // Expected:
  // Judul Buku    : Pengantar Filsafat
  // Hasil         : BERHASIL
  // Buku Dipinjam : 2/3
  // Hari Terlambat: 2 hari
  // Denda         : Rp2000
  // Business Rule : BR-03

  // ========================================
  // SKENARIO 7 - GAGAL BR-04
  // ========================================

  print('\n[SKENARIO 7]');
  print('Bayu mengembalikan B001 yang sudah tersedia');

  Buku? buku7 = cariBuku('B001');

  bool hasil7 = kembalikanBuku(anggotaBayu, 'B001');

  tampilkanHasil('Pengembalian', anggotaBayu, buku7, hasil7);

  // Expected:
  // Judul Buku    : Pengantar Filsafat
  // Status Buku   : tersedia
  // Hasil         : GAGAL
  // Penyebab      : Buku tidak sedang dipinjam
  // Business Rule : BR-04

  // ========================================
  // SKENARIO 8 - ANGGOTA KEDUA BERHASIL
  // ========================================

  print('\n[SKENARIO 8]');
  print('Andi meminjam B001 setelah dikembalikan Bayu');

  Buku? buku8 = cariBuku('B001');

  bool hasil8 = pinjamBuku(anggotaAndi, 'B001');

  tampilkanHasil('Peminjaman', anggotaAndi, buku8, hasil8);

  // Expected:
  // Anggota       : Andi
  // ID Buku       : B001
  // Judul Buku    : Pengantar Filsafat
  // Hasil         : BERHASIL
  // Buku Dipinjam : 1/3

  // ========================================
  // SELESAI
  // ========================================

  print('\n==========================================');
  print('          PENGUJIAN SELESAI');
  print('==========================================');
}
