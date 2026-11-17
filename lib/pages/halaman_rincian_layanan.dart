import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class HalamanRincianLayanan extends StatefulWidget {
  const HalamanRincianLayanan({super.key});

  @override
  State<HalamanRincianLayanan> createState() => _HalamanRincianLayananState();
}

class _HalamanRincianLayananState extends State<HalamanRincianLayanan> {
  // State lokal menggunakan setState() untuk indikator sedang mengirim
  bool _sedangMengirim = false;

  Future<void> _prosesPengajuan(Layanan layanan) async {
    if (_sedangMengirim) return;

    setState(() {
      _sedangMengirim = true;
    });

    // Simulasi proses pengiriman permohonan sesaat agar mencegah klik ganda
    await Future.delayed(const Duration(milliseconds: 900));

    if (!mounted) return;

    context.read<PengajuanCubit>().tambahPengajuan(layanan);

    setState(() {
      _sedangMengirim = false;
    });

    Navigator.pop(
      context,
      'Permohonan "${layanan.nama}" ditambahkan ke daftar pengajuan.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final layanan = args is Layanan ? args : Layanan.daftarLayanan.first;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rincian Layanan'),
        actions: [
          BlocSelector<FavoritCubit, Set<String>, bool>(
            selector: (favoritSet) => favoritSet.contains(layanan.nama),
            builder: (context, isFavorit) {
              return IconButton(
                tooltip: isFavorit ? 'Batal Favorit' : 'Tandai Favorit',
                onPressed: () {
                  context.read<FavoritCubit>().toggleFavorit(layanan.nama);
                },
                icon: Icon(
                  isFavorit ? Icons.star_rounded : Icons.star_outline_rounded,
                  color: isFavorit ? Colors.amber.shade700 : null,
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text('Bidang ${layanan.bidang}'),
                  backgroundColor: colorScheme.surface,
                ),
                const SizedBox(height: 8),
                Text(
                  layanan.nama,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onPrimaryContainer,
                      ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 18,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Estimasi Penyelesaian: ${layanan.estimasiWaktu}',
                      style: TextStyle(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Deskripsi Layanan',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            layanan.deskripsi,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 18),
          Text(
            'Persyaratan Dokumen',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
              side: BorderSide(color: colorScheme.outlineVariant),
            ),
            child: Column(
              children: layanan.persyaratan.map((syarat) {
                return ListTile(
                  leading: Icon(
                    Icons.check_circle_outline,
                    color: colorScheme.primary,
                  ),
                  title: Text(syarat),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FilledButton.icon(
            onPressed: _sedangMengirim ? null : () => _prosesPengajuan(layanan),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            icon: _sedangMengirim
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : const Icon(Icons.send_rounded),
            label: Text(
              _sedangMengirim ? 'Sedang mengirim...' : 'Ajukan Permohonan',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
