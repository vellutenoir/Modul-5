import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/layanan.dart';

class ItemPengajuan {
  const ItemPengajuan({
    required this.layanan,
    required this.waktuPengajuan,
    this.status = 'Menunggu Verifikasi Dinas',
  });

  final Layanan layanan;
  final DateTime waktuPengajuan;
  final String status;
}

class PengajuanCubit extends Cubit<List<ItemPengajuan>> {
  PengajuanCubit() : super(const []);

  int get totalPengajuan => state.length;

  bool sudahDiajukan(String namaLayanan) {
    return state.any((item) => item.layanan.nama == namaLayanan);
  }

  void tambahPengajuan(Layanan layanan) {
    final daftarBaru = List<ItemPengajuan>.from(state)
      ..insert(
        0,
        ItemPengajuan(
          layanan: layanan,
          waktuPengajuan: DateTime.now(),
        ),
      );
    emit(daftarBaru);
  }

  void batalkanPengajuan(int index) {
    if (index < 0 || index >= state.length) return;
    final daftarBaru = List<ItemPengajuan>.from(state)..removeAt(index);
    emit(daftarBaru);
  }

  void kirimSemuaKeDinas() {
    if (state.isEmpty) return;
    final daftarTerkirim = state
        .map(
          (item) => ItemPengajuan(
            layanan: item.layanan,
            waktuPengajuan: item.waktuPengajuan,
            status: 'Terkirim ke Dinas Terkait',
          ),
        )
        .toList();
    emit(daftarTerkirim);
  }

  void kosongkanPengajuan() {
    emit(const []);
  }
}
