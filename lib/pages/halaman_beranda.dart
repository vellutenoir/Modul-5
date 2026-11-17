import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../models/layanan.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({
    super.key,
    required this.onPindahTab,
  });

  final ValueChanged<int> onPindahTab;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final jumlahFavorit = context.select<FavoritCubit, int>((c) => c.state.length);
    final jumlahPengajuan =
        context.select<PengajuanCubit, int>((c) => c.totalPengajuan);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.tertiary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.location_city, color: colorScheme.onPrimary, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    'Portal Balai Kota Cerdas',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colorScheme.onPrimary.withOpacity(0.9),
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Selamat Datang di Nusantara Cerdas Mobile',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tandai layanan favorit dan ajukan beberapa permohonan layanan warga dalam satu kali kunjungan terpadu.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimary.withOpacity(0.92),
                    ),
              ),
              const SizedBox(height: 16),
              FilledButton.tonalIcon(
                onPressed: () => onPindahTab(1),
                icon: const Icon(Icons.explore_outlined),
                label: const Text('Jelajahi Layanan Warga'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Ringkasan Aktivitas Warga',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _KartuRingkasan(
                ikon: Icons.apps_rounded,
                judul: 'Total Layanan',
                nilai: '${Layanan.daftarLayanan.length}',
                warna: colorScheme.primary,
                onTap: () => onPindahTab(1),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _KartuRingkasan(
                ikon: Icons.star_rounded,
                judul: 'Layanan Favorit',
                nilai: '$jumlahFavorit',
                warna: Colors.amber.shade800,
                onTap: () => onPindahTab(2),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _KartuRingkasan(
                ikon: Icons.assignment_outlined,
                judul: 'Pengajuan',
                nilai: '$jumlahPengajuan',
                warna: colorScheme.tertiary,
                onTap: () => onPindahTab(2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Bidang Layanan Utama',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 10),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.assignment_turned_in_outlined),
                title: const Text('Bidang Perizinan'),
                subtitle: const Text('IUMK, PBG, dan Izin Acara Publik'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => onPindahTab(1),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.local_hospital_outlined),
                title: const Text('Bidang Kesehatan'),
                subtitle: const Text('Antrean Puskesmas, Ambulans 119, Surat Sehat'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => onPindahTab(1),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.directions_bus_outlined),
                title: const Text('Bidang Transportasi'),
                subtitle: const Text('Kartu Bus Cerdas, Uji Kir, Rambu Jalan'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => onPindahTab(1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _KartuRingkasan extends StatelessWidget {
  const _KartuRingkasan({
    required this.ikon,
    required this.judul,
    required this.nilai,
    required this.warna,
    required this.onTap,
  });

  final IconData ikon;
  final String judul;
  final String nilai;
  final Color warna;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          child: Column(
            children: [
              Icon(ikon, color: warna, size: 26),
              const SizedBox(height: 6),
              Text(
                nilai,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: warna,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                judul,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
