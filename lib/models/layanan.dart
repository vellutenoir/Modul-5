import 'package:flutter/foundation.dart';

@immutable
class Layanan {
  const Layanan({
    required this.id,
    required this.nama,
    required this.bidang,
    required this.deskripsi,
    required this.estimasiWaktu,
    required this.persyaratan,
  });

  final String id;
  final String nama;
  final String bidang; // 'Perizinan', 'Kesehatan', 'Transportasi'
  final String deskripsi;
  final String estimasiWaktu;
  final List<String> persyaratan;

  static const List<Layanan> daftarLayanan = [
    // Bidang Perizinan
    Layanan(
      id: 'PRZ-01',
      nama: 'Izin Usaha Mikro (IUMK)',
      bidang: 'Perizinan',
      deskripsi:
          'Penerbitan legalitas usaha mikro dan kecil bagi pelaku UMKM warga kota secara terpadu.',
      estimasiWaktu: '1 Hari Kerja',
      persyaratan: [
        'KTP Elektronik Pemohon',
        'Kartu Keluarga (KK)',
        'Surat Pengantar RT/RW atau Kelurahan',
        'Foto Tempat Usaha',
      ],
    ),
    Layanan(
      id: 'PRZ-02',
      nama: 'Persetujuan Bangunan Gedung (PBG)',
      bidang: 'Perizinan',
      deskripsi:
          'Perizinan kelayakan konstruksi dan tata ruang untuk pembangunan atau renovasi bangunan.',
      estimasiWaktu: '5 Hari Kerja',
      persyaratan: [
        'Sertifikat Hak Milik / Bukti Kepemilikan Tanah',
        'Gambar Teknis Arsitektur Bangunan',
        'KTP Pemohon & NPWP',
      ],
    ),
    Layanan(
      id: 'PRZ-03',
      nama: 'Izin Keramaian & Acara Publik',
      bidang: 'Perizinan',
      deskripsi:
          'Rekomendasi penyelenggaraan kegiatan sosial, budaya, dan bazar warga di ruang publik.',
      estimasiWaktu: '2 Hari Kerja',
      persyaratan: [
        'Proposal Kegiatan Lengkap',
        'KTP Penanggung Jawab Acara',
        'Surat Izin Penggunaan Lokasi',
      ],
    ),

    // Bidang Kesehatan
    Layanan(
      id: 'KES-01',
      nama: 'Antrean Puskesmas Digital',
      bidang: 'Kesehatan',
      deskripsi:
          'Pendaftaran poli umum, poli gigi, dan KIA di seluruh Puskesmas kecamatan tanpa antre fisik.',
      estimasiWaktu: 'Real-time',
      persyaratan: [
        'NIK / KTP Pasien',
        'Kartu BPJS Kesehatan (jika ada)',
      ],
    ),
    Layanan(
      id: 'KES-02',
      nama: 'Layanan Ambulans Siaga 119',
      bidang: 'Kesehatan',
      deskripsi:
          'Permintaan penjemputan darurat medis maupun rujukan antar fasilitas kesehatan kota.',
      estimasiWaktu: '15 Menit Respon',
      persyaratan: [
        'Titik Lokasi Penjemputan Akurat',
        'Nomor Telepon Aktif Pelapor',
        'Keterangan Kondisi Pasien',
      ],
    ),
    Layanan(
      id: 'KES-03',
      nama: 'Surat Keterangan Sehat & Bebas Narkoba',
      bidang: 'Kesehatan',
      deskripsi:
          'Pengajuan pemeriksaan kesehatan resmi untuk keperluan melamar pekerjaan atau pendidikan.',
      estimasiWaktu: '1 Hari Kerja',
      persyaratan: [
        'KTP Asli Pemohon',
        'Pas Foto 3x4 (2 Lembar)',
      ],
    ),

    // Bidang Transportasi
    Layanan(
      id: 'TRN-01',
      nama: 'Kartu Langganan Bus Kota Cerdas',
      bidang: 'Transportasi',
      deskripsi:
          'Registrasi tarif integrasi khusus pelajar, mahasiswa, lansia, dan pekerja untuk Bus Trans Kota.',
      estimasiWaktu: '2 Hari Kerja',
      persyaratan: [
        'KTP / Kartu Pelajar / KTM',
        'Swafoto Terbaru',
      ],
    ),
    Layanan(
      id: 'TRN-02',
      nama: 'Uji Kir Kendaraan Angkutan Umum',
      bidang: 'Transportasi',
      deskripsi:
          'Penjadwalan pengujian berkala kelayakan jalan kendaraan angkutan penumpang dan barang.',
      estimasiWaktu: '1 Hari Kerja',
      persyaratan: [
        'STNK & BPKB Asli',
        'Buku Uji Berkala Sebelumnya',
        'KTP Pemilik Kendaraan',
      ],
    ),
    Layanan(
      id: 'TRN-03',
      nama: 'Permohonan Rambu & Marka Jalan Lingkungan',
      bidang: 'Transportasi',
      deskripsi:
          'Usulan pemasangan cermin tikungan, zebra cross, dan rambu batas kecepatan di kawasan pemukiman.',
      estimasiWaktu: '7 Hari Kerja',
      persyaratan: [
        'Surat Permohonan Warga / Pengurus RW',
        'Foto Kondisi Titik Jalan Usulan',
      ],
    ),
  ];
}
