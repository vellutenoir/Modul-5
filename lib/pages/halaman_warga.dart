import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../app_routes.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  String _formatWaktu(DateTime dt) {
    final jam = dt.hour.toString().padLeft(2, '0');
    final menit = dt.minute.toString().padLeft(2, '0');
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} $jam:$menit';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Profil Warga Singkat
        Card(
          elevation: 0,
          color: colorScheme.secondaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: const Icon(Icons.person),
            ),
            title: const Text(
              'Vayola Aura Mecca',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('NIK/ID Warga: 707012400012 • Warga Terverifikasi'),
          ),
        ),
        const SizedBox(height: 20),

        // Bagian 1: Layanan Favorit (Reaktif lintas tab bidang)
        Row(
          children: [
            Icon(Icons.star_rounded, color: Colors.amber.shade700),
            const SizedBox(width: 8),
            Text(
              'Layanan Favorit Saya',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<FavoritCubit, Set<String>>(
          builder: (context, favoritSet) {
            if (favoritSet.isEmpty) {
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: colorScheme.outlineVariant),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.star_border_rounded, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Belum ada layanan favorit. Tekan ikon bintang pada menu Layanan untuk menyimpannya di sini.',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final layananFavorit = Layanan.daftarLayanan
                .where((l) => favoritSet.contains(l.nama))
                .toList();

            return Column(
              children: layananFavorit.map((layanan) {
                return Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: BorderSide(color: colorScheme.outlineVariant),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.star_rounded, color: Colors.amber.shade700),
                    title: Text(
                      layanan.nama,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text('Bidang ${layanan.bidang} • ${layanan.estimasiWaktu}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'Buka Rincian',
                          icon: const Icon(Icons.open_in_new),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.rincianLayanan,
                              arguments: layanan,
                            );
                          },
                        ),
                        IconButton(
                          tooltip: 'Hapus Favorit',
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () {
                            context.read<FavoritCubit>().batalTandai(layanan.nama);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20),

        // Bagian 2: Daftar Keranjang Pengajuan Layanan
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.assignment_turned_in, color: colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Daftar Pengajuan Layanan',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        BlocBuilder<PengajuanCubit, List<ItemPengajuan>>(
          builder: (context, daftarPengajuan) {
            if (daftarPengajuan.isEmpty) {
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                  side: BorderSide(color: colorScheme.outlineVariant),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.inbox_outlined, size: 28),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Keranjang pengajuan masih kosong. Pilih layanan lalu tekan "Ajukan Permohonan" pada halaman rincian.',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ...List.generate(daftarPengajuan.length, (index) {
                  final item = daftarPengajuan[index];
                  final sudahTerkirim =
                      item.status == 'Terkirim ke Dinas Terkait';

                  return Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(color: colorScheme.outlineVariant),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: sudahTerkirim
                            ? Colors.green.withOpacity(0.15)
                            : colorScheme.primaryContainer,
                        child: Icon(
                          sudahTerkirim
                              ? Icons.check_circle_outline
                              : Icons.pending_actions,
                          color: sudahTerkirim
                              ? Colors.green.shade700
                              : colorScheme.primary,
                        ),
                      ),
                      title: Text(
                        item.layanan.nama,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        '${item.layanan.bidang} • ${item.status}\nWaktu: ${_formatWaktu(item.waktuPengajuan)}',
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        tooltip: 'Batalkan Pengajuan',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context.read<PengajuanCubit>().batalkanPengajuan(index);
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          context.read<PengajuanCubit>().kosongkanPengajuan();
                        },
                        icon: const Icon(Icons.delete_sweep_outlined),
                        label: const Text('Kosongkan'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: FilledButton.icon(
                        onPressed: () {
                          context.read<PengajuanCubit>().kirimSemuaKeDinas();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Seluruh permohonan berhasil dikirim ke dinas terkait!',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.send_rounded),
                        label: Text('Kirim Semua (${daftarPengajuan.length})'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
